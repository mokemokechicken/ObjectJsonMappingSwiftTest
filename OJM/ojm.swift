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
        // Encode hoge
        if let x = self.hoge {
            hash["hoge"] = encode(x)
        }

        // Encode hara
        if let x = self.hara {
            hash["hara"] = encode(x)
        }

        return hash
    }

    public override class func fromJsonDictionary(hash: NSDictionary?) -> Book_option? {
        if let h = hash {
            var this = Book_option()
            // Decode hoge
            this.hoge = h["hoge"] as? String
            // Decode hara
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
        // Encode authors
        hash["authors"] = self.authors.map {x in encode(x)}
        // Encode title
        hash["title"] = encode(self.title)
        // Encode year
        hash["year"] = encode(self.year)
        // Encode note
        if let x = self.note {
            hash["note"] = encode(x)
        }

        // Encode price
        hash["price"] = encode(self.price)
        // Encode option
        if let x = self.option {
            hash["option"] = x.toJsonDictionary()
        }

        return hash
    }

    public override class func fromJsonDictionary(hash: NSDictionary?) -> Book? {
        if let h = hash {
            var this = Book()
            // Decode authors
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

            // Decode title
            if let x = h["title"] as? String {
                this.title = x
            } else {
                return nil
            }

            // Decode year
            if let x = h["year"] as? Int {
                this.year = x
            } else {
                return nil
            }

            // Decode note
            this.note = h["note"] as? String
            // Decode price
            if let x = h["price"] as? Double {
                this.price = x
            } else {
                return nil
            }

            // Decode option
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
        // Encode name
        hash["name"] = encode(self.name)
        // Encode others
        if let x = self.others {
            hash["others"] = x.map {x in encode(x)}
        }

        return hash
    }

    public override class func fromJsonDictionary(hash: NSDictionary?) -> Author? {
        if let h = hash {
            var this = Author()
            // Decode name
            if let x = h["name"] as? String {
                this.name = x
            } else {
                return nil
            }

            // Decode others
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

public class Item : JsonGenEntityBase {
    var name: String = ""
    var price: Int = 0
    var on_sale: Bool?

    public override func toJsonDictionary() -> NSDictionary {
        var hash = NSMutableDictionary()
        // Encode name
        hash["name"] = encode(self.name)
        // Encode price
        hash["price"] = encode(self.price)
        // Encode on_sale
        if let x = self.on_sale {
            hash["on_sale"] = encode(x)
        }

        return hash
    }

    public override class func fromJsonDictionary(hash: NSDictionary?) -> Item? {
        if let h = hash {
            var this = Item()
            // Decode name
            if let x = h["name"] as? String {
                this.name = x
            } else {
                return nil
            }

            // Decode price
            if let x = h["price"] as? Int {
                this.price = x
            } else {
                return nil
            }

            // Decode on_sale
            this.on_sale = h["on_sale"] as? Bool
            return this
        } else {
            return nil
        }
    }
}

public class User : JsonGenEntityBase {
    var name: String = ""
    var birthday: String?

    public override func toJsonDictionary() -> NSDictionary {
        var hash = NSMutableDictionary()
        // Encode name
        hash["name"] = encode(self.name)
        // Encode birthday
        if let x = self.birthday {
            hash["birthday"] = encode(x)
        }

        return hash
    }

    public override class func fromJsonDictionary(hash: NSDictionary?) -> User? {
        if let h = hash {
            var this = User()
            // Decode name
            if let x = h["name"] as? String {
                this.name = x
            } else {
                return nil
            }

            // Decode birthday
            this.birthday = h["birthday"] as? String
            return this
        } else {
            return nil
        }
    }
}

public class Order_comments : JsonGenEntityBase {
    var user: User = User()
    var message: String = ""
    var deleted: Bool?

    public override func toJsonDictionary() -> NSDictionary {
        var hash = NSMutableDictionary()
        // Encode user
        hash["user"] = self.user.toJsonDictionary()
        // Encode message
        hash["message"] = encode(self.message)
        // Encode deleted
        if let x = self.deleted {
            hash["deleted"] = encode(x)
        }

        return hash
    }

    public override class func fromJsonDictionary(hash: NSDictionary?) -> Order_comments? {
        if let h = hash {
            var this = Order_comments()
            // Decode user
            if let x = User.fromJsonDictionary(h["user"] as? NSDictionary) {
                this.user = x
            } else {
                return nil
            }

            // Decode message
            if let x = h["message"] as? String {
                this.message = x
            } else {
                return nil
            }

            // Decode deleted
            this.deleted = h["deleted"] as? Bool
            return this
        } else {
            return nil
        }
    }
}

public class Order : JsonGenEntityBase {
    var user: User = User()
    var items: [Item] = [Item]()
    var comments: [Order_comments] = [Order_comments]()

    public override func toJsonDictionary() -> NSDictionary {
        var hash = NSMutableDictionary()
        // Encode user
        hash["user"] = self.user.toJsonDictionary()
        // Encode items
        hash["items"] = self.items.map {x in encode(x)}
        // Encode comments
        hash["comments"] = self.comments.map {x in encode(x)}
        return hash
    }

    public override class func fromJsonDictionary(hash: NSDictionary?) -> Order? {
        if let h = hash {
            var this = Order()
            // Decode user
            if let x = User.fromJsonDictionary(h["user"] as? NSDictionary) {
                this.user = x
            } else {
                return nil
            }

            // Decode items
            if let xx = h["items"] as? [NSDictionary] {
                for x in xx {
                    if let obj = Item.fromJsonDictionary(x) {
                        this.items.append(obj)
                    } else {
                        return nil
                    }
                }
            } else {
                return nil
            }

            // Decode comments
            if let xx = h["comments"] as? [NSDictionary] {
                for x in xx {
                    if let obj = Order_comments.fromJsonDictionary(x) {
                        this.comments.append(obj)
                    } else {
                        return nil
                    }
                }
            } else {
                return nil
            }

            return this
        } else {
            return nil
        }
    }
}

