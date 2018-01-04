//
//  Document.swift
//  IpfsApp
//
//  Created by Teo on 09/11/15.
//  Copyright © 2015 Teo Sartori. All rights reserved.
//

import Cocoa
import SwiftIpfsApi

class Document: NSDocument {

    @IBOutlet weak var IpfsNodeId: NSTextField!
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }

    override func windowControllerDidLoadNib(_ aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
        // Add any code here that needs to be executed once the windowController has loaded the document's window.
        do {
            let api = try IpfsApi(host: "127.0.0.1", port: 5001)
            
            try api.id() {
                (idData : JsonType) in
                
                let winName = idData.object?["ID"]?.string
    
                DispatchQueue.main.async {
                    self.IpfsNodeId.stringValue = winName!
                }
            }
            
        } catch {
            Swift.print("There was an error initializing the IPFS api client: \(error)")
        }

    }

    override class var autosavesInPlace: Bool { return true }

    override var windowNibName: NSNib.Name? { return NSNib.Name(rawValue: "Document") }
    
    override func data(ofType typeName: String) throws -> Data {
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }

    override func read(from data: Data, ofType typeName: String) throws {
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }
}

