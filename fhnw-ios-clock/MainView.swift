//
//  ContentView.swift
//  fhnw-ios-clock
//

import SwiftUI

// MARK: - Main View
struct MainView: View {
    
    @ObservedObject var viewModel: ClockViewModel
    @State private var receiver = Timer.publish(every: 1, on: .current, in: .default).autoconnect()
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ClockView(viewModel: viewModel, clockScaling: 1)
                    .frame(height: geo.size.height * 0.18)
                
                ClockView(viewModel: viewModel, clockScaling: 1)
                    .frame(height: geo.size.height * 0.28)
                
                ClockView(viewModel: viewModel, clockScaling: 1)
                    .frame(height: geo.size.height * 0.48)

            }
            .padding()
            .frame(height: geo.size.height)
            .onAppear() {
                withAnimation(Animation.easeInOut(duration: 0.8)) {
                    viewModel.updateTime()
                }
            }
            .onReceive(receiver) { _ in
                withAnimation(Animation.easeInOut(duration: 0.5)) {
                    viewModel.updateTime()
                }
            }
        }
    }
}


// MARK: - Whole Clock
struct ClockView: View {
    
    @ObservedObject var viewModel: ClockViewModel
    
    // MARK: - Dynamic Draw Scaling
    var clockScaling: Double

    
    var body: some View {
        GeometryReader { geo in
            // Get the available size:
            let size = min(geo.size.width, geo.size.height)
            // calculate the clock radius
            let clockRadius = size * clockScaling / 2

            ZStack {
                ClockFace(clockScaling: clockScaling, size: size)
                // Hour
                // Note: Since 'currentTime' gets updated via the .onAppear and .onReceive,
                //       the WatchHands get redrawn properly
                WatchHand(thickness: 0.04 * clockRadius, lengthPercentage: 0.7, color: Color.black, angle: viewModel.getHourDegree(), clockScaling: clockScaling, size: size)

                // Minute
                WatchHand(thickness: 0.02 * clockRadius, lengthPercentage: 0.9, color: Color.black, angle: viewModel.getMinDegree(), clockScaling: clockScaling, size: size)

                // Second
                WatchHand(thickness: 0.012 * clockRadius, lengthPercentage: 0.92, color: Color.red, angle: viewModel.getSecDegree(), clockScaling: clockScaling, size: size)
                
                // Center circle
                Circle()
                    .fill(Color.red)
                    .frame(width: 0.08 * clockRadius, height: 0.08 * clockRadius)
            }
            .frame(width: size)
            .frame(width: geo.size.width, height: geo.size.height)
            // Note: The 2nd .frame is used to automatically center the content, according to
            // https://www.hackingwithswift.com/books/ios-swiftui/resizing-images-to-fit-the-screen-using-geometryreader
        }
    }
}


// MARK: - WatchHand
struct WatchHand: View {

    var thickness: CGFloat
    var lengthPercentage: CGFloat
    var color: Color
    var angle: Double
        
    // MARK: - Dynamic Draw Scaling
    var clockScaling: Double
    var size: CGFloat

    var body: some View {
        let clockRadius = size * clockScaling / 2
        let length = lengthPercentage * clockRadius
        
        RoundedRectangle(cornerRadius: 25, style: .continuous)
            .fill(color)
            // Note: width should not be less than 1 pixel, otherwise it would not be drawn => hence   max(thickness, 1)
            .frame(width: max(thickness, 1), height: length)
            .offset(y: -length/2)
            .rotationEffect(.init(degrees: angle))
    }
}


// MARK: - ClockFace
struct ClockFace: View {
    // MARK: - Dynamic Draw Scaling
    var clockScaling: Double
    var size: CGFloat

    var body: some View {
        let clockRadius = size * clockScaling / 2

        ZStack {
            // Minute markings
            clockMarkings(amount: 60, thicknessMult: 1.0, lengthMult: 4.0, clockRadius: clockRadius, minSize: 1)

            // Hour markings
            clockMarkings(amount: 12, thicknessMult: 2.0, lengthMult: 8.0, clockRadius: clockRadius, minSize: 2)

            // Larger three hour markings
            clockMarkings(amount: 4, thicknessMult: 3.0, lengthMult: 10.0, clockRadius: clockRadius, minSize: 2)
        }
    }
    
    func clockMarkings(amount: Int, thicknessMult: CGFloat, lengthMult: CGFloat, clockRadius: CGFloat, minSize: CGFloat) -> some View {
        // Note: thickness and length should not be less than 1 pixel, otherwise it would not be drawn => hence   max(thickness, 1)
        // And by replacing the fixed 1 pixel with 2 pixel for hour/three hour markings: hours are still visible even when clock is really small
        let thickness = max(0.01 * clockRadius * thicknessMult, minSize)
        let length = max(0.01 * clockRadius * lengthMult, minSize)

        // see https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-views-in-a-loop-using-foreach
        // The .id(: \.self)  is required when you use variables in the range 0..<amount
        return ForEach(0..<amount, id: \.self) { i in
            Rectangle().fill(Color.primary)
                .frame(width: thickness, height: length)
                .offset(y: clockRadius - length / 2)
                .rotationEffect(.init(degrees: Double(i) * (360 / Double(amount))))
        }
    }
}


// MARK: - Preview Provider
struct ContentView_Previews: PreviewProvider {
    // Here, you can configure special settings for the in-built preview
    // see https://developer.apple.com/documentation/swiftui/previewprovider
    static var previews: some View {
        let viewModel = ClockViewModel()
        return MainView(viewModel: viewModel)
    }
}
