import Foundation

// Model for the app
struct ClockModel {
    var time: Time
    var city: String
    var hourOffset: Int
    var minOffset: Int
    
    struct Time {
        var hour: Int
        var min: Int
        var sec: Int
    }
}
