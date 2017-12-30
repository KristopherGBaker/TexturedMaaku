//
//  CollectionExtensionSpec.swift
//  TexturedMaakuTests
//
//  Created by Kris Baker on 12/30/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import Nimble
import Quick
@testable import TexturedMaaku
import XCTest

class CollectionExtensionSpec: QuickSpec {

    override func spec() {
        describe("safe index") {
            let list = [1, 2, 3]

            it("gets the first index") {
                expect(list[safe: 0]).to(equal(1))
            }

            it("gets the second index") {
                expect(list[safe: 1]).to(equal(2))
            }

            it("gets the third index") {
                expect(list[safe: 2]).to(equal(3))
            }

            it("gets nil for the fourth index") {
                expect(list[safe: 4]).to(beNil())
            }

            it("gets nil for the negative index") {
                expect(list[safe: -1]).to(beNil())
            }
        }
    }

}
