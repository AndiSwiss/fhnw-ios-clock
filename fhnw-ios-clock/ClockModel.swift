import Foundation

// Model for the app
struct ClockModel {
    var date: Date
    
    var timeZones = [
        TimeZoneConfiguration.init(identifier: "Europe/Zurich", name: "Zürich"),
        TimeZoneConfiguration.init(identifier: "Europe/London", name: "London"),
    ]
    
    struct TimeZoneConfiguration: Identifiable {
        var id = UUID()
        var identifier: String
        var timeZone: TimeZone
        var name: String
        
        init(identifier: String, name: String) {
            self.identifier = identifier
            self.name = name
            self.timeZone = TimeZone.init(identifier: identifier)!
        }
    }
}
