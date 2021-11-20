//
//  ClockViewModel.swift
//  fhnw-ios-clock
//

import Foundation



// if it is "ObservableObject", it can be   @ObservedObject   in the View
// see slide 6 of "9-Property Wrappers.pdf"

class ClockViewModel: ObservableObject {
    
    @Published private var model: ClockModel
    
    init() {
        model = ClockViewModel.createClock()
    }
    
    
    static func createClock() -> ClockModel {
        return ClockModel(myTime: Time(hour: 0, min: 0, sec: 0))
    }
    
    func getCurrentTime() -> Time {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: Date())
        let min = calendar.component(.minute, from: Date())
        let sec = calendar.component(.second, from: Date())
        return Time(hour: hour, min: min, sec: sec)
    }
    
    
    func getHourDegree(_ currentTime: Time) -> Double {
        // 360 degrees / 12 = 30 degrees
        return (Double(currentTime.hour) + Double(model.myTime.min)/60 ) * 30
    }
    
    func getMinDegree(_ currentTime: Time) -> Double {
        // 360 degrees / 60 = 6 degrees
        return Double(currentTime.min) * 6
    }
    
    func getSecDegree(_ currentTime: Time) -> Double {
        return Double(currentTime.sec) * 6
    }
}
