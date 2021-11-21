import SwiftUI

// MARK: - Main View
struct MainView: View {
    
    @ObservedObject var viewModel: ClockViewModel
    @State private var receiver = Timer.publish(every: 1, on: .current, in: .default).autoconnect()
    
    // MARK: - Drawing Constants
    let clockSizeFactor = 0.2
    let fontSizeFactor = 0.07
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                let clockSize = min(geo.size.width, geo.size.height) * clockSizeFactor
                let fontSize = min(geo.size.width, geo.size.height) * fontSizeFactor
                
                ScrollView {
                    VStack(spacing: 5) {
                        Text("World Clock")
                            .font(.largeTitle.bold())
                            .padding()
                        ForEach(viewModel.timeZones) {tzConfig in
                            NavigationLink(destination: ClockDetailView(viewModel: viewModel, tzConfig: tzConfig)) {
                                TimeZoneListElement(clockSize: clockSize, fontSize: fontSize, date: viewModel.date, tzConfig: tzConfig)
                            }.padding()
                        }
                        .background(.thinMaterial)
                    }
                }
                .onAppear() {
                    viewModel.updateTime()
                }
                .onReceive(receiver) { _ in
                    viewModel.updateTime()
                }
                .navigationBarHidden(true)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct TimeZoneListElement : View {
    var clockSize: Double
    var fontSize: Double
    var date: Date
    var tzConfig: ClockModel.TimeZoneConfiguration
    
    var body: some View {
        let tzComponents = DateTimeUtils.getLocalizedDateAsComponents(date: date, timeZone: tzConfig.timeZone)
    
        Text(tzConfig.name)
            // make font size dependant on available width
            .font(.system(size: fontSize))
        
        Spacer()

        ClockView(components: tzComponents)
            .frame(width: clockSize, height: clockSize)
    }
}

struct MainView_Previews: PreviewProvider {
    // Here, you can configure special settings for the in-built preview
    // see https://developer.apple.com/documentation/swiftui/previewprovider
    static var previews: some View {
        let viewModel = ClockViewModel()
        return MainView(viewModel: viewModel)
    }
}
