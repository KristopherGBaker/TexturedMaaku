//
//  Block+TexturedMaaku.swift
//  TexturedMaaku
//
//  Created by Kris Baker on 12/21/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import AsyncDisplayKit
import Maaku

/// Extensions for Maaku.Block
extension Block {

    /// Gets an ASDisplayNode for the block.
    ///
    /// - Parameters:
    ///     - style: The document style to use for the block.
    ///     - nested: Indicates if the node will be nested.
    /// - Returns:
    ///     The ASDisplayNode for the block if it can be created, nil otherwise.
    public func displayNode(style: DocumentStyle, nested: Bool = false) -> ASDisplayNode? {
        var node: ASDisplayNode?

        if let paragraph = self as? Paragraph {
            node = ParagraphNode(paragraph: paragraph, style: style, nested: nested)
        } else if let heading = self as? Heading {
            node = HeadingNode(heading: heading, style: style, nested: nested)
        } else if let list = self as? List {
            node = ListNode(list: list, style: style, nested: nested)
        } else if let blockQuote = self as? BlockQuote {
            node = BlockQuoteNode(blockQuote: blockQuote, style: style, nested: nested)
        } else if let table = self as? Table {
            node = TableNode(table: table, style: style, nested: nested)
        } else if let codeBlock = self as? CodeBlock {
            node = CodeBlockNode(codeBlock: codeBlock, style: style, nested: nested)
        } else if self is HorizontalRule {
            node = HorizontalRuleNode(style: style, nested: nested)
        } else if let footnoteDefinition = self as? FootnoteDefinition {
            node = FootnoteDefinitionNode(footnoteDefinition: footnoteDefinition, style: style)
        } else if let listItem = self as? ListItem {
            node = ListItemNode(listItem: listItem, style: style, nested: nested)
        } else if let plugin = self as? Plugin {
            node = NodePluginManager.displayNode(for: plugin, style: style, nested: nested)
        }

        return node
    }

    /// Gets an ASCellNode for the block.
    ///
    /// - Parameters:
    ///     - style: The document style to use for the block.
    ///     - nested: Indicates if the node will be nested.
    /// - Returns:
    ///     The ASCellNode for the block if it can be created, nil otherwise.
    public func cellNode(style: DocumentStyle, nested: Bool = false) -> ASCellNode? {
        guard let displayNode = displayNode(style: style, nested: nested) else {
            return nil
        }

        return WrapperCellNode(node: displayNode)
    }

}
