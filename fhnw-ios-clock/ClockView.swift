//
//  ContentView.swift
//  fhnw-ios-clock
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            ClockFace()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    // Here, you can configure special settings for the in-built preview
    // see https://developer.apple.com/documentation/swiftui/previewprovider
    static var previews: some View {
        ContentView()
    }
}


struct ClockFace : View {
    var width = UIScreen.main.bounds.width

    var body: some View {
        // Minute markings
        clockMarkings(amount: 60, thickness: 2, length: 6)

        // Hour markings
        clockMarkings(amount: 12, thickness: 3, length: 12)

        // Larger three hour markings
        clockMarkings(amount: 4, thickness: 4, length: 16)

    }
    
    func clockMarkings(amount: Int, thickness: CGFloat, length: CGFloat) -> some View {
        // see https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-views-in-a-loop-using-foreach
        // The .id(: \.self)  is required!
        return ForEach(0..<amount, id: \.self) { i in
            Rectangle().fill(Color.primary)
                .frame(width: thickness, height: length)
                .offset(y: (width - (100 + length)) / 2)
                .rotationEffect(.init(degrees: Double(i) * (360 / Double(amount))))
        }
    }
}


