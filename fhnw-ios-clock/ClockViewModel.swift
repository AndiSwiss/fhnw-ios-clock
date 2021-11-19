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
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: Date())
        let min = calendar.component(.minute, from: Date())
        let sec = calendar.component(.second, from: Date())
        return ClockModel(hour: hour, min: min, sec: sec)
    }
    
    
    func getHourDegree() -> Double {
        // 360 degrees / 12 = 30 degrees
        return (Double(model.hour) + Double(model.min)/60 ) * 30
    }
    
    func getMinDegree() -> Double {
        // 360 degrees / 60 = 6 degrees
        return Double(model.min) * 6
    }
    
    func getSecDegree() -> Double {
        return Double(model.sec) * 6
    }
}
