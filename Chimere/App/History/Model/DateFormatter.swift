//
//  DateFormatter.swift
//  Chimere
//
//  Created by Damien Rojo on 30.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

final class DateFormatter {
    
    class func hourMinutesFormat(stringDate: String) -> String {
        var interval: Double = 0
        let convertedDate = stringDate.components(separatedBy: ":")
        for (index, part) in convertedDate.reversed().enumerated() {
            interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
        }
        let date = Date(timeIntervalSinceNow: interval)
        let formatter = Foundation.DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}
