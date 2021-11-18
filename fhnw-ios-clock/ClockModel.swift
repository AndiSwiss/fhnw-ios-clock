//
//  ClockModel.swift
//  fhnw-ios-clock
//

import Foundation


struct ClockModel {
    var hour: Int
    var min: Int
    var sec: Int
    
    
    func getTime() -> String {
        "\(hour):\(min):\(sec)"
    }

}
