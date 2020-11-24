//
//  RealmDiary.swift
//  MyDiary
//
//  Created by Hardik on 24/11/20.
//  Copyright © 2020 MyDiary. All rights reserved.
//


import Foundation
import Realm
import RealmSwift

struct Diary: Codable, Hashable {
    static func == (lhs: Diary, rhs: Diary) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id : String?
    let title : String?
    let content : String?
    let date : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case content = "content"
        case date = "date"
    }
    
    func getRealmUser() -> RealmDiary {
        let newRealm = RealmDiary()
        newRealm.id = id ?? ""
        newRealm.title = title ?? ""
        newRealm.content = content ?? ""
        newRealm.date = convertIntoDate(formate: date ?? "")
        newRealm.day = newRealm.date.toStringDate()
        return newRealm
    }
    
    func insertOrUpdate(completion: @escaping ((RealmDiary?) -> Void)) {
        do {
            let realm = try Realm()
            let newRealm = self.getRealmUser()
            try realm.write(transaction: {
                realm.add(newRealm, update: .modified)
            }, completion: {
                completion(newRealm)
            })
        } catch {
            print(error)
            completion(nil)
        }
    }
}

extension Diary {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Diary.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

class RealmDiary: Object {
    @objc dynamic var id : String = ""
    @objc dynamic var title : String = ""
    @objc dynamic var content : String = ""
    @objc dynamic var date : Date = Date()
    @objc dynamic var day : String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

extension Realm {
    
    /// Performs actions contained within the given block
    /// inside a write transaction with completion block.
    ///
    /// - parameter block: write transaction block
    /// - parameter completion: completion executed after transaction block
    func write(transaction block: () -> Void, completion: () -> Void) throws {
        try write(block)
        completion()
    }
}




