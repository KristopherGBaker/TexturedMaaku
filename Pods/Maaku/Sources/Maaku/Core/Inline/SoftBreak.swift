//
//  SoftBreak.swift
//  Maaku
//
//  Created by Kris Baker on 12/20/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import Foundation

/// Represents a markdown soft break.
public struct SoftBreak: Inline {

}

public extension SoftBreak {

    public func attributedText(style: Style) -> NSAttributedString {
        return NSAttributedString(string: " ")
    }

}
