//
//  HeadingExtensionSpec.swift
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

class HeadingExtensionSpec: QuickSpec {

    override func spec() {
        describe("stringValue") {
            it("gets the Text value") {
                let heading = Heading(level: .h1, items: [Text(text: "test test")])
                expect(heading.stringValue).to(equal("test test"))
            }

            it("gets the empty value") {
                let heading = Heading(level: .h1, items: [])
                expect(heading.stringValue).to(equal(""))
            }

            it("gets the non-Text value") {
                let heading = Heading(level: .h1, items: [Emphasis(items: [Text(text: "test")])])
                expect(heading.stringValue).to(equal(""))
            }
        }
    }

}
