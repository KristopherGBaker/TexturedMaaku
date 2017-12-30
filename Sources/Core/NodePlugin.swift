//
//  NodePlugin.swift
//  TexturedMaaku
//
//  Created by Kris Baker on 12/20/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import AsyncDisplayKit
import Maaku

/// Represents a markdown node plugin.
public protocol NodePlugin {

}

/// Provides a way of mapping a Maaku.Plugin to an ASDisplayNode.
public protocol NodePluginMap {

    /// The plugin name.
    var pluginName: PluginName { get }

    /// Maps the plugin to an ASDisplayNode.
    ///
    /// - Parameters:
    ///     - plugin: The Maaku.Plugin.
    ///     - style: The document style.
    ///     - nested: Indicates if the plugin is nested.
    /// - Returns:
    ///     The ASDisplayNode for the plugin if it can be created, nil otherwise.
    func mapPlugin(plugin: Plugin, style: DocumentStyle, nested: Bool) -> ASDisplayNode?

}

/// Encapsulates management of markdown node plugins.
public struct NodePluginManager {

    /// The registered mappings.
    private static var mappings = [PluginName: NodePluginMap]()

    /// Registers the specified mappings.
    ///
    /// - Parameters:
    ///     - maps: The plugin mappings.
    public static func registerMappings(_ mappings: [NodePluginMap]) {
        for map in mappings {
            self.mappings[map.pluginName] = map
        }
    }

    /// Gets the ASDisplayNode for the plugin.
    ///
    /// - Parameters:
    ///     - plugin: The Maaku.Plugin.
    ///     - style: The document style.
    ///     - nested: Indicates if the plugin is nested.
    /// - Returns:
    ///     The ASDisplayNode for the plugin if it can be created, nil otherwise.
    static func displayNode(for plugin: Plugin, style: DocumentStyle, nested: Bool) -> ASDisplayNode? {
        guard let mapping = mappings[type(of: plugin).pluginName] else {
            return nil
        }

        return mapping.mapPlugin(plugin: plugin, style: style, nested: nested)
    }

}
