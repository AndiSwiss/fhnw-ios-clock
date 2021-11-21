import Foundation

// Model for the app
struct ClockModel {
    var date: Date
    
    // From https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
    var timeZones = [
        TimeZoneConfiguration.init(identifier: "Europe/Zurich", name: "Zürich"),
        TimeZoneConfiguration.init(identifier: "Europe/London", name: "London"),
        TimeZoneConfiguration.init(identifier: "Asia/Tehran", name: "Tehran"),  // + 3:30
        TimeZoneConfiguration.init(identifier: "US/Alaska", name: "Alaska"),
        TimeZoneConfiguration.init(identifier: "Australia/Eucla", name: "Eucla"),  // +08:45
        TimeZoneConfiguration.init(identifier: "Indian/Maldives", name: "Maldives"),
        TimeZoneConfiguration.init(identifier: "America/Winnipeg", name: "Winnipeg"),
        TimeZoneConfiguration.init(identifier: "Australia/Lord_Howe", name: "Lord Howe"),  // +10:30 / + 11:00
        TimeZoneConfiguration.init(identifier: "Asia/Damascus", name: "Damascus"),
        TimeZoneConfiguration.init(identifier: "Pacific/Chatham", name: "Chatham"),  // + 12:45 / + 13:45
        TimeZoneConfiguration.init(identifier: "Asia/Dhaka", name: "Dhaka"),
        TimeZoneConfiguration.init(identifier: "Indian/Cocos", name: "Cocos"),    // + 06:30
        TimeZoneConfiguration.init(identifier: "America/Puerto_Rico", name: "Puerto Rico"),
        TimeZoneConfiguration.init(identifier: "Pacific/Kiritimati", name: "Kiritimati"),   // + 14:00

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
