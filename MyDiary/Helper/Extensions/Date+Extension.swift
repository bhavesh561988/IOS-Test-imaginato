//
//  Date+Extension.swift
//  MyDiary
//
//  Created by Hardik on 24/11/20.
//  Copyright © 2020 MyDiary. All rights reserved.
//

import Foundation

extension Date {
    func toStringDate(format: String = "dd/MM/yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func toHeaderFormate(format: String = "MMM") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func timeAgoDisplay(_ display: DisplayTime) -> String {

        let secondsAgo = Int(Date().timeIntervalSince(self))

        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day

        switch secondsAgo {
        case let seconds where seconds < minute : return "\(secondsAgo) \(display.seconds) ago"
        case let seconds where seconds < hour: return "\(secondsAgo / minute) \(display.minutes) ago"
        case let seconds where seconds < day: return "\(secondsAgo / hour) \(display.hours) ago"
        case let seconds where seconds < week: return "\(secondsAgo / day) \(display.days) ago"
        default: "\(secondsAgo / week) \(display.weeks) ago"
        }
        return "\(secondsAgo / week) \(display.weeks) ago"
    }
}
