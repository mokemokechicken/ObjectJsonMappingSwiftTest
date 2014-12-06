import Foundation

private func encode(obj: AnyObject?) -> AnyObject {
    switch obj {
    case nil:
        return NSNull()
        
    case let ojmObject as JsonGenEntityBase:
        return ojmObject.toJsonDictionary()
        
    default:
        return obj!
    }
}

private func decodeOptional(obj: AnyObject?) -> AnyObject? {
    switch obj {
    case let x as NSNull:
        return nil
    
    default:
        return obj
    }
}

public class JsonGenEntityBase {
    public init() {

    }

    public func toJsonDictionary() -> NSDictionary {
        return NSDictionary()
    }

    public func toJsonData() -> NSData {
        var obj = toJsonDictionary()
        return NSJSONSerialization.dataWithJSONObject(obj, options: NSJSONWritingOptions.PrettyPrinted, error: nil)!
    }

    public func toJsonString() -> NSString {
        return NSString(data: toJsonData(), encoding: NSUTF8StringEncoding)!
    }

    public class func fromData(data: NSData!) -> JsonGenEntityBase? {
        if data == nil {
            return nil
        }
        var hash = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary
        return fromJsonDictionary(hash)
    }

    public class func fromJsonDictionary(hash: NSDictionary?) -> JsonGenEntityBase? {
        return nil
    }
}

public class Book_option : JsonGenEntityBase {
    var hoge: String?
    var hara: Bool?

    public override func toJsonDictionary() -> NSDictionary {
        var hash = NSMutableDictionary()
        if let x = self.hoge {
            hash["hoge"] = encode(x)
        }

        if let x = self.hara {
            hash["hara"] = encode(x)
        }

        return hash
    }

    public override class func fromJsonDictionary(hash: NSDictionary?) -> Book_option? {
        if let h = hash {
            var this = Book_option()
            this.hoge = h["hoge"] as? String
            this.hara = h["hara"] as? Bool
            return this
        } else {
            return nil
        }
    }
}

public class Book : JsonGenEntityBase {
    var authors: [Author] = [Author]()
    var title: String = ""
    var year: Int = 0
    var note: String?
    var price: Double = 0
    var option: Book_option?

    public override func toJsonDictionary() -> NSDictionary {
        var hash = NSMutableDictionary()
        hash["authors"] = self.authors.map {x in encode(x)}
        hash["title"] = encode(self.title)
        hash["year"] = encode(self.year)
        if let x = self.note {
            hash["note"] = encode(x)
        }

        hash["price"] = encode(self.price)
        if let x = self.option {
            hash["option"] = x.toJsonDictionary()
        }

        return hash
    }

    public override class func fromJsonDictionary(hash: NSDictionary?) -> Book? {
        if let h = hash {
            var this = Book()
            if let xx = h["authors"] as? [NSDictionary] {
                for x in xx {
                    if let obj = Author.fromJsonDictionary(x) {
                        this.authors.append(obj)
                    } else {
                        return nil
                    }
                }
            } else {
                return nil
            }

            if let x = h["title"] as? String {
                this.title = x
            } else {
                return nil
            }

            if let x = h["year"] as? Int {
                this.year = x
            } else {
                return nil
            }

            this.note = h["note"] as? String
            if let x = h["price"] as? Double {
                this.price = x
            } else {
                return nil
            }

            this.option = Book_option.fromJsonDictionary(h["option"] as? NSDictionary)
            return this
        } else {
            return nil
        }
    }
}

public class Author : JsonGenEntityBase {
    var name: String = ""
    var others: [Book]?

    public override func toJsonDictionary() -> NSDictionary {
        var hash = NSMutableDictionary()
        hash["name"] = encode(self.name)
        if let x = self.others {
            hash["others"] = x.map {x in encode(x)}
        }

        return hash
    }

    public override class func fromJsonDictionary(hash: NSDictionary?) -> Author? {
        if let h = hash {
            var this = Author()
            if let x = h["name"] as? String {
                this.name = x
            } else {
                return nil
            }

            if let xx = h["others"] as? [NSDictionary] {
                this.others = [Book]()
                for x in xx {
                    if let obj = Book.fromJsonDictionary(x) {
                        this.others!.append(obj)
                    } else {
                        return nil
                    }
                }
            }

            return this
        } else {
            return nil
        }
    }
}

