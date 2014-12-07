//
//  main.swift
//  ObjectJsonMapping
//
//  Created by 森下 健 on 2014/12/06.
//  Copyright (c) 2014年 Yumemi. All rights reserved.
//

import Foundation

enum ResultType : String {
    case OK = "OK"
    case ParseNG = "ParseNG"
    case RepeatNG = "RepeatNG"
}

func checkJsonEntity<ET : JsonGenEntityBase>(EntityType: ET.Type, filename: String) -> ResultType {
    var data = NSData(contentsOfFile: filename)!
    
    if let b1 = ET.fromData(data) as? ET {
        println(b1.toJsonString(pritty: true))
        let d1 = b1.toJsonData()
        let b2 = ET.fromData(d1) as ET
        let d2 = b2.toJsonString()
        if b1.toJsonString() == b2.toJsonString() {
            return .OK
        } else {
            return .RepeatNG
        }
    } else {
        return .ParseNG
    }
}

func checkJsonArray<ET : JsonGenEntityBase>(EntityType: ET.Type, filename: String) -> ResultType {
    if let a1 = ET.fromData(NSData(contentsOfFile: filename)!) as? [ET] {
        println(ET.toJsonString(a1, pritty: true))
        let d1 = ET.toJsonData(a1)
        let a2 = ET.fromData(d1) as [ET]
        let d2 = ET.toJsonData(a2)
        if ET.toJsonString(a1) == ET.toJsonString(a2) {
            return .OK
        } else {
            return .RepeatNG
        }
    } else {
        return .ParseNG
    }
}

let bundle = NSBundle.mainBundle()

var ret = [String:ResultType]()

ret["Book should be OK: "] = checkJsonEntity(Book.self, bundle.pathForResource("book", ofType: "json")!)
ret["Order should be OK: "] = checkJsonEntity(Order.self, bundle.pathForResource("order", ofType: "json")!)
ret["TypeCheck should be OK: "] = checkJsonEntity(TypeCheck.self, bundle.pathForResource("TypeCheck", ofType: "json")!)
ret["bookError should be ParseNG: "] = checkJsonEntity(TypeCheck.self, bundle.pathForResource("bookError", ofType: "json")!)
ret["bookErrorLackKey should be ParseNG: "] = checkJsonEntity(TypeCheck.self, bundle.pathForResource("bookErrorLackKey", ofType: "json")!)
ret["[Author] should be OK: "] = checkJsonArray(Author.self, bundle.pathForResource("authors", ofType: "json")!)

for (name, result) in ret {
    println("\(name) \(result.rawValue)")
}
