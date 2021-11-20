//
//  ContentView.swift
//  fhnw-ios-clock
//

import SwiftUI


struct ClockView: View {
    
    @ObservedObject var viewModel: ClockViewModel
    
    @State var receiver = Timer.publish(every: 1, on: .current, in: .default).autoconnect()
    @State var currentTime = Time(hour: 0, min: 0, sec: 0)

    var body: some View {
        ZStack {
            ClockFace()
            // Hour
            // Note: Since 'currentTime' gets updated via the .onAppear and .onReceive,
            //       the WatchHands get recalculated properly
            WatchHand(thickness: 8, lengthPercentage: 0.7, color: Color.black, angle: viewModel.getHourDegree(currentTime))
            
            // Minute
            WatchHand(thickness: 4, lengthPercentage: 0.9, color: Color.black, angle: viewModel.getMinDegree(currentTime))

            // Second
            WatchHand(thickness: 2.5, lengthPercentage: 0.92, color: Color.red, angle: viewModel.getSecDegree(currentTime))
            
            // Center circle
            Circle()
                .fill(Color.red)
                .frame(width: 15, height: 15)
        }
        .onAppear() {
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                self.currentTime = viewModel.getCurrentTime()
            }
        }
        .onReceive(receiver) { _ in
            withAnimation(Animation.easeInOut(duration: 0.1)) {
                self.currentTime = viewModel.getCurrentTime()
            }
        }
    }
}



// MARK: - WatchHand
struct WatchHand: View {

    var thickness: CGFloat
    var lengthPercentage: CGFloat
    var color: Color
    var angle: Double
        
    // MARK: - DrawingConstants
    let width = UIScreen.main.bounds.width
    let border: CGFloat = 100

    
    var length : CGFloat {
        return lengthPercentage * (width - border) / 2
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
    // MARK: - DrawingConstants
    let width = UIScreen.main.bounds.width
    let border: CGFloat = 100

    var body: some View {
        ZStack {
            // Minute markings
            clockMarkings(amount: 60, thickness: 2, length: 8)

            // Hour markings
            clockMarkings(amount: 12, thickness: 3, length: 12)

            // Larger three hour markings
            clockMarkings(amount: 4, thickness: 4, length: 16)

        }
    }
    
    func clockMarkings(amount: Int, thickness: CGFloat, length: CGFloat) -> some View {
        // see https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-views-in-a-loop-using-foreach
        // The .id(: \.self)  is required when you use variables in the range 0..<amount
        return ForEach(0..<amount, id: \.self) { i in
            Rectangle().fill(Color.primary)
                .frame(width: thickness, height: length)
                .offset(y: (width - (border + length)) / 2)
                .rotationEffect(.init(degrees: Double(i) * (360 / Double(amount))))
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    // Here, you can configure special settings for the in-built preview
    // see https://developer.apple.com/documentation/swiftui/previewprovider
    static var previews: some View {
        let viewModel = ClockViewModel()
        return ClockView(viewModel: viewModel)
    }
}
