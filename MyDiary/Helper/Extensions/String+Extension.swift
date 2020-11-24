//
//  String+Extension.swift
//  MyDiary
//
//  Created by Hardik on 24/11/20.
//  Copyright © 2020 MyDiary. All rights reserved.
//

import Foundation

extension String{
    func isEmptyString() -> Bool {
        let _ : Array<String> = []
        let tempText = self.trimmingCharacters(in: CharacterSet.whitespaces)
        if tempText.isEmpty {
            return true
        }
        return false
    }
    
    func headerDisplayDate() -> String  {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        let oldDate = formatter.date(from:self)!
        
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "dd MMM"

        return convertDateFormatter.string(from: oldDate)
        
    }
}
