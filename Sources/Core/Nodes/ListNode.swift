//
//  ListNode.swift
//  TexturedMaaku
//
//  Created by Kris Baker on 12/20/17.
//  Copyright © 2016 Kristopher Baker. All rights reserved.
//

import AsyncDisplayKit
import Maaku
import UIKit

/// Represents a markdown list as an ASDisplayNode.
public class ListNode: ASDisplayNode, ASTextNodeDelegate, Linkable, LinkDelegate {

    /// The link delegate.
    public weak var linkDelegate: LinkDelegate?

    /// The insets.
    private let insets: UIEdgeInsets

    /// Indicates if the node is nested.
    private let nested: Bool

    /// The child layout elements (list items).
    private var children = [ASLayoutElement]()

    /// Initializes a ListNode with the specified items, ordering, and style.
    ///
    /// - Parameters:
    ///     - list: The list.
    ///     - style: The document style.
    ///     - nested: Indicates if the node is nested.
    /// - Returns:
    ///     The initialized ListNode.
    public init(list: List, style: DocumentStyle, nested: Bool = false) {
        insets = style.insets.list
        self.nested = nested
        super.init()

        automaticallyManagesSubnodes = true
        setupList(list, ordered: list is OrderedList, style: style)
    }

    /// Configures the specified list.
    ///
    /// - Parameters:
    ///     - list: The list.
    ///     - ordered: Indicates if the list ordered or bulleted.
    ///     - style: The document style.
    public func setupList(_ list: List, ordered: Bool, style: DocumentStyle) {
        let paragraphFont = style.maakuStyle.fonts.paragraph

        let attribs: [NSAttributedString.Key: Any] = [
            .foregroundColor: style.maakuStyle.colors.paragraph,
            .font: UIFont.monospacedDigitSystemFont(ofSize: paragraphFont.pointSize, weight: .regular)
        ]

        for (index, item) in list.items.enumerated() {
            let listNum = ordered ? "\(index + 1)." : style.values.unorderedListSymbol
            let valueNode: ASDisplayNode

            if let displayNode = item.displayNode(style: style, nested: true) {
                valueNode = displayNode
                if var linkable = displayNode as? Linkable {
                    linkable.linkDelegate = self
                }
                displayNode.style.flexShrink = 1.0
                displayNode.style.flexGrow = 1.0
            } else {
                let listValueTextNode = ASTextNode()
                listValueTextNode.isUserInteractionEnabled = true
                listValueTextNode.delegate = self
                listValueTextNode.style.flexShrink = 1.0
                listValueTextNode.style.flexGrow = 1.0
                listValueTextNode.attributedText =  item.attributedText(style: style.maakuStyle)
                valueNode = listValueTextNode
            }

            let listNumTextNode = ASTextNode()
            listNumTextNode.style.flexBasis = ASDimensionMake(30.0)
            listNumTextNode.attributedText = NSAttributedString(string: listNum, attributes: attribs)

            let stackSpec = ASStackLayoutSpec(direction: .horizontal,
                                              spacing: 0.0,
                                              justifyContent: .start,
                                              alignItems: .start,
                                              children: [listNumTextNode, valueNode])
            children.append(stackSpec)
        }
    }

    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var nodeInsets = insets

        if nested {
            nodeInsets = .zero
            nodeInsets.left = insets.left
        }

        let stackSpec = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 5.0,
                                          justifyContent: .start,
                                          alignItems: .stretch,
                                          children: children)
        stackSpec.style.flexShrink = 1.0
        stackSpec.style.flexGrow = 1.0

        let insetSpec = ASInsetLayoutSpec(insets: nodeInsets, child: stackSpec)
        return insetSpec
    }

    public func linkTapped(_ url: URL) {
        linkDelegate?.linkTapped(url)
    }

    public func textNode(_ textNode: ASTextNode,
                         tappedLinkAttribute attribute: String,
                         value: Any, at point: CGPoint,
                         textRange: NSRange) {
        if let url = value as? URL {
            linkDelegate?.linkTapped(url)
        }
    }

    public func textNode(_ textNode: ASTextNode,
                         shouldHighlightLinkAttribute attribute: String,
                         value: Any,
                         at point: CGPoint) -> Bool {
        return true
    }
}
