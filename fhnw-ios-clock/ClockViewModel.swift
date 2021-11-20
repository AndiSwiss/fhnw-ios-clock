//
//  ClockViewModel.swift
//  fhnw-ios-clock
//

import Foundation



// if it is "ObservableObject", it can be   @ObservedObject   in the View
// see slide 6 of "9-Property Wrappers.pdf"

class ClockViewModel: ObservableObject {
    
    @Published private var model: Time
    
    // MARK: - Initializer
    init() {
        model = ClockViewModel.createClock()
    }
    
    static func createClock() -> Time {
        // Initialize with 0 for a starting animation to actual current time
        return Time(hour: 0, min: 0, sec: 0)
    }
    
    
    // MARK: - Access to the Model
    // Computed properties:
    var hour: Int {
        return model.hour
    }
    
    var min: Int {
        return model.min
    }
    
    var sec: Int {
        return model.sec
    }

    
    
    // MARK: - Update time
    func updateTime() {
        let calendar = Calendar.current
        let currentDateTime = Date()
        model.hour = calendar.component(.hour, from: currentDateTime)
        model.min = calendar.component(.minute, from: currentDateTime)
        model.sec = calendar.component(.second, from: currentDateTime)
    }
    
    
    // MARK: - Angle conversion
    func getHourDegree() -> Double {
        // 360 degrees / 12 = 30 degrees
        return (Double(hour) + Double(min)/60 ) * 30
    }
    
    
    func getMinDegree() -> Double {
        // 360 degrees / 60 = 6 degrees
        return (Double(min) * 6)
    }

    func getSecDegree() -> Double {
        // 360 degrees / 60 = 6 degrees
        return Double(sec) * 6
    }

}
