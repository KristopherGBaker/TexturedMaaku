//
//  DocumentStyle.swift
//  TexturedMaaku
//
//  Created by Kris Baker on 12/24/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import Maaku
import UIKit

/// Represents the styles to apply when rendering a document.
public struct DocumentStyle: Equatable {

    /// Represents a document color.
    public enum ColorType {

        /// Document background color.
        case background

        /// Blockquote line color.
        case blockQuoteLine

        /// Circle header background color.
        case circleHeaderBackground

        /// Circle header foreground color.
        case circleHeaderForeground

        /// Code block background color.
        case codeBlockBackground

        /// Horizontal rule color.
        case horizontalRule

    }

    /// Represents document insets.
    public enum InsetType {

        /// Blockquote insets.
        case blockQuote

        /// Code block insets.
        case codeBlock

        /// Document insets.
        case document

        /// Footnote definition insets.
        case footNoteDefinition

        /// Heading insets.
        case heading

        /// Horizontal rule insets.
        case horizontalRule

        /// List insets.
        case list

        /// Paragraph insets.
        case paragraph

        /// Table insets.
        case table

    }

    /// Represents a document CGFloat value.
    public enum FloatType {

        /// Blockquote line width.
        case blockQuoteLineWidth

        /// Horizontal rule height.
        case horizontalRuleHeight

        /// Circle header radius.
        case circleHeaderRadius
    }

    /// The insets.
    private let insets: [InsetType: UIEdgeInsets]

    /// The colors.
    private let colors: [ColorType: Color]

    /// The floats.
    private let floats: [FloatType: CGFloat]

    /// The Maaku style.
    public let maakuStyle: Style

    /// The circle header font.
    public let circleHeaderFont: UIFont

    /// The unordered list symbol. Defaults to •.
    public let unorderedListSymbol: String

    /// Indicates if circle headers are enabled, defaults to true.
    public let circleHeadersEnabled: Bool

    /// Initializes a DocumentStyle with the default values.
    ///
    /// - Returns:
    ///     The initialized DocumentStyle.
    public init() {
        maakuStyle = Style()
        circleHeaderFont = UIFont.systemFont(ofSize: 14, weight: .heavy)
        unorderedListSymbol = "•"
        circleHeadersEnabled = true

        var colors = [ColorType: UIColor]()
        colors[.background] = .white
        colors[.blockQuoteLine] = UIColor(white: 0.52, alpha: 1.0)
        colors[.horizontalRule] = UIColor(white: 0.28, alpha: 1.0)
        colors[.codeBlockBackground] = UIColor(white: 0.95, alpha: 1.0)
        colors[.circleHeaderBackground] = .black
        colors[.circleHeaderForeground] = .white
        self.colors = colors

        var insets = [InsetType: UIEdgeInsets]()
        insets[.document] = .zero
        insets[.blockQuote] = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
        insets[.codeBlock] = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
        insets[.footNoteDefinition] = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
        insets[.heading] = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
        insets[.horizontalRule] = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
        insets[.list] = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
        insets[.paragraph] = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
        insets[.table] = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
        self.insets = insets

        var floats = [FloatType: CGFloat]()
        floats[.blockQuoteLineWidth] = 3.0
        floats[.circleHeaderRadius] = 15.5
        floats[.horizontalRuleHeight] = 1.0 / UIScreen.main.scale
        self.floats = floats
    }

    /// Initializes a DocumentStyle with the specified values.
    ///
    /// - Parameters:
    ///     - maakuStyle: The Maaku style.
    ///     - circleHeaderFont: The circle header font.
    ///     - unorderedListSymbol: The unordered list symbol.
    ///     - circleHeadersEnabled: Has circle headers enabled.
    ///     - colors: The colors.
    ///     - insets: The insets.
    ///     - floats: The float values.
    /// - Returns:
    ///     The initialized DocumentStyle.
    public init(maakuStyle: Style,
                circleHeaderFont: UIFont,
                unorderedListSymbol: String,
                circleHeadersEnabled: Bool,
                colors: [ColorType: UIColor],
                insets: [InsetType: UIEdgeInsets],
                floats: [FloatType: CGFloat]) {
        self.maakuStyle = maakuStyle
        self.circleHeaderFont = circleHeaderFont
        self.unorderedListSymbol = unorderedListSymbol
        self.circleHeadersEnabled = circleHeadersEnabled
        self.colors = colors
        self.insets = insets
        self.floats = floats
    }

    /// Returns the inset for the specified type.
    ///
    /// - Parameters:
    ///     - type: The inset type.
    /// - Returns:
    ///     The inset for the specified type.
    public func insets(_ type: InsetType) -> UIEdgeInsets {
        guard let inset = insets[type] else {
            assertionFailure("font not found for type: \(type)")
            return .zero
        }

        return inset
    }

    /// Returns the color for the specified type.
    ///
    /// - Parameters:
    ///     - type: The color type.
    /// - Returns:
    ///     The color for the specified type.
    public func color(_ type: ColorType) -> Color {
        guard let color = colors[type] else {
            assertionFailure("color not found for type: \(type)")
            return Color(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }

        return color
    }

    /// Returns the float value for the specified type.
    ///
    /// - Parameters:
    ///     - type: The float type.
    /// - Returns:
    ///     The float value for the specified type.
    public func float(_ type: FloatType) -> CGFloat {
        guard let value = floats[type] else {
            assertionFailure("float value not found for type: \(type)")
            return 0.0
        }

        return value
    }

}

/// DocumentStyle extensions.
public extension DocumentStyle {

