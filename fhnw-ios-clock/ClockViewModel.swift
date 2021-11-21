import Foundation



// if it is "ObservableObject", it can be   @ObservedObject   in the View
// see https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-observedobject-to-manage-state-from-external-objects
//

class ClockViewModel: ObservableObject {
    
    @Published private var model: ClockModel
    
    // Some time zones - ignoring daylight savings times
    // from https://www.davidsemporium.co.uk/worldclock.html
    let timeZones = [
        ClockModel.Timezone(city: "Zürich", minOffset: 60),
        ClockModel.Timezone(city: "London", minOffset: 0),
        ClockModel.Timezone(city: "New Sertiig", minOffset: 90),
        ClockModel.Timezone(city: "Sapporo", minOffset: 9 * 60),
    ]
    
    
    // MARK: - Initializer
    init() {
        model = ClockViewModel.createClock()
    }
    
    static func createClock() -> ClockModel {
        // Get current TimeOffset - according to
        // https://stackoverflow.com/questions/42235257/how-to-get-timezone-offset-as-%C2%B1hhmm/51944023
        let offsetSeconds = TimeZone.current.secondsFromGMT()
        let offsetMinutes = offsetSeconds / 60        
        
        // Initialize with 0 for a starting animation to actual current time
        return ClockModel(time: ClockModel.Time(hour: 0, min: 0, sec: 0), currentMinOffset: offsetMinutes)
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
    
    var currentMinOffset: Int {
        return model.currentMinOffset
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
    func getHourDegree(timeZone: ClockModel.Timezone) -> Double {
        // 360 degrees / 12 = 30 degrees
        (Double(getLocalHour(timeZone: timeZone)) + Double(getLocalMin(timeZone: timeZone))/60 ) * 30
    }
    
    
    func getMinDegree(timeZone: ClockModel.Timezone) -> Double {
        // 360 degrees / 60 = 6 degrees
        (Double(getLocalMin(timeZone: timeZone)) * 6)
    }

    func getSecDegree() -> Double {
        // 360 degrees / 60 = 6 degrees
        Double(sec) * 6
    }
    
    func getLocalHour(timeZone: ClockModel.Timezone) -> Int {
        hour - (currentMinOffset + timeZone.minOffset) / 60
    }
    
    func getLocalMin(timeZone: ClockModel.Timezone) -> Int {
        min - currentMinOffset % 60 + timeZone.minOffset % 60
    }

}
