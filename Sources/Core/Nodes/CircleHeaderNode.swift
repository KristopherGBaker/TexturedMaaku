//
//  CircleHeaderNode.swift
//  Content
//
//  Created by Robert Sainsbury on 12/20/17.
//  Copyright © 2016 Kristopher Baker. All rights reserved.
//

import AsyncDisplayKit
import UIKit

/// Represents a text header within a circle as an ASDisplayNode
public class CircleHeaderNode: ASDisplayNode {

    /// The header text node.
    private let headerTextNode = ASTextNode()

    /// The circle node.
    private let circleNode = ASImageNode()

    /// Initializes the CircleHeaderNode with the specified text.
    ///
    /// - Parameters:
    ///     - text: The header text.
    /// - Returns:
    ///     The initialized CircleHeaderNode.
    public init(text: String, style: DocumentStyle) {
        let radius = style.values.circleHeaderRadius
        let fill = style.colors.circleHeaderBackground
        circleNode.image = UIImage.as_resizableRoundedImage(withCornerRadius: radius,
                                                            cornerColor: nil,
                                                            fill: fill)
        super.init()

        automaticallyManagesSubnodes = true

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let headerAttribs: [NSAttributedString.Key: Any] = [
            .font: style.values.circleHeaderFont,
            .foregroundColor: style.colors.circleHeaderForeground,
            .paragraphStyle: paragraphStyle
        ]

        headerTextNode.attributedText = NSAttributedString(string: text, attributes: headerAttribs)
        headerTextNode.style.flexShrink = 1.0
    }

    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let center = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: self.headerTextNode)

        return ASOverlayLayoutSpec(child: self.circleNode, overlay: center)
    }
}
