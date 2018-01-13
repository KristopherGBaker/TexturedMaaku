//
//  DocumentStyleSpec.swift
//  TexturedMaakuTests
//
//  Created by Kris Baker on 12/30/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import Maaku
import Nimble
import Quick
@testable import TexturedMaaku
import XCTest

class DocumentStyleSpec: QuickSpec {

    // swiftlint:disable function_body_length
    override func spec() {
        describe("DocumentStyle") {
            context("init()") {
                let style: DocumentStyle = DefaultDocumentStyle()

                it("sets the circle header font") {
                    expect(style.values.circleHeaderFont).to(equal(UIFont.systemFont(ofSize: 14, weight: .heavy)))
                }

                it("sets the circle header enabled") {
                    expect(style.values.circleHeadersEnabled).to(equal(true))
                }

                it("sets the unordered list symbol") {
                    expect(style.values.unorderedListSymbol).to(equal("•"))
                }

                it("sets the colors") {
                    expect(style.colors.background).to(equal(UIColor.white))
                    expect(style.colors.blockQuoteLine).to(equal(UIColor(white: 0.52, alpha: 1.0)))
                    expect(style.colors.horizontalRule).to(equal(UIColor(white: 0.28, alpha: 1.0)))
                    expect(style.colors.codeBlockBackground).to(equal(UIColor(white: 0.95, alpha: 1.0)))
                    expect(style.colors.circleHeaderBackground).to(equal(UIColor.black))
                    expect(style.colors.circleHeaderForeground).to(equal(UIColor.white))
                }

                it("sets the insets") {
                    let commonInsets = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
                    expect(style.insets.document).to(equal(UIEdgeInsets.zero))
                    expect(style.insets.blockQuote).to(equal(commonInsets))
                    expect(style.insets.codeBlock).to(equal(commonInsets))
                    expect(style.insets.footNoteDefinition).to(equal(commonInsets))
                    expect(style.insets.heading).to(equal(commonInsets))
                    expect(style.insets.horizontalRule).to(equal(commonInsets))
                    expect(style.insets.list).to(equal(commonInsets))
                    expect(style.insets.paragraph).to(equal(commonInsets))
                    expect(style.insets.table).to(equal(commonInsets))
                }

                it("sets the values") {
                    expect(style.values.blockQuoteLineWidth).to(equal(3.0))
                    expect(style.values.circleHeaderRadius).to(equal(15.5))
                    expect(style.values.horizontalRuleHeight).to(equal(1.0 / UIScreen.main.scale))
                }
            }

            context("init(colors:...)") {
                var colors: DocumentColors = DefaultDocumentColors()
                colors.background = .red
                colors.blockQuoteLine = .red
                colors.horizontalRule = .red
                colors.codeBlockBackground = .red
                colors.circleHeaderBackground = .red
                colors.circleHeaderForeground = .red

                let commonInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
                var insets: DocumentInsets = DefaultDocumentInsets()
                insets.document = commonInsets
                insets.blockQuote = commonInsets
                insets.codeBlock = commonInsets
                insets.footNoteDefinition = commonInsets
                insets.heading = commonInsets
                insets.horizontalRule = commonInsets
                insets.list = commonInsets
                insets.paragraph = commonInsets
                insets.table = commonInsets

                var values: DocumentValues = DefaultDocumentValues()
                values.blockQuoteLineWidth = 10.0
                values.circleHeaderRadius = 20.0
                values.horizontalRuleHeight = 30.0
                values.circleHeaderFont = UIFont.systemFont(ofSize: 30, weight: .black)
                values.unorderedListSymbol = "*"
                values.circleHeadersEnabled = false

                let style: DocumentStyle = DefaultDocumentStyle(colors: colors,
                                                                insets: insets,
                                                                maakuStyle: DefaultStyle(),
                                                                values: values)

                it("sets the circle header font") {
                    expect(style.values.circleHeaderFont).to(equal(UIFont.systemFont(ofSize: 30, weight: .black)))
                }

                it("sets the circle header enabled") {
                    expect(style.values.circleHeadersEnabled).to(equal(false))
                }

                it("sets the unordered list symbol") {
                    expect(style.values.unorderedListSymbol).to(equal("*"))
                }

                it("sets the colors") {
                    expect(style.colors.background).to(equal(UIColor.red))
                    expect(style.colors.blockQuoteLine).to(equal(UIColor.red))
                    expect(style.colors.horizontalRule).to(equal(UIColor.red))
                    expect(style.colors.codeBlockBackground).to(equal(UIColor.red))
                    expect(style.colors.circleHeaderBackground).to(equal(UIColor.red))
                    expect(style.colors.circleHeaderForeground).to(equal(UIColor.red))
                }

                it("sets the insets") {
                    expect(style.insets.document).to(equal(commonInsets))
                    expect(style.insets.blockQuote).to(equal(commonInsets))
                    expect(style.insets.codeBlock).to(equal(commonInsets))
                    expect(style.insets.footNoteDefinition).to(equal(commonInsets))
                    expect(style.insets.heading).to(equal(commonInsets))
                    expect(style.insets.horizontalRule).to(equal(commonInsets))
                    expect(style.insets.list).to(equal(commonInsets))
                    expect(style.insets.paragraph).to(equal(commonInsets))
                    expect(style.insets.table).to(equal(commonInsets))
                }

                it("sets the values") {
                    expect(style.values.blockQuoteLineWidth).to(equal(10.0))
                    expect(style.values.circleHeaderRadius).to(equal(20.0))
                    expect(style.values.horizontalRuleHeight).to(equal(30.0))
                }
            }
        }
    }

}
