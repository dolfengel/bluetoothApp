//
//  Model.swift
//  bluetoothprinter
//
//  Created by Rui Caneira on 10/17/16.
//  Copyright © 2016 Rui Caneira. All rights reserved.
//

import Foundation
import Genome

struct AYResponse : BasicMappable{
    var mtype: String = ""
    var mdata: mmResponse!
    mutating func sequence(map: Map) throws {
        try mtype <~ map["type"]
        try mdata <~ map["data"]
    }
    
}

struct mmResponse : BasicMappable{
    var mversion: Int!
    mutating func sequence(map: Map) throws {
        try mversion <~ map["version"]
    }
    
}
