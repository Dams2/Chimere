//
//  DateFormatter.swift
//  Chimere
//
//  Created by Damien Rojo on 30.04.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import Foundation

final class DateFormatter {
    
    class func dateFormatter(stringDate: String) -> String {
        print("xxxxxxx")
        print(stringDate)
        var interval: Double = 0
        let convertedDate = stringDate.components(separatedBy: ":")
        print("pppppppppp")

        print(convertedDate)
        for (index, part) in convertedDate.reversed().enumerated() {
            interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
        }
        let date = Date(timeIntervalSinceNow: interval)
        print("---------")
        print(date)
        let formatter = Foundation.DateFormatter()
        formatter.dateFormat = "LLLL dd, HH:mm at"
        print(formatter)
        return formatter.string(from: date)
    }
}
