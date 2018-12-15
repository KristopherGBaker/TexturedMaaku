//
//  FootnoteDefinitionNode.swift
//  TexturedMaaku
//
//  Created by Kris Baker on 12/21/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import AsyncDisplayKit
import Maaku
import UIKit

/// Represents a markdown footnote definition as an ASDisplayNode
public class FootnoteDefinitionNode: ASDisplayNode, ASTextNodeDelegate, Linkable, LinkDelegate {

    /// The footnote definition child elements.
    private var children = [ASLayoutElement]()

    /// The text node.
    private let textNode = ASTextNode()

    /// The link delegate.
    public weak var linkDelegate: LinkDelegate?

    /// The insets.
    private let insets: UIEdgeInsets

    /// Indicates if the node is nested.
    private let nested: Bool

    /// Initializes a FootnoteDefinitionNode with the specified footnote definition and style.
    ///
    /// - Parameters:
    ///     - footnoteDefinition: The markdown footnote definition.
    ///     - style: The document style.
    ///     - nested: Indicates if the node is nested.
    /// - Returns:
    ///     The initialized FootnoteDefinitionNode.
    public init(footnoteDefinition: FootnoteDefinition, style: DocumentStyle, nested: Bool = false) {
        insets = style.insets.list
        self.nested = nested
        super.init()

        automaticallyManagesSubnodes = true
        setupFootnoteDefinition(footnoteDefinition, style: style)
    }

    /// Configures a footnote definition.
    ///
    /// - Parameters:
    ///     - footnoteDefinition: The markdown footnote definition.
    ///     - style: The document style.
    private func setupFootnoteDefinition(_ footnoteDefinition: FootnoteDefinition, style: DocumentStyle) {
        let attribs: [NSAttributedString.Key: Any] = [
            .foregroundColor: style.maakuStyle.colors.paragraph,
            .font: style.maakuStyle.fonts.paragraph
        ]

        textNode.style.flexBasis = ASDimensionMake(30.0)
        textNode.attributedText = NSAttributedString(string: "\(footnoteDefinition.number).", attributes: attribs)

        var itemStyle = style
        itemStyle.insets.paragraph = .zero

        for item in footnoteDefinition.items {
            if let displayNode = item.displayNode(style: itemStyle, nested: true) {
                if var linkable = displayNode as? Linkable {
                    linkable.linkDelegate = self
                }
                children.append(displayNode)
            } else {
                let textNode = ASTextNode()
                textNode.isUserInteractionEnabled = true
                textNode.delegate = self
                textNode.style.flexShrink = 1.0
                textNode.attributedText = item.attributedText(style: style.maakuStyle)
                children.append(textNode)
            }
        }
    }

    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var nodeInsets = insets

        if nested {
            nodeInsets.top = 0
            nodeInsets.bottom = 0
            nodeInsets.right = 0
        }

        let verticalSpec = ASStackLayoutSpec(direction: .vertical,
                                             spacing: 5.0,
                                             justifyContent: .start,
                                             alignItems: .stretch,
                                             children: children)

        let stackSpec = ASStackLayoutSpec(direction: .horizontal,
                                          spacing: 0.0,
                                          justifyContent: .start,
                                          alignItems: .start,
                                          children: [textNode, verticalSpec])

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
