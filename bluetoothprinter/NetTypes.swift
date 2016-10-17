//
//  NetTypes.swift
//  bluetoothprinter
//
//  Created by Rui Caneira on 10/10/16.
//  Copyright © 2016 Rui Caneira. All rights reserved.
//

import Foundation
import Genome

struct AYOrders : BasicMappable {
    
    var mtype: String = ""
    var mdata: mmdata!
    mutating func sequence(map: Map) throws {
        try mtype <~ map["type"]
        try mdata <~ map["data"]
    }
}

struct mmdata : BasicMappable {
    var mversion: Int!
    var maccount: mmaccount!
    var morders: [mmorders]!
    mutating func sequence(map: Map) throws {
        try mversion <~ map["version"]
        try maccount <~ map["account"]
        try morders <~ map["orders"]
    }
}

struct mmaccount : BasicMappable {
    var mkey: String = ""
    var mversion: Int!
    var mtimezone: String = ""
    var mopen: String = ""
    var mweek: mmweek!
    var mprepTime: Int!
    var mnotifyList: [mmnotifyList]!
    mutating func sequence(map: Map) throws {
        try mkey <~ map["key"]
        try mversion <~ map["version"]
        try mtimezone <~ map["timezone"]
        try mopen <~ map["open"]
        try mweek <~ map["week"]
        try mprepTime <~ map["prepTime"]
        try mnotifyList <~ map["notifyList"]

    }
}

struct mmnotifyList : BasicMappable{
    var mtype: String = ""
    var mto: String = ""
    mutating func sequence(map: Map) throws {
        try mtype <~ map["type"]
        try mto <~ map["to"]
    }
}


struct mmorders : BasicMappable {
    var mkey: String = ""
    var mid: CLong!
    var mtimeZone: String = ""
    var mdate: CLong!
    var mready: CLong!
    var mprepTime: CLong!
    var mtype: String = ""
    var mname: String = ""
    var mphone: String = ""
    var memail: String = ""
    var mcount: CLong!
    var msubtotal: CLong!
    var mtax: CLong!
    var mfee: CLong!
    var mtotal: CLong!
    var mitems: [mmitems]!
    mutating func sequence(map: Map) throws {
        try mkey <~ map["key"]
        try mid <~ map["id"]
        try mtimeZone <~ map["timeZone"]
        try mdate <~ map["date"]
        try mready <~ map["ready"]
        try mprepTime <~ map["prepTime"]
        try mtype <~ map["type"]
        try mname <~ map["name"]
        try mphone <~ map["phone"]
        try memail <~ map["email"]
        try mitems <~ map["items"]
        try mcount <~ map["count"]
        try msubtotal <~ map["subtotal"]
        try mtax <~ map["tax"]
        try mfee <~ map["fee"]
        try mtotal <~ map["total"]
    }

}

struct mmitems : BasicMappable {
    var mname: String = ""
    var mprice: Int!
    var msubtotal: Int!
    var mtotal: Int!
    var mquantity: Int!
    var mmultiple: Bool!
    var mchildren = []
    mutating func sequence(map: Map) throws {
        try mname <~ map["name"]
        try mprice <~ map["price"]
        try msubtotal <~ map["subtotal"]
        try mtotal <~ map["total"]
        try mquantity <~ map["quantity"]
        try mmultiple <~ map["multiple"]
        try mchildren <~ map["children"]
    }
}

struct mmweek : BasicMappable {
    var msunday: mmweekday!
    var mmonday: mmweekday!
    var mtuesday: mmweekday!
    var mwednesday: mmweekday!
    var mthursday: mmweekday!
    var mfriday: mmweekday!
    var msaturday: mmweekday!
    mutating func sequence(map: Map) throws {
        try msunday <~ map["sunday"]
        try mmonday <~ map["monday"]
        try mtuesday <~ map["tuesday"]
        try mwednesday <~ map["wednesday"]
        try mthursday <~ map["thursday"]
        try mfriday <~ map["friday"]
        try msaturday <~ map["saturday"]
    }
    
}

struct mmweekday : BasicMappable {
    var mday: Int!
    var mname: String = ""
    var mranges: [mmranges]!
    mutating func sequence(map: Map) throws {
        try mday <~ map["day"]
        try mname <~ map["name"]
        try mranges <~ map["ranges"]
    }
}

struct mmranges : BasicMappable {
    var mstart: mtime =  mtime()
    var mend: mtime = mtime()
    mutating func sequence(map: Map) throws {
        try mstart <~ map["start"]
        try mend <~ map["end"]
    }
}

struct mtime : BasicMappable {
    var mhour: Int!
    var mminute: Int!
    mutating func sequence(map: Map) throws {
        try mhour <~ map["hour"]
        try mminute <~ map["minute"]
    }
}


