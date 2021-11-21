//
//  DateTimeUtils.swift
//  fhnw-ios-clock
//
//  Created by Dario Breitenstein on 21.11.21.
//

import Foundation

class DateTimeUtils {
    static func getLocalizedDateAsComponents(date: Date, timeZone: TimeZone) -> DateComponents {
       var calendar = Calendar.current
       calendar.timeZone = timeZone
       return calendar.dateComponents([.hour, .minute, .second], from: date)
    }
}
