//
//  TableAlignment+TexturedMaaku.swift
//  TexturedMaaku
//
//  Created by Kris Baker on 12/22/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import Maaku

/// TableAlignment extensions.
extension TableAlignment {

    /// Gets the paragraph style for the alignment.
    var paragraphStyle: NSParagraphStyle {
        let style = NSMutableParagraphStyle()

        switch self {
        case .center:
            style.alignment = .center
        case .left, .none:
            style.alignment = .left
        case .right:
            style.alignment = .right
        }

        return style
    }

}
