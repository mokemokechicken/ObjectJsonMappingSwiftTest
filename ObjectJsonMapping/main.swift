//
//  main.swift
//  ObjectJsonMapping
//
//  Created by 森下 健 on 2014/12/06.
//  Copyright (c) 2014年 Yumemi. All rights reserved.
//

import Foundation


func checkJsonEntity<ET : JsonGenEntityBase>(EntityType: ET.Type, filename: String) -> Bool {
    var data = NSData(contentsOfFile: filename)!
    
    if let b1 = ET.fromData(data) {
      println(b1.toJsonString())
        let d1 = b1.toJsonData()
        let b2 = ET.fromData(d1)!
        let d2 = b2.toJsonString()
        if b1.toJsonString() == b2.toJsonString() {
            return true
        } else {
            return false
        }
    } else {
        return false
    }
    
}

let bundle = NSBundle.mainBundle()

var ret = [String:Bool]()

ret["Book"] = checkJsonEntity(Book.self, bundle.pathForResource("book", ofType: "json")!)
ret["Order"] = checkJsonEntity(Order.self, bundle.pathForResource("order", ofType: "json")!)
ret["TypeCheck"] = checkJsonEntity(TypeCheck.self, bundle.pathForResource("TypeCheck", ofType: "json")!)

for (name, success) in ret {
    let result = success ? "OK" : "NG"
    println("\(name) \(result)")
}
