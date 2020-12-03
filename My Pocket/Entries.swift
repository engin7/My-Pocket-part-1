//
//  Entries.swift
//  My Pocket
//
//  Created by Engin KUK on 2.12.2020.
//

import Foundation
import GRDB

protocol TextRepresentable {
    var name: String { set get }
}

final class Entries: Record, TextRepresentable {
    
    var id: Int64?
    var name: String
    var appId: Int64?
 
    func newRandom() {}
    func randomScore() {}
    
    override class var databaseTableName: String {
        return "entries"
    }
    
    init(name: String) {
        self.name = name
        self.appId = nil
        super.init()
    }
    
    required init(row: Row) {
        id = row["id"]
        name = row["name"]
        appId = row["appId"]
        
        super.init(row: row)
    }
    // similar to NSCoding protocol functions. GRDB uses them to fetch from and save object to database.
    override func encode(to container: inout PersistenceContainer) {
        container["id"] = id
        container["name"] = name
        container["appId"] = appId
    }
    // make sure to have an unique id
    override func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}
