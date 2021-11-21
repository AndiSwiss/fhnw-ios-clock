import Foundation

// Model for the app
struct ClockModel {
    var time: Time
    var currentMinOffset: Int
    
    struct Time {
        var hour: Int
        var min: Int
        var sec: Int
    }
    
    struct Timezone: Identifiable {
        // Note: the identifiable allows easy iteration with ForEach, see
        // https://www.hackingwithswift.com/quick-start/swiftui/how-to-fix-initializer-init-rowcontent-requires-that-sometype-conform-to-identifiable
        // and
        // https://www.hackingwithswift.com/books/ios-swiftui/working-with-identifiable-items-in-swiftui
        var id = UUID()
        var city: String
        var minOffset: Int
    }
}
