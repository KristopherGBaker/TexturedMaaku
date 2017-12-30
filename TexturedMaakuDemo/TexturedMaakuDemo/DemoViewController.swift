//
//  DemoViewController.swift
//  TexturedMaakuDemo
//
//  Created by Kris Baker on 12/20/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import Maaku
import TexturedMaaku
import UIKit

class DemoViewController: DocumentViewController {
    
    init(resourceName: String) {
        PluginManager.registerParsers([YoutubePluginParser()])
        NodePluginManager.registerMappings([YoutubeNodePluginMap()])
        
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "md"),
            let text: String = try? String(contentsOfFile: path),
            let document = try? Document(text: text, options: .footnotes) else {
                fatalError()
        }
        
        super.init(document: document)
        
        title = resourceName.capitalized
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func linkTapped(_ url: URL) {
        if let scheme = url.scheme, scheme == "commonmark", let host = url.host, !host.isEmpty {
            let vc = DemoViewController(resourceName: host)
            navigationController?.pushViewController(vc, animated: true)
        }
        else {
            super.linkTapped(url)
        }
        
        debugPrint(url)
    }
    
}
