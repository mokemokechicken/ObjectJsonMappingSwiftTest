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

public class Ary : JsonGenEntityBase {
    var str: [String] = [String]()
    var custom: [Number] = [Number]()
    var opt: [Bool]?

    public override func toJsonDictionary() -> NSDictionary {
        var hash = NSMutableDictionary()
        // Encode str
        hash["str"] = self.str.map {x in encode(x)}
        // Encode custom
        hash["custom"] = self.custom.map {x in encode(x)}
        // Encode opt
        if let x = self.opt {
            hash["opt"] = x.map {x in encode(x)}
        }

        return hash
    }

    public override class func fromJsonDictionary(hash: NSDictionary?) -> Ary? {
        if let h = hash {
            var this = Ary()
            // Decode str
            if let xx = h["str"] as? [String] {
                this.str = xx
            } else {
                return nil
            }

            // Decode custom
            if let xx = h["custom"] as? [NSDictionary] {
                for x in xx {
                    if let obj = Number.fromJsonDictionary(x) {
                        this.custom.append(obj)
                    } else {
                        return nil
                    }
                }
            } else {
                return nil
            }

            // Decode opt
            if let xx = h["opt"] as? [Bool] {
                this.opt = xx
            }

            return this
        } else {
            return nil
        }
    }
}

public class Number : JsonGenEntityBase {
    var value: Int = 0

    public override func toJsonDictionary() -> NSDictionary {
        var hash = NSMutableDictionary()
        // Encode value
        hash["value"] = encode(self.value)
        return hash
    }

