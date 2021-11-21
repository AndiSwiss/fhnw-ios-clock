import Foundation



// if it is "ObservableObject", it can be   @ObservedObject   in the View
// see https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-observedobject-to-manage-state-from-external-objects
//

class ClockViewModel: ObservableObject {
    
    @Published private var model: ClockModel
    
    // MARK: - Initializer
    init() {
        model = ClockViewModel.createClock()
    }
    
    static func createClock() -> ClockModel {
        let zeroDate = DateComponents(hour: 0, minute: 0, second: 0)
        let calendar = Calendar.current
        
        // Initialize with 0 for a starting animation to actual current time
        return ClockModel(date: calendar.date(from: zeroDate)!)
    }
    
    
    // MARK: - Access to the Model
    var timeZones: [ClockModel.TimeZoneConfiguration] {
        return model.timeZones
    }
    
    // MARK: - Update time
    func updateTime() {
        model.date = Date()
    }
    
    func getLocalDateComponents(timeZone: TimeZone) -> DateComponents {
       var calendar = Calendar.current
       calendar.timeZone = timeZone
       return calendar.dateComponents([.hour, .minute, .second], from: model.date)
    }
    
    // MARK: - Angle conversion
    func getHourDegree(components: DateComponents) -> Double {
        // 360 degrees / 12 = 30 degrees
        (Double(components.hour!) + Double(components.minute!) / 60) * 30
    }
    
    func getMinDegree(components: DateComponents) -> Double {
        // 360 degrees / 60 = 6 degrees
        (Double(components.minute!) * 6)
    }
    
    func getSecDegree(components: DateComponents) -> Double {
        // 360 degrees / 60 = 6 degrees
        Double(components.second!) * 6
    }

}
