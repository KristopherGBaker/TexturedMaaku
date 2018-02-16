//
//  DocumentStyle.swift
//  TexturedMaaku
//
//  Created by Kris Baker on 12/24/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import Maaku
import UIKit

/// Represents a document color.
public protocol DocumentColors {

    /// Document background color.
    var background: UIColor { get set }

    /// Blockquote line color.
    var blockQuoteLine: UIColor { get set }

    /// Circle header background color.
    var circleHeaderBackground: UIColor { get set }

    /// Circle header foreground color.
    var circleHeaderForeground: UIColor { get set }

    /// Code block background color.
    var codeBlockBackground: UIColor { get set }

    /// Horizontal rule color.
    var horizontalRule: UIColor { get set }

}

/// Represents document insets.
public protocol DocumentInsets {

    /// Blockquote insets.
    var blockQuote: UIEdgeInsets { get set }

    /// Code block insets.
    var codeBlock: UIEdgeInsets { get set }

    /// Document insets.
    var document: UIEdgeInsets { get set }

    /// Footnote definition insets.
    var footNoteDefinition: UIEdgeInsets { get set }

    /// Heading insets.
    var heading: UIEdgeInsets { get set }

    /// Horizontal rule insets.
    var horizontalRule: UIEdgeInsets { get set }

    /// List insets.
    var list: UIEdgeInsets { get set }

    /// Paragraph insets.
    var paragraph: UIEdgeInsets { get set }

    /// Table insets.
    var table: UIEdgeInsets { get set }

}

/// Represents a document value.
public protocol DocumentValues {

    /// Blockquote line width.
    var blockQuoteLineWidth: CGFloat { get set }

    /// Horizontal rule height.
    var horizontalRuleHeight: CGFloat { get set }

    /// Circle header radius.
    var circleHeaderRadius: CGFloat { get set }

    /// The circle header font.
    var circleHeaderFont: UIFont { get set }

    /// The unordered list symbol. Defaults to •.
    var unorderedListSymbol: String { get set }

    /// Indicates if circle headers are enabled, defaults to true.
    var circleHeadersEnabled: Bool { get set }

    #if TEXTURED_MAAKU_SYNTAX_COLORS
    /// The code block syntax highlighter theme.
    var codeHighlighterTheme: String { get set }

    /// The code block font.
    var codeFont: UIFont { get set }
    #endif
}

/// Represents the styles to apply when rendering a document.
public protocol DocumentStyle {

    /// The insets.
    var insets: DocumentInsets { get set }

    /// The colors.
    var colors: DocumentColors { get set }

    /// The floats.
    var values: DocumentValues { get set }

    /// The Maaku style.
    var maakuStyle: Style { get set }

}

/// Represents the default document colors.
public struct DefaultDocumentColors: DocumentColors {

    /// The background color.
    public var background: UIColor

    /// The blockquote line color.
    public var blockQuoteLine: UIColor

    /// The circle header background color.
    public var circleHeaderBackground: UIColor

    /// The circle header foreground color.
    public var circleHeaderForeground: UIColor

    /// The code block background color.
    public var codeBlockBackground: UIColor

    /// The horizontal rule color.
    public var horizontalRule: UIColor

    /// Initializes a DocumentColors with the default values.
    ///
    /// - Returns:
    ///     The initialized DocumentColors.
    public init() {
        background = .white
        blockQuoteLine = UIColor(white: 0.52, alpha: 1.0)
        horizontalRule = UIColor(white: 0.28, alpha: 1.0)
        codeBlockBackground = UIColor(white: 0.95, alpha: 1.0)
        circleHeaderBackground = .black
        circleHeaderForeground = .white
    }
}

/// Represents the default document insets.
public struct DefaultDocumentInsets: DocumentInsets {

    /// The blockquote insets.
    public var blockQuote: UIEdgeInsets

    /// The code block insets.
    public var codeBlock: UIEdgeInsets

    /// The document insets.
    public var document: UIEdgeInsets

    /// The footnote definition insets.
    public var footNoteDefinition: UIEdgeInsets

    /// The heading insets.
    public var heading: UIEdgeInsets

    /// The horizontal rule insets.
    public var horizontalRule: UIEdgeInsets

    /// The list insets.
    public var list: UIEdgeInsets

    /// The paragraph insets.
    public var paragraph: UIEdgeInsets

    /// The table insets.
    public var table: UIEdgeInsets

    /// Initializes a DocumentInsets with the default values.
    ///
    /// - Returns:
    ///     The initialized DocumentInsets.
    public init() {
        document = .zero
        blockQuote = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
        codeBlock = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
        footNoteDefinition = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
        heading = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
        horizontalRule = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
        list = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
        paragraph = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
        table = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
    }
}

/// Represents the default document values.
public struct DefaultDocumentValues: DocumentValues {

    /// The blockquote line width.
    public var blockQuoteLineWidth: CGFloat

    /// The horizontal rule height.
    public var horizontalRuleHeight: CGFloat

    /// The circle header radius.
    public var circleHeaderRadius: CGFloat

    /// The circle header font.
    public var circleHeaderFont: UIFont

    /// The unordered list symbol.
    public var unorderedListSymbol: String

    /// The circle headers enabled.
    public var circleHeadersEnabled: Bool

    #if TEXTURED_MAAKU_SYNTAX_COLORS
    /// The code block syntax highlighter theme.
    public var codeHighlighterTheme: String

    /// The code block font.
    public var codeFont: UIFont
    #endif

    /// Initializes a DocumentValues with the default values.
    ///
    /// - Returns:
    ///     The initialized DocumentValues.
    public init() {
        circleHeaderFont = UIFont.systemFont(ofSize: 14, weight: .heavy)
        unorderedListSymbol = "•"
        circleHeadersEnabled = true
        blockQuoteLineWidth = 3.0
        circleHeaderRadius = 15.5
        horizontalRuleHeight = 1.0 / UIScreen.main.scale
        #if TEXTURED_MAAKU_SYNTAX_COLORS
        codeHighlighterTheme = "xcode"
        codeFont = UIFont.preferredFont(forTextStyle: .body)
        #endif
    }
}

/// Represents the default document style.
public struct DefaultDocumentStyle: DocumentStyle {

    /// The insets.
    public var insets: DocumentInsets

    /// The colors.
    public var colors: DocumentColors

    /// The values.
    public var values: DocumentValues

    /// The Maaku style.
    public var maakuStyle: Style

    /// Initializes a DocumentStyle with the default values.
    ///
    /// - Returns:
    ///     The initialized DocumentStyle.
    public init() {
        colors = DefaultDocumentColors()
        insets = DefaultDocumentInsets()
        maakuStyle = DefaultStyle()
        values = DefaultDocumentValues()
    }

    /// Initializes a DocumentStyle with the specified values.
    ///
    /// - Parameters:
    ///     - colors: The colors.
    ///     - insets: The insets.
    ///     - maakuStyle: The Maaku style.
    ///     - values: The values.
    /// - Returns:
    ///     The initialized DocumentStyle.
    public init(colors: DocumentColors,
                insets: DocumentInsets,
                maakuStyle: Style,
                values: DocumentValues) {
        self.colors = colors
        self.insets = insets
        self.maakuStyle = maakuStyle
        self.values = values
    }

}
