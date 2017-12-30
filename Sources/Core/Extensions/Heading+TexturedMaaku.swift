//
//  Heading+TexturedMaaku.swift
//  TexturedMaaku
//
//  Created by Kris Baker on 12/29/17.
//

import Maaku

/// Heading extensions.
extension Heading {

    /// Returns the string value of the first Text item.
    var stringValue: String {
        if items.count > 0, let text = items.first as? Text {
            return text.text
        }

        return ""
    }

}
