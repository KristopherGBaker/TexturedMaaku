//
//  BlockExtensionSpec.swift
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

class BlockExtensionSpec: QuickSpec {

    // swiftlint:disable function_body_length
    override func spec() {
        let style: DocumentStyle = DefaultDocumentStyle()

        describe("displayNode(style:nested:)") {
            context("Paragraph") {
                it("gets the node") {
                    let paragraph = Paragraph()
                    let displayNode = paragraph.displayNode(style: style)
                    expect(displayNode).toNot(beNil())
                    expect(displayNode).to(beAKindOf(ParagraphNode.self))
                }
            }

            context("Heading") {
                it("gets the node") {
                    let heading = Heading(level: .h1)
                    let displayNode = heading.displayNode(style: style)
                    expect(displayNode).toNot(beNil())
                    expect(displayNode).to(beAKindOf(HeadingNode.self))
                }
            }

            context("UnorderedList") {
                it("gets the node") {
                    let list = UnorderedList()
                    let displayNode = list.displayNode(style: style)
                    expect(displayNode).toNot(beNil())
                    expect(displayNode).to(beAKindOf(ListNode.self))
                }
            }

            context("OrderedList") {
                it("gets the node") {
                    let list = OrderedList()
                    let displayNode = list.displayNode(style: style)
                    expect(displayNode).toNot(beNil())
                    expect(displayNode).to(beAKindOf(ListNode.self))
                }
            }

            context("BlockQuote") {
                it("gets the node") {
                    let blockquote = BlockQuote()
                    let displayNode = blockquote.displayNode(style: style)
                    expect(displayNode).toNot(beNil())
                    expect(displayNode).to(beAKindOf(BlockQuoteNode.self))
                }
            }

            context("Table") {
                it("gets the node") {
                    let table = Table()
                    let displayNode = table.displayNode(style: style)
                    expect(displayNode).toNot(beNil())
                    expect(displayNode).to(beAKindOf(TableNode.self))
                }
            }

            context("CodeBlock") {
                it("gets the node") {
                    let codeblock = CodeBlock(code: "", info: nil)
                    let displayNode = codeblock.displayNode(style: style)
                    expect(displayNode).toNot(beNil())
                    expect(displayNode).to(beAKindOf(CodeBlockNode.self))
                }
            }

            context("HorizontalRule") {
                it("gets the node") {
                    let hr = HorizontalRule()
                    let displayNode = hr.displayNode(style: style)
                    expect(displayNode).toNot(beNil())
                    expect(displayNode).to(beAKindOf(HorizontalRuleNode.self))
                }
            }

            context("FootnoteDefinition") {
                it("gets the node") {
                    let footnote = FootnoteDefinition(number: 1)
                    let displayNode = footnote.displayNode(style: style)
                    expect(displayNode).toNot(beNil())
                    expect(displayNode).to(beAKindOf(FootnoteDefinitionNode.self))
                }
            }

            context("ListItem") {
                it("gets the node") {
                    let item = ListItem()
                    let displayNode = item.displayNode(style: style)
                    expect(displayNode).toNot(beNil())
                    expect(displayNode).to(beAKindOf(ListItemNode.self))
                }
            }

            context("Plugin") {
                it("gets the node") {
                    let plugin = YoutubePlugin(url: URL(string: "http://example.com")!)
                    NodePluginManager.registerMappings([YoutubeNodePluginMap()])
                    let displayNode = plugin.displayNode(style: style)
                    expect(displayNode).toNot(beNil())
                    expect(displayNode).to(beAKindOf(YoutubeNode.self))
                }
            }
        }

        describe("cellNode(style:nested:)") {
            context("Paragraph") {
                it("gets the node") {
                    let paragraph = Paragraph()
                    let cellNode = paragraph.cellNode(style: style)
                    expect(cellNode).toNot(beNil())
                    expect(cellNode).to(beAKindOf(WrapperCellNode.self))
                    expect((cellNode as? WrapperCellNode)?.node).to(beAKindOf(ParagraphNode.self))
                }
            }

            context("Heading") {
                it("gets the node") {
                    let heading = Heading(level: .h1)
                    let cellNode = heading.cellNode(style: style)
                    expect(cellNode).toNot(beNil())
                    expect(cellNode).to(beAKindOf(WrapperCellNode.self))
                    expect((cellNode as? WrapperCellNode)?.node).to(beAKindOf(HeadingNode.self))
                }
            }

            context("UnorderedList") {
                it("gets the node") {
                    let list = UnorderedList()
                    let cellNode = list.cellNode(style: style)
                    expect(cellNode).toNot(beNil())
                    expect(cellNode).to(beAKindOf(WrapperCellNode.self))
                    expect((cellNode as? WrapperCellNode)?.node).to(beAKindOf(ListNode.self))
                }
            }

            context("OrderedList") {
                it("gets the node") {
                    let list = OrderedList()
                    let cellNode = list.cellNode(style: style)
                    expect(cellNode).toNot(beNil())
                    expect(cellNode).to(beAKindOf(WrapperCellNode.self))
                    expect((cellNode as? WrapperCellNode)?.node).to(beAKindOf(ListNode.self))
                }
            }

            context("BlockQuote") {
                it("gets the node") {
                    let blockquote = BlockQuote()
                    let cellNode = blockquote.cellNode(style: style)
                    expect(cellNode).toNot(beNil())
                    expect(cellNode).to(beAKindOf(WrapperCellNode.self))
                    expect((cellNode as? WrapperCellNode)?.node).to(beAKindOf(BlockQuoteNode.self))
                }
            }

            context("Table") {
                it("gets the node") {
                    let table = Table()
                    let cellNode = table.cellNode(style: style)
                    expect(cellNode).toNot(beNil())
                    expect(cellNode).to(beAKindOf(WrapperCellNode.self))
                    expect((cellNode as? WrapperCellNode)?.node).to(beAKindOf(TableNode.self))
                }
            }

            context("CodeBlock") {
                it("gets the node") {
                    let codeblock = CodeBlock(code: "", info: nil)
                    let cellNode = codeblock.cellNode(style: style)
                    expect(cellNode).toNot(beNil())
                    expect(cellNode).to(beAKindOf(WrapperCellNode.self))
                    expect((cellNode as? WrapperCellNode)?.node).to(beAKindOf(CodeBlockNode.self))
                }
            }

            context("HorizontalRule") {
                it("gets the node") {
                    let hr = HorizontalRule()
                    let cellNode = hr.cellNode(style: style)
                    expect(cellNode).toNot(beNil())
                    expect(cellNode).to(beAKindOf(WrapperCellNode.self))
                    expect((cellNode as? WrapperCellNode)?.node).to(beAKindOf(HorizontalRuleNode.self))
                }
            }

            context("FootnoteDefinition") {
                it("gets the node") {
                    let footnote = FootnoteDefinition(number: 1)
                    let cellNode = footnote.cellNode(style: style)
                    expect(cellNode).toNot(beNil())
                    expect(cellNode).to(beAKindOf(WrapperCellNode.self))
                    expect((cellNode as? WrapperCellNode)?.node).to(beAKindOf(FootnoteDefinitionNode.self))
                }
            }

            context("ListItem") {
                it("gets the node") {
                    let item = ListItem()
                    let cellNode = item.cellNode(style: style)
                    expect(cellNode).toNot(beNil())
                    expect(cellNode).to(beAKindOf(WrapperCellNode.self))
                    expect((cellNode as? WrapperCellNode)?.node).to(beAKindOf(ListItemNode.self))
                }
            }

            context("Plugin") {
                it("gets the node") {
                    let plugin = YoutubePlugin(url: URL(string: "http://example.com")!)
                    NodePluginManager.registerMappings([YoutubeNodePluginMap()])
                    let cellNode = plugin.cellNode(style: style)
                    expect(cellNode).toNot(beNil())
                    expect(cellNode).to(beAKindOf(WrapperCellNode.self))
                    expect((cellNode as? WrapperCellNode)?.node).to(beAKindOf(YoutubeNode.self))
                }
            }
        }
    }

}
