//
//  TableAlignmentExtensionSpec.swift
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

class TableAlignmentExtensionSpec: QuickSpec {

    override func spec() {
        describe("paragraphStyle") {

            it("gets the left style") {
                expect(TableAlignment.left.paragraphStyle.alignment).to(equal(NSTextAlignment.left))
            }

            it("gets the center style") {
                expect(TableAlignment.center.paragraphStyle.alignment).to(equal(NSTextAlignment.center))
            }

            it("gets the right style") {
                expect(TableAlignment.right.paragraphStyle.alignment).to(equal(NSTextAlignment.right))
            }

            it("gets the none style") {
                expect(TableAlignment.none.paragraphStyle.alignment).to(equal(NSTextAlignment.left))
            }

        }
    }

}