    public static func == (lhs: DocumentStyle, rhs: DocumentStyle) -> Bool {
        return
            lhs.maakuStyle == rhs.maakuStyle &&
            lhs.circleHeaderFont == rhs.circleHeaderFont &&
            lhs.unorderedListSymbol == rhs.unorderedListSymbol &&
            lhs.circleHeadersEnabled == rhs.circleHeadersEnabled &&
            lhs.colors == rhs.colors &&
            lhs.insets == rhs.insets &&
            lhs.floats == rhs.floats
    }

    /// Returns an updated DocumentStyle with the specified Maaku style.
    ///
    /// - Parameters:
    ///     - maakuStyle: The Maaku style.
    /// - Returns:
    ///     - The updated DocumentStyle.
    public func style(maakuStyle: Style) -> DocumentStyle {
        return DocumentStyle(maakuStyle: maakuStyle,
                             circleHeaderFont: circleHeaderFont,
                             unorderedListSymbol: unorderedListSymbol,
                             circleHeadersEnabled: circleHeadersEnabled,
                             colors: colors,
                             insets: insets,
                             floats: floats)
    }

    /// Returns an updated DocumentStyle with the specified color.
    ///
    /// - Parameters:
    ///     - type: The color type.
    ///     - color: The color.
    /// - Returns:
    ///     - The updated DocumentStyle.
    public func color(type: ColorType, color: UIColor) -> DocumentStyle {
        var updatedColors = colors
        updatedColors[type] = color

        return DocumentStyle(maakuStyle: maakuStyle,
                             circleHeaderFont: circleHeaderFont,
                             unorderedListSymbol: unorderedListSymbol,
                             circleHeadersEnabled: circleHeadersEnabled,
                             colors: updatedColors,
                             insets: insets,
                             floats: floats)
    }

    /// Returns an updated DocumentStyle with the specified circle header font.
    ///
    /// - Parameters:
    ///     - circleHeaderFont: The circle header font.
    /// - Returns:
    ///     - The updated DocumentStyle.
    public func font(circleHeader circleHeaderFont: UIFont) -> DocumentStyle {
        return DocumentStyle(maakuStyle: maakuStyle,
                             circleHeaderFont: circleHeaderFont,
                             unorderedListSymbol: unorderedListSymbol,
                             circleHeadersEnabled: circleHeadersEnabled,
                             colors: colors,
                             insets: insets,
                             floats: floats)
    }

    /// Returns an updated DocumentStyle with the specified unordered list symbol.
    ///
    /// - Parameters:
    ///     - unorderedListSymbol: The unordered list symbol.
    /// - Returns:
    ///     - The updated DocumentStyle.
    public func symbol(unorderedList unorderedListSymbol: String) -> DocumentStyle {
        return DocumentStyle(maakuStyle: maakuStyle,
                             circleHeaderFont: circleHeaderFont,
                             unorderedListSymbol: unorderedListSymbol,
                             circleHeadersEnabled: circleHeadersEnabled,
                             colors: colors,
                             insets: insets,
                             floats: floats)
    }

    /// Returns an updated DocumentStyle with the circle headers enabled/disabled.
    ///
    /// - Parameters:
    ///     - circleHeadersEnabled: Pass true to enable circle headers, false to disable..
    /// - Returns:
    ///     - The updated DocumentStyle.
    public func enable(circleHeaders circleHeadersEnabled: Bool) -> DocumentStyle {
        return DocumentStyle(maakuStyle: maakuStyle,
                             circleHeaderFont: circleHeaderFont,
                             unorderedListSymbol: unorderedListSymbol,
                             circleHeadersEnabled: circleHeadersEnabled,
                             colors: colors,
                             insets: insets,
                             floats: floats)
    }

    /// Returns an updated DocumentStyle with the specified insets.
    ///
    /// - Parameters:
    ///     - type: The insets type.
    ///     - insets: The insets.
    /// - Returns:
    ///     - The updated DocumentStyle.
    public func inset(type: InsetType, insets: UIEdgeInsets) -> DocumentStyle {
        var updatedInsets = self.insets
        updatedInsets[type] = insets

        return DocumentStyle(maakuStyle: maakuStyle,
                             circleHeaderFont: circleHeaderFont,
                             unorderedListSymbol: unorderedListSymbol,
                             circleHeadersEnabled: circleHeadersEnabled,
                             colors: colors,
                             insets: updatedInsets,
                             floats: floats)
    }

    /// Returns an updated DocumentStyle with the specified float value.
    ///
    /// - Parameters:
    ///     - type: The float value type.
    ///     - value: The float value.
    /// - Returns:
    ///     - The updated DocumentStyle.
    public func float(type: FloatType, value: CGFloat) -> DocumentStyle {
        var updatedFloata = floats
        updatedFloata[type] = value

        return DocumentStyle(maakuStyle: maakuStyle,
                             circleHeaderFont: circleHeaderFont,
                             unorderedListSymbol: unorderedListSymbol,
                             circleHeadersEnabled: circleHeadersEnabled,
                             colors: colors,
                             insets: insets,
                             floats: updatedFloata)
    }

}
