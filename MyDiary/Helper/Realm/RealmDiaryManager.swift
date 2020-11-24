//
//  RealmDiaryManager.swift
//  MyDiary
//
//  Created by Hardik on 24/11/20.
//  Copyright © 2020 MyDiary. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class RealmDiaryManager: NSObject {
    static let shared: RealmDiaryManager = {
        let manager = RealmDiaryManager()
        do {
            manager.realm = try Realm()
        } catch let error {
            print(error)
        }
        return manager
    }()
    
    fileprivate var realm: Realm!
    private(set) var diaryList = [RealmDiary]() {
        didSet {
            observers.forEach { (observer) in
                observer?(diaryList)
            }
        }
    }
    fileprivate var notificationToken: NotificationToken? = nil
    
    fileprivate var observers: [((_ diaryList: [RealmDiary]) -> ())?] = [] {
        didSet {
            print("Observer Count: \(observers.count)")
        }
    }
    
    func clearContacts() {
        diaryList.removeAll()
        observers.removeAll()
    }
    
    func addObserver(_ diary: @escaping ([RealmDiary]) -> ()) {
        if observers.isEmpty {
            fetchContactList()
        }
        observers.append(diary)
        diary(diaryList)
    }
    
    func fetchContactList() {
        let result = realm.objects(RealmDiary.self).sorted(byKeyPath: "date")
        diaryList = Array(result)
        notificationToken = result.observe({ [weak self] (changes: RealmCollectionChange) in
            guard let self = self else {return}
            switch changes {
            case .initial(let list):
                self.diaryList = Array(list)
            case .update(let list, _,  _, _):
                self.diaryList = Array(list)
            case .error(let error):
                print(error)
            }
        })
    }
}
