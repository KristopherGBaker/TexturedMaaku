//
//  Linkable.swift
//  TexturedMaaku
//
//  Created by Kris Baker on 12/21/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import Foundation

/// Represents a markdown element that has linkable content.
public protocol Linkable {

    /// The link delegate.
    var linkDelegate: LinkDelegate? { get set }
}

/// The LinkDelegate protocol defines methods that allow
/// you to respond to interactions with a markdown link.
public protocol LinkDelegate: class {

    /// Tells the delegate that the link was tapped
    ///
    /// - Parameters:
    ///     - url: The URL that was tapped.
    func linkTapped(_ url: URL)
}
