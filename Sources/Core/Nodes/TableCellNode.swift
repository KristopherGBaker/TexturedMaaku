//
//  TableCellNode.swift
//  TexturedMaaku
//
//  Created by Kris Baker on 12/22/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import AsyncDisplayKit
import Maaku
import UIKit

/// Represents a markdown table as an ASDisplayNode
public class TableCellNode: ASDisplayNode, ASTextNodeDelegate, Linkable {

    /// The text node.
    private let textNode = ASTextNode()

    /// The link delegate.
    public weak var linkDelegate: LinkDelegate?

    /// Initializes a TableNode with the specified table cell and style.
    ///
    /// - Parameters:
    ///     - cell: The markdown table cell.
    ///     - row: The markdown table row/header.
    ///     - alignment: The markdown table alignment.
    ///     - style: The document style.
    /// - Returns:
    ///     The initialized TableNode.
    public init(cell: TableCell, row: TableLine, alignment: TableAlignment, style: DocumentStyle) {
        super.init()

        automaticallyManagesSubnodes = true
        setupTable(cell, row: row, alignment: alignment, style: style)
    }

    /// Configures a table cell.
    ///
    /// - Parameters:
    ///     - cell: The markdown table cell.
    ///     - row: The markdown table row/header.
    ///     - alignment: The markdown table alignment.
    ///     - style: The document style.
    private func setupTable(_ cell: TableCell, row: TableLine, alignment: TableAlignment, style: DocumentStyle) {
        var cellStyle = style.maakuStyle
        if row is TableHeader {
            cellStyle.strong()
        }
        let attributedText = NSMutableAttributedString(attributedString: cell.attributedText(style: cellStyle))

        let range = NSRange(location: 0, length: attributedText.string.utf16.count)
        attributedText.addAttribute(.paragraphStyle, value: alignment.paragraphStyle, range: range)

        textNode.style.flexShrink = 1.0
        textNode.isUserInteractionEnabled = true
        textNode.delegate = self
        textNode.attributedText = attributedText
    }

    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASWrapperLayoutSpec(layoutElement: textNode)
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
