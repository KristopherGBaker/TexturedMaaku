//
//  YoutubeNode.swift
//  TexturedMaaku
//
//  Created by Kris Baker on 12/8/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import AsyncDisplayKit
import Maaku
import UIKit
import youtube_ios_player_helper

/// Maps a Maaku Youtube plugin to a YoutubeNode.
public struct YoutubeNodePluginMap: NodePluginMap {

    /// The plugin name.
    public let pluginName: PluginName = YoutubePlugin.pluginName

    /// Maps the plugin to an ASDisplayNode.
    ///
    /// - Parameters:
    ///     - plugin: The Maaku.Plugin.
    ///     - style: The document style.
    ///     - nested: Indicates if the plugin is nested.
    /// - Returns:
    ///     The ASDisplayNode for the plugin if it can be created, nil otherwise.
    public func mapPlugin(plugin: Plugin, style: DocumentStyle, nested: Bool) -> ASDisplayNode? {
        return YoutubeNode(plugin: plugin, style: style, nested: nested)
    }

    /// Initializes a YoutubeNodePluginMap.
    ///
    /// - Returns:
    ///     The initialized YoutubeNodePluginMap.
    public init() {

    }
}

/// Represents a Maaku Youtube plugin as an ASDisplayNode
public class YoutubeNode: ASDisplayNode, NodePlugin {

    /// The YTPlayerView wrapper node.
    private let wrapperNode: ASDisplayNode

    /// The insets.
    private let insets: UIEdgeInsets

    /// Indicates if the node is nested.
    private let nested: Bool

    /// Initializes a YoutubeNode.
    ///
    /// - Parameters:
    ///     - plugin: The Maaku plugin.
    ///     - style: The document style.
    ///     - nested: Indicates if the node is nested.
    /// - Returns:
    ///     The initialized YoutubeNode.
    required public init?(plugin: Plugin, style: DocumentStyle, nested: Bool) {
        self.nested = nested
        insets = style.insets.paragraph

        guard let plugin = plugin as? YoutubePlugin else {
            return nil
        }

        wrapperNode = ASDisplayNode( viewBlock: { () -> UIView in
            let youtubePlayerView = YTPlayerView(frame: .zero)

            if let videoId = plugin.videoId {
                youtubePlayerView.load(withVideoId: videoId)
            }

            return youtubePlayerView
        })

        super.init()
        automaticallyManagesSubnodes = true
    }

    override public func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var pluginInsets = insets

        if nested {
            pluginInsets = .zero
            pluginInsets.left = insets.left
        }

        let width = min(constrainedSize.max.width - pluginInsets.left - pluginInsets.right, 600)
        wrapperNode.style.preferredSize = CGSize(width: width, height: width*0.5625)

        let stackSpec = ASStackLayoutSpec(direction: .horizontal,
                                          spacing: 0.0,
                                          justifyContent: .center,
                                          alignItems: .center,
                                          children: [wrapperNode])
        let insetSpec = ASInsetLayoutSpec(insets: pluginInsets, child: stackSpec)

        return insetSpec
    }

}
