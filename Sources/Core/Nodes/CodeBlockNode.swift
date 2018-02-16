//
//  CodeBlockNode.swift
//  TexturedMaaku
//
//  Created by Kris Baker on 12/21/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import AsyncDisplayKit
#if TEXTURED_MAAKU_SYNTAX_COLORS
import Highlightr
#endif
import Maaku
import UIKit

/// Represents a markdown code block as an ASDisplayNode
public class CodeBlockNode: ASDisplayNode {

    /// The text node.
    private let textNode = ASTextNode()

    /// The background node.
    private let backgroundNode = ASImageNode()

    /// The insets.
    private let insets: UIEdgeInsets

    /// Indicates if the node is nested.
    private let nested: Bool

    #if TEXTURED_MAAKU_SYNTAX_COLORS
    /// The code highlighter.
    private let highlighter = Highlightr()
    #endif

    /// Initializes a CodeBlockNode with the specified code block and style.
    ///
    /// - Parameters:
    ///     - codeBlock: The markdown code block.
    ///     - style: The document style.
    ///     - nested: Indicates if the node is nested.
    /// - Returns:
    ///     The initialized CodeBlockNode.
    public init(codeBlock: CodeBlock, style: DocumentStyle, nested: Bool = false) {
        insets = style.insets.codeBlock
        self.nested = nested
        super.init()

        automaticallyManagesSubnodes = true
        #if TEXTURED_MAAKU_SYNTAX_COLORS
        highlighter?.setTheme(to: style.values.codeHighlighterTheme)
        #endif
        setupCodeBlock(codeBlock, style: style)
    }

    /// Configures a code block.
    ///
    /// - Parameters:
    ///     - codeBlock: The markdown code block.
    ///     - style: The document style.
    private func setupCodeBlock(_ codeBlock: CodeBlock, style: DocumentStyle) {
        var code = codeBlock.code

        // remove trailing newline
        if code.hasSuffix("\n") {
            code.removeLast()
        }

        // consider using https://github.com/alehed/SyntaxKit for syntax coloring (enabled as an option/subspec)
        textNode.style.flexShrink = 1.0
        textNode.style.flexGrow = 1.0

        #if TEXTURED_MAAKU_SYNTAX_COLORS
        let attributedCode = NSMutableAttributedString()

        if let highlighter = self.highlighter {
            if let lang = codeBlock.info, !lang.isEmpty,
                let highlighted = highlighter.highlight(code, as: lang, fastRender: true) {
                attributedCode.append(highlighted)
            } else if let highlighted = highlighter.highlight(code, fastRender: true) {
                attributedCode.append(highlighted)
            }
        }

        if attributedCode.length == 0 {
            attributedCode.append(CodeBlock(code: code,
                                            info: codeBlock.info).attributedText(style: style.maakuStyle))
        } else {
            attributedCode.addAttribute(.font,
                                        value: style.values.codeFont,
                                        range: NSRange(location: 0, length: attributedCode.length))
        }

        textNode.attributedText = attributedCode
        #else
        textNode.attributedText = CodeBlock(code: code,
                                            info: codeBlock.info).attributedText(style: style.maakuStyle)
        #endif

        backgroundNode.image = UIImage.as_resizableRoundedImage(withCornerRadius: 3.0,
                                                                cornerColor: nil,
                                                                fill: style.colors.codeBlockBackground)
    }

    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var nodeInsets = insets
        let textInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        if nested {
            nodeInsets = .zero
            nodeInsets.left = insets.left
        }

        if constrainedSize.max.width > 0, constrainedSize.max.width < .greatestFiniteMagnitude {
            textNode.style.width = ASDimensionMake(constrainedSize.max.width - textInsets.left - textInsets.right)
        }

        let textInsetSpec = ASInsetLayoutSpec(insets: textInsets, child: textNode)
        let backgroundSpec = ASBackgroundLayoutSpec(child: textInsetSpec, background: backgroundNode)

        return ASInsetLayoutSpec(insets: nodeInsets, child: backgroundSpec)
    }
}
