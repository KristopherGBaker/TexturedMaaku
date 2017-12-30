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
            context("==") {
                let style = DocumentStyle()
                let style2 = DocumentStyle()
                expect(style).to(equal(style2))
            }

            context("!=") {
                let style = DocumentStyle()
                let style2 = DocumentStyle().enable(circleHeaders: false)
                expect(style).toNot(equal(style2))
            }

            context("init()") {
                let style = DocumentStyle()

                it("sets the circle header font") {
                    expect(style.circleHeaderFont).to(equal(UIFont.systemFont(ofSize: 14, weight: .heavy)))
                }

                it("sets the circle header enabled") {
                    expect(style.circleHeadersEnabled).to(equal(true))
                }

                it("sets the unordered list symbol") {
                    expect(style.unorderedListSymbol).to(equal("•"))
                }

                it("sets the colors") {
                    expect(style.color(.background)).to(equal(UIColor.white))
                    expect(style.color(.blockQuoteLine)).to(equal(UIColor(white: 0.52, alpha: 1.0)))
                    expect(style.color(.horizontalRule)).to(equal(UIColor(white: 0.28, alpha: 1.0)))
                    expect(style.color(.codeBlockBackground)).to(equal(UIColor(white: 0.95, alpha: 1.0)))
                    expect(style.color(.circleHeaderBackground)).to(equal(UIColor.black))
                    expect(style.color(.circleHeaderForeground)).to(equal(UIColor.white))
                }

                it("sets the insets") {
                    let commonInsets = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
                    expect(style.insets(.document)).to(equal(UIEdgeInsets.zero))
                    expect(style.insets(.blockQuote)).to(equal(commonInsets))
                    expect(style.insets(.codeBlock)).to(equal(commonInsets))
                    expect(style.insets(.footNoteDefinition)).to(equal(commonInsets))
                    expect(style.insets(.heading)).to(equal(commonInsets))
                    expect(style.insets(.horizontalRule)).to(equal(commonInsets))
                    expect(style.insets(.list)).to(equal(commonInsets))
                    expect(style.insets(.paragraph)).to(equal(commonInsets))
                    expect(style.insets(.table)).to(equal(commonInsets))
                }

                it("sets the floats") {
                    expect(style.float(.blockQuoteLineWidth)).to(equal(3.0))
                    expect(style.float(.circleHeaderRadius)).to(equal(15.5))
                    expect(style.float(.horizontalRuleHeight)).to(equal(1.0 / UIScreen.main.scale))
                }

                it("sets the maakuStyle") {
                    expect(style.maakuStyle).to(equal(Style()))
                }
            }

            context("init(markdownStyle:...)") {
                var colors = [DocumentStyle.ColorType: UIColor]()
                colors[.background] = .red
                colors[.blockQuoteLine] = .red
                colors[.horizontalRule] = .red
                colors[.codeBlockBackground] = .red
                colors[.circleHeaderBackground] = .red
                colors[.circleHeaderForeground] = .red

                let commonInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
                var insets = [DocumentStyle.InsetType: UIEdgeInsets]()
                insets[.document] = commonInsets
                insets[.blockQuote] = commonInsets
                insets[.codeBlock] = commonInsets
                insets[.footNoteDefinition] = commonInsets
                insets[.heading] = commonInsets
                insets[.horizontalRule] = commonInsets
                insets[.list] = commonInsets
                insets[.paragraph] = commonInsets
                insets[.table] = commonInsets

                var floats = [DocumentStyle.FloatType: CGFloat]()
                floats[.blockQuoteLineWidth] = 10.0
                floats[.circleHeaderRadius] = 20.0
                floats[.horizontalRuleHeight] = 30.0

                let style = DocumentStyle(maakuStyle: Style(),
                                          circleHeaderFont: UIFont.systemFont(ofSize: 30, weight: .black),
                                          unorderedListSymbol: "*",
                                          circleHeadersEnabled: false,
                                          colors: colors,
                                          insets: insets,
                                          floats: floats)

                it("sets the circle header font") {
                    expect(style.circleHeaderFont).to(equal(UIFont.systemFont(ofSize: 30, weight: .black)))
                }

                it("sets the circle header enabled") {
                    expect(style.circleHeadersEnabled).to(equal(false))
                }

                it("sets the unordered list symbol") {
                    expect(style.unorderedListSymbol).to(equal("*"))
                }

                it("sets the colors") {
                    expect(style.color(.background)).to(equal(UIColor.red))
                    expect(style.color(.blockQuoteLine)).to(equal(UIColor.red))
                    expect(style.color(.horizontalRule)).to(equal(UIColor.red))
                    expect(style.color(.codeBlockBackground)).to(equal(UIColor.red))
                    expect(style.color(.circleHeaderBackground)).to(equal(UIColor.red))
                    expect(style.color(.circleHeaderForeground)).to(equal(UIColor.red))
                }

                it("sets the insets") {
                    expect(style.insets(.document)).to(equal(commonInsets))
                    expect(style.insets(.blockQuote)).to(equal(commonInsets))
                    expect(style.insets(.codeBlock)).to(equal(commonInsets))
                    expect(style.insets(.footNoteDefinition)).to(equal(commonInsets))
                    expect(style.insets(.heading)).to(equal(commonInsets))
                    expect(style.insets(.horizontalRule)).to(equal(commonInsets))
                    expect(style.insets(.list)).to(equal(commonInsets))
                    expect(style.insets(.paragraph)).to(equal(commonInsets))
                    expect(style.insets(.table)).to(equal(commonInsets))
                }

                it("sets the floats") {
                    expect(style.float(.blockQuoteLineWidth)).to(equal(10.0))
                    expect(style.float(.circleHeaderRadius)).to(equal(20.0))
                    expect(style.float(.horizontalRuleHeight)).to(equal(30.0))
                }

                it("sets the maakuStyle") {
                    expect(style.maakuStyle).to(equal(Style()))
                }
            }

            context("style(maakuStyle:)") {
                let documentStyle = DocumentStyle()
                let style = Style().strong()
                let updatedDocStyle = documentStyle.style(maakuStyle: style)

                it("sets the maakuStyle") {
                    expect(updatedDocStyle.maakuStyle).to(equal(style))
                    expect(documentStyle).toNot(equal(updatedDocStyle))
                }
            }

            context("color(type:color:)") {
                let style = DocumentStyle().color(type: .background, color: .blue)

                it("sets the color") {
                    expect(style.color(.background)).to(equal(UIColor.blue))
                }
            }

            context("inset(type:insets:)") {
                let style = DocumentStyle().inset(type: .blockQuote, insets: .zero)

                it("sets the insets") {
                    expect(style.insets(.blockQuote)).to(equal(UIEdgeInsets.zero))
                }
            }

            context("float(type:value:)") {
                let style = DocumentStyle().float(type: .blockQuoteLineWidth, value: 19.0)

                it("sets the value") {
                    expect(style.float(.blockQuoteLineWidth)).to(equal(19.0))
                }
            }

            context("font(circleHeader:)") {
                let style = DocumentStyle().font(circleHeader: UIFont.systemFont(ofSize: 33.0))

                it("sets the font") {
                    expect(style.circleHeaderFont).to(equal(UIFont.systemFont(ofSize: 33.0)))
                }
            }

            context("symbol(unorderedList:)") {
                let style = DocumentStyle().symbol(unorderedList: "*")

                it("sets the symbol") {
                    expect(style.unorderedListSymbol).to(equal("*"))
                }
            }

            context("enable(circleHeaders:)") {
                let style = DocumentStyle().enable(circleHeaders: false)

                it("disables circle headers") {
                    expect(style.circleHeadersEnabled).to(equal(false))
                }
            }
        }
    }

}
