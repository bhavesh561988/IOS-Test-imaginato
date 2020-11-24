//
//  Enum.swift
//  MyDiary
//
//  Created by Hardik on 24/11/20.
//  Copyright © 2020 MyDiary. All rights reserved.
//

import Foundation

enum StatusCode : Int{
    case Unauthorized = 401
    case Bad = 400
    case OK = 200
    case error = 200000
}

enum DisplayTime {
    case short
    case long

    var seconds: String {
        switch self {
        case .short: return "s"
        case .long: return "seconds"
        }
    }

    var minutes: String {
        switch self {
        case .short: return "m"
        case .long: return "minutes"
        }
    }

    var hours: String {
        switch self {
        case .short: return "h"
        case .long: return "hours"
        }
    }

    var days: String {
        switch self {
        case .short: return "d"
        case .long: return "days"
        }
    }

    var weeks: String {
        switch self {
        case .short: return "w"
        case .long: return "weeks"
        }
    }
}
