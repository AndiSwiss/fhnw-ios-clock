import SwiftUI

struct ClockDetailView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

    @ObservedObject var viewModel: ClockViewModel
    var tzConfig: ClockModel.TimeZoneConfiguration

    var body: some View {
        let tzComponents = DateTimeUtils.getLocalizedDateAsComponents(date: viewModel.date, timeZone: tzConfig.timeZone)
        
        VStack {
            if horizontalSizeClass == .compact {
                VStack {
                    Spacer()
                    ClockView(components: tzComponents)
                    Spacer()
                    Text(tzConfig.name)
                        .font(.largeTitle)
                        .padding()
                    Spacer()
                }
            } else {
                HStack {
                    Spacer()
                    ClockView(components: tzComponents)
                        .frame(maxWidth: 500)
                    Spacer()
                    Text(tzConfig.name)
                        .font(.largeTitle)
                        .padding()
                    Spacer()
                }
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ClockDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ClockDetailView(viewModel: ClockViewModel(), tzConfig: ClockModel.TimeZoneConfiguration.init(identifier: "Europe/Zurich", name: "Zürich"))
        }
    }
}
