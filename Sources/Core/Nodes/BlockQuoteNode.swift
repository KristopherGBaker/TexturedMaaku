//
//  BlockQuoteNode.swift
//  TexturedMaaku
//
//  Created by Kris Baker on 12/20/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import AsyncDisplayKit
import Maaku
import UIKit

/// Represents a CommonMark blockquote as an ASDisplayNode
public class BlockQuoteNode: ASDisplayNode, ASTextNodeDelegate, Linkable, LinkDelegate {

    /// The blockquote child elements.
    private var children = [ASLayoutElement]()

    /// The vertical blockquote line.
    private let line = ASDisplayNode()

    /// The vertical blockquote line width.
    private let lineWidth: CGFloat

    /// The link delegate.
    public weak var linkDelegate: LinkDelegate?

    /// The insets.
    private let insets: UIEdgeInsets

    /// Indicates if the node is nested.
    private let nested: Bool

    /// Initializes a BlockQuoteNode with the specified blockquote and style.
    ///
    /// - Parameters:
    ///     - blockQuote: The CommonMark blockquote.
    ///     - style: The document style.
    ///     - nested: Indicates if the node is nested.
    /// - Returns:
    ///     The initialized ParagraphNode.
    public init(blockQuote: BlockQuote, style: DocumentStyle, nested: Bool = false) {
        lineWidth = style.values.blockQuoteLineWidth
        insets = style.insets.blockQuote
        self.nested = nested
        super.init()

        automaticallyManagesSubnodes = true
        setupBlockQuote(blockQuote, style: style)
    }

    /// Configures a paragraph.
    ///
    /// - Parameters:
    ///     - blockQuote: The markdown blockquote.
    ///     - style: The document style.
    private func setupBlockQuote(_ blockQuote: BlockQuote, style: DocumentStyle) {
        line.style.flexBasis = ASDimensionMake(lineWidth)
        line.backgroundColor = style.colors.blockQuoteLine

        let insets = UIEdgeInsets(top: 0, left: style.insets.blockQuote.left, bottom: 0, right: 0)
        var itemStyle = style
        itemStyle.insets.blockQuote = insets

        for item in blockQuote.items {
            if let displayNode = item.displayNode(style: itemStyle, nested: true) {
                if var linkable = displayNode as? Linkable {
                    linkable.linkDelegate = self
                }
                displayNode.style.flexShrink = 1.0
                displayNode.style.flexGrow = 1.0
                children.append(displayNode)
            } else {
                let textNode = ASTextNode()
                textNode.isUserInteractionEnabled = true
                textNode.delegate = self
                textNode.style.flexShrink = 1.0
                textNode.style.flexGrow = 1.0
                textNode.attributedText = item.attributedText(style: style.maakuStyle)
                children.append(textNode)
            }
        }
    }

    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var blockquoteInsets = insets

        if nested {
            blockquoteInsets = .zero
            blockquoteInsets.left = insets.left
        }

        let verticalStack = ASStackLayoutSpec(direction: .vertical,
                                              spacing: 5.0,
                                              justifyContent: .start,
                                              alignItems: .start,
                                              children: children)
        verticalStack.style.flexShrink = 1.0
        verticalStack.style.flexGrow = 1.0

        let horizontalSpec = ASStackLayoutSpec(direction: .horizontal,
                                               spacing: 0.0,
                                               justifyContent: .start,
                                               alignItems: .stretch,
                                               children: [line, verticalStack])

        let insetSpec = ASInsetLayoutSpec(insets: blockquoteInsets, child: horizontalSpec)
        return insetSpec
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

    public func linkTapped(_ url: URL) {
        linkDelegate?.linkTapped(url)
    }
}
