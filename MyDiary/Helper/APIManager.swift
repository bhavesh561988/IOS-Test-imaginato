//
//  APIManager.swift
//  MyDiary
//
//  Created by Hardik on 24/11/20.
//  Copyright © 2020 MyDiary. All rights reserved.
//

import Foundation

import Alamofire

import RealmSwift

class APIManager{
    static let shared = APIManager()
    
    func APICallGetMyDiary(complition:@escaping ((_ statuscode:Int) -> Void)) {            
            print("urlString:--", APIs.APIGetMyDiary)
            AF.request(APIs.APIGetMyDiary, method: .get).responseJSON(completionHandler: { (response) in
                print("response:- ", response)
                if let statusCode = response.response?.statusCode{
                    if statusCode == StatusCode.Unauthorized.rawValue {
                        complition(statusCode)
                    }
                    else if statusCode == StatusCode.Bad.rawValue {
                        
                        complition(statusCode)
                    }
                    else{
                        let objJson = response.value as! [[String: Any]]?
                        do {
                            let dataList = try objJson.map({try JSONSerialization.data(withJSONObject: $0, options: .prettyPrinted)})
                            let arrvalue = try JSONDecoder().decode(Array<Diary>.self, from: dataList!)
                            for diary in arrvalue {
                                diary.insertOrUpdate { (diary) in
                                    
                                }
                            }
                        } catch {
                            print(error)
                        }
                        complition(statusCode)
                    }
                }
            })
        }
}
