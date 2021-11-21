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
        // Initialize with 0 for a starting animation to actual current time
        return ClockModel(time: ClockModel.Time(hour: 0, min: 0, sec: 0), city: "", hourOffset: 0, minOffset: 0)
    }
    
    
    // MARK: - Access to the Model
    // Computed properties:
    var hour: Int {
        return model.time.hour
    }
    
    var min: Int {
        return model.time.min
    }
    
    var sec: Int {
        return model.time.sec
    }

    
    
    // MARK: - Update time
    func updateTime() {
        let calendar = Calendar.current
        let currentDateTime = Date()
        model.time.hour = calendar.component(.hour, from: currentDateTime)
        model.time.min = calendar.component(.minute, from: currentDateTime)
        model.time.sec = calendar.component(.second, from: currentDateTime)
    }
    
    
    // MARK: - Angle conversion
    func getHourDegree() -> Double {
        // 360 degrees / 12 = 30 degrees
        return (Double(hour) + Double(min)/60 ) * 30
    }
    
    
    func getMinDegree() -> Double {
        // 360 degrees / 60 = 6 degrees
        return (Double(min) * 6)
    }

    func getSecDegree() -> Double {
        // 360 degrees / 60 = 6 degrees
        return Double(sec) * 6
    }

}
