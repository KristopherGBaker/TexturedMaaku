//
//  DocumentViewController.swift
//  TexturedMaaku
//
//  Created by Kris Baker on 12/20/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import AsyncDisplayKit
import Maaku
import SafariServices
import UIKit

/// Provides a view controller for rendering CommonMark content.
open class DocumentViewController: ASViewController<DocumentNode>, DocumentNodeDelegate {

    /// The document style. Setting this will reload the document.
    public var documentStyle: DocumentStyle {
        didSet {
            node.documentStyle = documentStyle
        }
    }

    /// Initializes a DocumentViewController with the specified markdown document.
    ///
    /// - Parameters:
    ///     - document: The markdown document.
    ///
    /// - Returns:
    ///     The initialized DocumentViewController.
    public init(document: Document, style: DocumentStyle = DefaultDocumentStyle()) {
        self.documentStyle = style
        super.init(node: DocumentNode(document: document, style: style))
        node.delegate = self
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = documentStyle.colors.background
    }

    /// Called when a document link is tapped.
    /// Subclasses can override this to customize handling of URLs.
    /// URLs that look like web links (http...) will open in
    /// SFSafariViewController by default.
    ///
    /// - Parameters:
    ///     - url: The URL that was tapped.
    open func linkTapped(_ url: URL) {
        let scheme = url.scheme ?? ""

        if scheme.hasPrefix("http") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        } else if scheme.hasPrefix("footnote") {
            node.scrollToFootnote(url)
        } else if url.absoluteString.hasPrefix("#"), let fragment = url.fragment?.urlSpaceDecoded,
            node.scrollToHeading(fragment) {
        } else if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [String: Any](), completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

    /// Reloads the document.
    open func reload() {
        node.reload()
    }

    /// Called when the content size category changes.
    /// Subclasses may use this to update the document style.
    /// Subclasses do not need to call super.
    open func contentSizeCategoryChange(_ contentSizeCategory: UIContentSizeCategory) {
        var style = documentStyle.maakuStyle
        style.fonts = DefaultFontStyle()
        documentStyle.maakuStyle = style
    }

}
