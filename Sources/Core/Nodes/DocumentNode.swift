//
//  DocumentNode.swift
//  TexturedMaaku
//
//  Created by Kristopher Baker on 12/20/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import AsyncDisplayKit
import Maaku
import UIKit

/// The DocumentNodeDelegate protocol defines methods that allow
/// you to respond to interactions with a document node.
public protocol DocumentNodeDelegate: class {

    /// Informs the delegate that a link as tapped.
    ///
    /// - Parameters:
    ///     - url: The url.
    func linkTapped(_ url: URL)

    /// Informs the delegate that the content size category has changed.
    ///
    /// - Parameters:
    ///     - contentSizeCategory: The current content size category.
    func contentSizeCategoryChange(_ contentSizeCategory: UIContentSizeCategory)

}

/// Represents a markdown document as an ASDisplayNode.
public class DocumentNode: ASDisplayNode {

    /// The number formatter.
    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        return formatter
    }()

    /// The document.
    private let document: Document

    /// The delegate.
    public weak var delegate: DocumentNodeDelegate?

    /// The collection node.
    private let collectionNode: ASCollectionNode

    /// The collection view layout.
    private let collectionViewLayout: UICollectionViewFlowLayout

    /// The size category change observer.
    private var sizeCategoryChangeObserver: NSObjectProtocol?

    /// The document style. Setting this will reload the document.
    public var documentStyle: DocumentStyle {
        didSet {
            reload()
        }
    }

    /// Initializes a DocumentNode with the specified document and style.
    ///
    /// - Parameters:
    ///     - document: The document.
    ///     - style: The document style.
    public init(document: Document, style: DocumentStyle) {
        self.document = document
        self.documentStyle = style
        collectionViewLayout = UICollectionViewFlowLayout()
        collectionNode = ASCollectionNode(collectionViewLayout: collectionViewLayout)
        super.init()

        automaticallyManagesSubnodes = true
        backgroundColor = style.color(.background)
        setupCollectionNode()
    }

    deinit {
        if let observer = sizeCategoryChangeObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }

    public override func didLoad() {
        super.didLoad()

        setupCollectionView()

        sizeCategoryChangeObserver =
            NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange,
                                                   object: nil,
                                                   queue: OperationQueue.main) { [weak self] _ in
            self?.delegate?.contentSizeCategoryChange(UIApplication.shared.preferredContentSizeCategory)
        }
    }

    /// Reloads the document.
    public func reload() {
        collectionNode.reloadData()
    }

    // MARK: - collection view

    /// Setup collection node.
    private func setupCollectionNode() {
        collectionViewLayout.minimumLineSpacing = 0.0
        collectionViewLayout.minimumInteritemSpacing = 0.0
        collectionNode.backgroundColor = UIColor.white
    }

    /// Setup collection view.
    private func setupCollectionView() {
        collectionNode.dataSource = self
        collectionNode.delegate = self
        collectionNode.view.scrollsToTop = true
        collectionNode.view.alwaysBounceVertical = true
    }

    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: documentStyle.insets(.document), child: collectionNode)
    }

    /// Scrolls to the footnote definition matching the url.
    ///
    /// - Parameters:
    ///     - url: The footnote URL.
    public func scrollToFootnote(_ url: URL) {
        guard let host = url.host, let footnoteNumber = numberFormatter.number(from: host)?.intValue else {
            return
        }

        for (index, item) in document.items.enumerated() {
            if let footnote = item as? FootnoteDefinition, footnote.number == footnoteNumber {
                let indexPath = IndexPath(item: index, section: 0)
                collectionNode.scrollToItem(at: indexPath, at: .top, animated: true)
                break
            }
        }
    }

    /// Scrolls to the heading matching the title.
    ///
    /// - Parameters:
    ///     - title: The heading title.
    /// - Returns:
    ///     True if a matching heading was found, false otherwise.
    public func scrollToHeading(_ title: String) -> Bool {
        for (index, item) in document.items.enumerated() {
            if let heading = item as? Heading, heading.stringValue.lowercased() == title.lowercased() {
                let indexPath = IndexPath(item: index, section: 0)
                collectionNode.scrollToItem(at: indexPath, at: .top, animated: true)
                return true
            }
        }

        return false
    }
}

extension DocumentNode: ASCollectionDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return document.items.count
    }

    public func collectionView(_ collectionView: ASCollectionView, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        guard indexPath.item < document.items.count else {
            return ASCellNode()
        }

        let item = document.items[indexPath.item]
        guard let cellNode = item.cellNode(style: documentStyle) else {
            return ASCellNode()
        }

        if var linkable = cellNode as? Linkable {
            linkable.linkDelegate = self
        }

        return cellNode
    }

}

extension DocumentNode: ASCollectionDelegate, ASCollectionDelegateFlowLayout {

    public func collectionView(_ collectionView: ASCollectionView,
                               constrainedSizeForNodeAt indexPath: IndexPath) -> ASSizeRange {
        let maxHeight = CGFloat.greatestFiniteMagnitude
        let itemWidth: CGFloat = view.frame.width
        let minSize = CGSize(width: itemWidth, height: 0)
        let maxSize = CGSize(width: itemWidth, height: maxHeight)
        let sizeRange = ASSizeRangeMake(minSize, maxSize)

        return sizeRange
    }

}

extension DocumentNode: LinkDelegate {

    public func linkTapped(_ url: URL) {
        delegate?.linkTapped(url)
    }

}