    public override class func fromJsonDictionary(hash: NSDictionary?) -> Number? {
        if let h = hash {
            var this = Number()
            // Decode value
            if let x = h["value"] as? Int {
                this.value = x
            } else {
                return nil
            }

            return this
        } else {
            return nil
        }
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
            this.option = Book_option.fromJsonDictionary((h["option"] as? NSDictionary))
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
    var onSale: Bool?

    public override func toJsonDictionary() -> NSDictionary {
        var hash = NSMutableDictionary()
        // Encode name
        hash["name"] = encode(self.name)
        // Encode price
        hash["price"] = encode(self.price)
        // Encode onSale
        if let x = self.onSale {
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

            // Decode onSale
            this.onSale = h["on_sale"] as? Bool
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
            if let x = User.fromJsonDictionary((h["user"] as? NSDictionary)) {
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
            if let x = User.fromJsonDictionary((h["user"] as? NSDictionary)) {
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

public class TypeCheck_type_hash : JsonGenEntityBase {
    var id: Int = 0
    var name: String = ""

    public override func toJsonDictionary() -> NSDictionary {
        var hash = NSMutableDictionary()
        // Encode id
        hash["id"] = encode(self.id)
        // Encode name
        hash["name"] = encode(self.name)
        return hash
    }

    public override class func fromJsonDictionary(hash: NSDictionary?) -> TypeCheck_type_hash? {
        if let h = hash {
            var this = TypeCheck_type_hash()
            // Decode id
            if let x = h["id"] as? Int {
                this.id = x
            } else {
                return nil
            }

            // Decode name
            if let x = h["name"] as? String {
                this.name = x
            } else {
                return nil
            }

            return this
        } else {
            return nil
        }
    }
}

public class TypeCheck : JsonGenEntityBase {
    var typeString: String = ""
    var typeInt: Int = 0
    var typeDouble: Double = 0
    var typeBool: Bool = false
    var typeArray: [String] = [String]()
    var typeHash: TypeCheck_type_hash = TypeCheck_type_hash()
    var typeCustomNormal: OptionalCheck = OptionalCheck()
    var typeCustomOption: OptionalCheck = OptionalCheck()
    var typeCustomArray: [OptionalCheck] = [OptionalCheck]()

    public override func toJsonDictionary() -> NSDictionary {
        var hash = NSMutableDictionary()
        // Encode typeString
        hash["type_string"] = encode(self.typeString)
        // Encode typeInt
        hash["type_int"] = encode(self.typeInt)
        // Encode typeDouble
        hash["type_double"] = encode(self.typeDouble)
        // Encode typeBool
        hash["type_bool"] = encode(self.typeBool)
        // Encode typeArray
        hash["type_array"] = self.typeArray.map {x in encode(x)}
        // Encode typeHash
        hash["type_hash"] = self.typeHash.toJsonDictionary()
        // Encode typeCustomNormal
        hash["type_custom_normal"] = self.typeCustomNormal.toJsonDictionary()
        // Encode typeCustomOption
        hash["type_custom_option"] = self.typeCustomOption.toJsonDictionary()
        // Encode typeCustomArray
        hash["type_custom_array"] = self.typeCustomArray.map {x in encode(x)}
        return hash
    }

    public override class func fromJsonDictionary(hash: NSDictionary?) -> TypeCheck? {
        if let h = hash {
            var this = TypeCheck()
            // Decode typeString
            if let x = h["type_string"] as? String {
                this.typeString = x
            } else {
                return nil
            }

            // Decode typeInt
            if let x = h["type_int"] as? Int {
                this.typeInt = x
            } else {
                return nil
            }

            // Decode typeDouble
            if let x = h["type_double"] as? Double {
                this.typeDouble = x
            } else {
                return nil
            }

            // Decode typeBool
            if let x = h["type_bool"] as? Bool {
                this.typeBool = x
            } else {
                return nil
            }

            // Decode typeArray
            if let xx = h["type_array"] as? [String] {
                this.typeArray = xx
            } else {
                return nil
            }

            // Decode typeHash
            if let x = TypeCheck_type_hash.fromJsonDictionary((h["type_hash"] as? NSDictionary)) {
                this.typeHash = x
            } else {
                return nil
            }

            // Decode typeCustomNormal
            if let x = OptionalCheck.fromJsonDictionary((h["type_custom_normal"] as? NSDictionary)) {
                this.typeCustomNormal = x
            } else {
                return nil
            }

            // Decode typeCustomOption
            if let x = OptionalCheck.fromJsonDictionary((h["type_custom_option"] as? NSDictionary)) {
                this.typeCustomOption = x
            } else {
                return nil
            }

            // Decode typeCustomArray
            if let xx = h["type_custom_array"] as? [NSDictionary] {
                for x in xx {
                    if let obj = OptionalCheck.fromJsonDictionary(x) {
                        this.typeCustomArray.append(obj)
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

public class OptionalCheck_type_hash : JsonGenEntityBase {
    var id: Int = 0
    var name: String = ""

    public override func toJsonDictionary() -> NSDictionary {
        var hash = NSMutableDictionary()
        // Encode id
        hash["id"] = encode(self.id)
        // Encode name
        hash["name"] = encode(self.name)
        return hash
    }

    public override class func fromJsonDictionary(hash: NSDictionary?) -> OptionalCheck_type_hash? {
        if let h = hash {
            var this = OptionalCheck_type_hash()
            // Decode id
            if let x = h["id"] as? Int {
                this.id = x
            } else {
                return nil
            }

            // Decode name
            if let x = h["name"] as? String {
                this.name = x
            } else {
                return nil
            }

            return this
        } else {
            return nil
        }
    }
}

public class OptionalCheck_type_nested_optional : JsonGenEntityBase {
    var value: String?

    public override func toJsonDictionary() -> NSDictionary {
        var hash = NSMutableDictionary()
        // Encode value
        if let x = self.value {
            hash["value"] = encode(x)
        }

        return hash
    }

    public override class func fromJsonDictionary(hash: NSDictionary?) -> OptionalCheck_type_nested_optional? {
        if let h = hash {
            var this = OptionalCheck_type_nested_optional()
            // Decode value
            this.value = h["value"] as? String
            return this
        } else {
            return nil
        }
    }
}

public class OptionalCheck : JsonGenEntityBase {
    var typeString: String?
    var typeInt: Int?
    var typeDouble: Double?
    var typeBool: Bool?
    var typeArray: [String]?
    var typeHash: OptionalCheck_type_hash?
    var typeNestedOptional: OptionalCheck_type_nested_optional = OptionalCheck_type_nested_optional()
    var typeCustom: MyNumber?

    public override func toJsonDictionary() -> NSDictionary {
        var hash = NSMutableDictionary()
        // Encode typeString
        if let x = self.typeString {
            hash["type_string"] = encode(x)
        }

        // Encode typeInt
        if let x = self.typeInt {
            hash["type_int"] = encode(x)
        }

        // Encode typeDouble
        if let x = self.typeDouble {
            hash["type_double"] = encode(x)
        }

        // Encode typeBool
        if let x = self.typeBool {
            hash["type_bool"] = encode(x)
        }

        // Encode typeArray
        if let x = self.typeArray {
            hash["type_array"] = x.map {x in encode(x)}
        }

        // Encode typeHash
        if let x = self.typeHash {
            hash["type_hash"] = x.toJsonDictionary()
        }

        // Encode typeNestedOptional
        hash["type_nested_optional"] = self.typeNestedOptional.toJsonDictionary()
        // Encode typeCustom
        if let x = self.typeCustom {
            hash["type_custom"] = x.toJsonDictionary()
        }

        return hash
    }

    public override class func fromJsonDictionary(hash: NSDictionary?) -> OptionalCheck? {
        if let h = hash {
            var this = OptionalCheck()
            // Decode typeString
            this.typeString = h["type_string"] as? String
            // Decode typeInt
            this.typeInt = h["type_int"] as? Int
            // Decode typeDouble
            this.typeDouble = h["type_double"] as? Double
            // Decode typeBool
            this.typeBool = h["type_bool"] as? Bool
            // Decode typeArray
            if let xx = h["type_array"] as? [String] {
                this.typeArray = xx
            }

            // Decode typeHash
            this.typeHash = OptionalCheck_type_hash.fromJsonDictionary((h["type_hash"] as? NSDictionary))
            // Decode typeNestedOptional
            if let x = OptionalCheck_type_nested_optional.fromJsonDictionary((h["type_nested_optional"] as? NSDictionary)) {
                this.typeNestedOptional = x
            } else {
                return nil
            }

            // Decode typeCustom
            this.typeCustom = MyNumber.fromJsonDictionary((h["type_custom"] as? NSDictionary))
            return this
        } else {
            return nil
        }
    }
}

public class MyNumber : JsonGenEntityBase {
    var number: Int = 0

    public override func toJsonDictionary() -> NSDictionary {
        var hash = NSMutableDictionary()
        // Encode number
        hash["number"] = encode(self.number)
        return hash
    }

    public override class func fromJsonDictionary(hash: NSDictionary?) -> MyNumber? {
        if let h = hash {
            var this = MyNumber()
            // Decode number
            if let x = h["number"] as? Int {
                this.number = x
            } else {
                return nil
            }

            return this
        } else {
            return nil
        }
    }
}

