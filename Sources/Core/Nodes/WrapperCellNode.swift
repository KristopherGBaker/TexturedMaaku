//
//  WrapperCellNode.swift
//  TexturedMaaku
//
//  Created by Kris Baker on 12/21/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import AsyncDisplayKit
import Maaku
import UIKit

public class WrapperCellNode<T: ASDisplayNode>: ASCellNode, Linkable {

    /// The wrapped node node.
    private(set) public var node: T

    /// The link delegate proxy.
    public var linkDelegate: LinkDelegate? {
        get {
            return (node as? Linkable)?.linkDelegate
        }
        set {
            if var linkable = node as? Linkable {
                linkable.linkDelegate = newValue
            }
        }
    }

    /// Initializes a ParagraphNode with the specified tag and style.
    ///
    /// - Parameters:
    ///     - markdownTag: The markdown tag.
    ///     - style: The markdown style.
    ///
    /// - Returns:
    ///     The initialized ParagraphNode.
    public init(node: T) {
        self.node = node
        super.init()

        automaticallyManagesSubnodes = true
        selectionStyle = .none
    }

    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASWrapperLayoutSpec(layoutElement: node)
    }

}
