//
//  YoutubeVideoPlugin.swift
//  BB
//
//  Created by Kris Baker on 4/14/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import Foundation

/// Youtube plugin attributes.
private enum PluginAttribute: String {

    /// source
    case source

    /// youtubevideo
    case youtubevideo

}

/// Represents a youtube video plugin parser.
public struct YoutubePluginParser: PluginParser {

    /// The unique name for the parser.
    public let name = PluginAttribute.youtubevideo.rawValue

    /// Parses the given text and returns a markdown plugin.
    ///
    /// - Parameters:
    ///     - text: The text to parse.
    ///
    /// - Returns:
    ///     - The plugin if parsing succeeded, nil otherwise.
    public func parse(text: String) -> Plugin? {
        guard let url = parseURL(text, parameterName: PluginAttribute.source.rawValue) else {
            return nil
        }

        return YoutubePlugin(url: url)
    }

    public init() {

    }
}

/// Represents a youtube video plugin.
public struct YoutubePlugin: Plugin {

    /// The plugin name.
    public static let pluginName: PluginName = PluginAttribute.youtubevideo.rawValue

    /// The youtube video URL.
    public let url: URL

    /// The youtube video id.
    public var videoId: String? {
        return url.path.components(separatedBy: "/").last
    }

    public init(url: URL) {
        self.url = url
    }
}
