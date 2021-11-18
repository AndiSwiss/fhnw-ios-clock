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
    
    
    func getHour() -> Int {
        return model.hour
    }
    
    func getMin() -> Int {
        return model.min
    }
    
    func getSec() -> Int {
        return model.sec
    }
}
