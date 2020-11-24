//
//  RealmManager.swift
//  MyDiary
//
//  Created by Hardik on 24/11/20.
//  Copyright © 2020 MyDiary. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager: NSObject {
    fileprivate var realm: Realm!
    static let shared: RealmManager = {
        let manager = RealmManager()
        do {
            try manager.realm = Realm()
        } catch let error {
            print(error)
        }
        return manager
    }()
    
    fileprivate let semaphore = DispatchSemaphore(value: 0)
    
    func write(withoutNotifying shouldNotify: Bool = true, _ block: @escaping () -> Void) {
        DispatchQueue.main.async {
            do {
                if shouldNotify {
                    try self.realm.write(block)
                } else {
                    
                }
                self.semaphore.signal()
            } catch let error {
                print(error)
                self.semaphore.signal()
            }
            self.semaphore.wait()
        }
    }
}
