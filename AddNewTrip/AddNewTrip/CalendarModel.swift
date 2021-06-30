//
//  CalendarModel.swift
//  testtest
//
//  Created by 한상진 on 2021/06/30.
//

import Foundation
struct CalendarModel {
    var yearAndMonth: String
    var days: [String] = []
    
    init(yearAndMonth: String, days: [String]){
        self.yearAndMonth = yearAndMonth
        self.days = days
    }
}
