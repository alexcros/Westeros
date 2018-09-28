//
//  Date+String.swift
//  Westeros
//
//  Created by Alexandre on 24/9/18.
//  Copyright © 2018 Alexandre. All rights reserved.
//

import Foundation

extension Date {

    init(dateString: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_ES")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let d = dateFormatter.date(from: dateString)!
        self.init(timeInterval: 0, since: d)
        
    }
}
