//
//  Collection+TexturedMaaku.swift
//  TexturedMaaku
//
//  Created by Kris Baker on 12/24/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

/// Collection extensions.
extension Collection {

    /// Returns the element at the specified index iff it is within bounds, nil otherwise.
    ///
    /// - Parameters:
    ///     - safe: The index.
    /// - Returns:
    ///     The element at the index if it is within bounds, nil otherwise.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
