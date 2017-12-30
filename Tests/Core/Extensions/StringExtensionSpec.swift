//
//  StringExtensionSpec.swift
//  TexturedMaakuTests
//
//  Created by Kris Baker on 12/30/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import Nimble
import Quick
@testable import TexturedMaaku
import XCTest

class StringExtensionSpec: QuickSpec {

    override func spec() {
        describe("characterHeaderMatch") {

            it("matches single digit") {
                let match = "1. heading text".characterHeaderMatch()
                expect(match).to(equal("1. "))
            }

            it("matches double digit") {
                let match = "22. heading text".characterHeaderMatch()
                expect(match).to(equal("22. "))
            }

            it("matches kanji") {
                let match = "雪. heading text".characterHeaderMatch()
                expect(match).to(equal("雪. "))
            }

            it("does not match single digit no space") {
                let match = "1.heading text".characterHeaderMatch()
                expect(match).to(beNil())
            }

        }

        describe("urlSpaceEscaped") {

            it("decodes percent spaces") {
                let text = "test%20test%20test"
                expect(text.urlSpaceDecoded).to(equal("test test test"))
            }

            it("decodes +") {
                let text = "test+test+test"
                expect(text.urlSpaceDecoded).to(equal("test test test"))
            }

            it("decodes percent escapes and +") {
                let text = "test%20test+test"
                expect(text.urlSpaceDecoded).to(equal("test test test"))
            }

        }
    }
}
