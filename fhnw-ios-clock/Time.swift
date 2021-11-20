//
//  MyTime.swift
//  fhnw-ios-clock
//
//  Created by Andreas Ambühl on 20.11.21.
//

import Foundation


struct Time {
    var hour: Int
    var min: Int
    var sec: Int
    
    
    func getTime() -> String {
        "\(hour):\(min):\(sec)"
    }
}
