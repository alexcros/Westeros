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
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "es_ES_PREEURO")
        let d = dateFormatter.date(from: dateString)!
        self.init(timeInterval: 0, since: d)
        
    }
}
