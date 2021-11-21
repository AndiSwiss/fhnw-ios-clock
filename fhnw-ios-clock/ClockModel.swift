import Foundation

// Model for the app
struct ClockModel {
    var time: Time
    var timeZone: TimeZone
    
    static let timeZones: [TimeZone] = [
        TimeZone(city: "Zürich", hourOffset: 0, minOffset: 0),
        TimeZone(city: "London", hourOffset: 1, minOffset: 0)
    ]
    
    struct Time {
        var hour: Int
        var min: Int
        var sec: Int
    }
    
    struct TimeZone {
        var city: String
        var hourOffset: Int
        var minOffset: Int
    }
}
