//
//  String+TexturedMaaku.swift
//  Textured Maaku
//
//  Created by Kristopher Baker on 12/20/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import Foundation

/// Regex to match character headers.
private let headerRegex = try? NSRegularExpression(pattern: "^(\\d{1,2}|\\w)\\.\\s", options: [])

/// Internal extensions for String
extension String {

    /// Finds a character header matching this string.
    ///
    /// The pattern for a character header is a string starting with
    /// 1-2 digits or any single word character, followed by a ".",
    /// followed by a space (which could be a non-breaking space \u{00A0})
    ///
    /// The regex pattern for the match is: ^(\d{1,2}|\w)\.\s
    ///
    /// - Returns: 
    ///     The matching header if found, nil otherwise.
    func characterHeaderMatch() -> String? {
        let matchRange = NSRange(location: 0, length: utf16.count)
        guard let match = headerRegex?.firstMatch(in: self, options: [], range: matchRange),
            let range = Range(match.range, in: self) else {
            return nil
        }

        return String(self[range])
    }

    /// Gets the string with "+" and "%20" replaced with space " " characters.
    var urlSpaceDecoded: String {
        let plusReplaced = self.replacingOccurrences(of: "+", with: " ")
        return plusReplaced.removingPercentEncoding ?? plusReplaced
    }

}
