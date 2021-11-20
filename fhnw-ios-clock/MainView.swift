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
        VStack {
            
            
            ClockView(viewModel: viewModel, clockScaling: 0.2)
                .onAppear() {
                    withAnimation(Animation.easeInOut(duration: 0.8)) {
                        viewModel.updateTime()
                    }
                }
                .onReceive(receiver) { _ in
                    withAnimation(Animation.easeInOut(duration: 0.1)) {
                        viewModel.updateTime()
                    }
                }
            
            
            
            ClockView(viewModel: viewModel, clockScaling: 0.4)
                .onAppear() {
                    withAnimation(Animation.easeInOut(duration: 0.8)) {
                        viewModel.updateTime()
                    }
                }
                .onReceive(receiver) { _ in
                    withAnimation(Animation.easeInOut(duration: 0.1)) {
                        viewModel.updateTime()
                    }
                }
            
            
            
            ClockView(viewModel: viewModel, clockScaling: 0.9)
                .onAppear() {
                    withAnimation(Animation.easeInOut(duration: 0.8)) {
                        viewModel.updateTime()
                    }
                }
                .onReceive(receiver) { _ in
                    withAnimation(Animation.easeInOut(duration: 0.1)) {
                        viewModel.updateTime()
                    }
                }
            
            

        }
        .padding()
    }
}

// MARK: - Whole Clock
struct ClockView: View {
    
    @ObservedObject var viewModel: ClockViewModel
    
    // MARK: - Dynamic Draw Scaling
    var clockScaling: Double

    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                let width = geo.size.width
                let clockRadius = width * clockScaling / 2

                ClockFace(clockScaling: clockScaling, width: width)
                // Hour
                // Note: Since 'currentTime' gets updated via the .onAppear and .onReceive,
                //       the WatchHands get redrawn properly
                WatchHand(thickness: 0.04 * clockRadius, lengthPercentage: 0.7, color: Color.black, angle: viewModel.getHourDegree(), clockScaling: clockScaling, width: width)

                // Minute
                WatchHand(thickness: 0.02 * clockRadius, lengthPercentage: 0.9, color: Color.black, angle: viewModel.getMinDegree(), clockScaling: clockScaling, width: width)

                // Second
                WatchHand(thickness: 0.012 * clockRadius, lengthPercentage: 0.92, color: Color.red, angle: viewModel.getSecDegree(), clockScaling: clockScaling, width: width)
                
                // Center circle
                Circle()
                    .fill(Color.red)
                    .frame(width: 0.08 * clockRadius, height: 0.08 * clockRadius)
            }
            .frame(width: geo.size.width)
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
    var width: CGFloat
    private var clockRadius: CGFloat {
        return width * clockScaling / 2
    }
    
    var length : CGFloat {
        return lengthPercentage * clockRadius
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25, style: .continuous)
            .fill(color)
            .frame(width: thickness, height: length)
            .offset(y: -length/2)
            .rotationEffect(.init(degrees: angle))
    }
}


// MARK: - ClockFace
struct ClockFace: View {
    // MARK: - Dynamic Draw Scaling
    var clockScaling: Double
    var width: CGFloat
    private var clockRadius: CGFloat {
        return width * clockScaling / 2
    }

    var body: some View {
        ZStack {
            // Minute markings
            clockMarkings(amount: 60, thickness: 0.01  * clockRadius, length: 0.04 * clockRadius)

            // Hour markings
            clockMarkings(amount: 12, thickness: 0.015 * clockRadius, length: 0.06 * clockRadius)

            // Larger three hour markings
            clockMarkings(amount: 4, thickness: 0.02 * clockRadius, length: 0.08 * clockRadius)

        }
    }
    
    func clockMarkings(amount: Int, thickness: CGFloat, length: CGFloat) -> some View {
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
