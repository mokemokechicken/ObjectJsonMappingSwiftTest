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
    
    if let b1 = ET.fromData(data) {
      println(b1.toJsonString())
        let d1 = b1.toJsonData()
        let b2 = ET.fromData(d1)!
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

let bundle = NSBundle.mainBundle()

var ret = [String:ResultType]()

ret["Book should be OK: "] = checkJsonEntity(Book.self, bundle.pathForResource("book", ofType: "json")!)
ret["Order should be OK: "] = checkJsonEntity(Order.self, bundle.pathForResource("order", ofType: "json")!)
ret["TypeCheck should be OK: "] = checkJsonEntity(TypeCheck.self, bundle.pathForResource("TypeCheck", ofType: "json")!)
ret["bookError should be ParseNG: "] = checkJsonEntity(TypeCheck.self, bundle.pathForResource("bookError", ofType: "json")!)
ret["bookErrorLackKey should be ParseNG: "] = checkJsonEntity(TypeCheck.self, bundle.pathForResource("bookErrorLackKey", ofType: "json")!)

for (name, result) in ret {
    println("\(name) \(result.rawValue)")
}
