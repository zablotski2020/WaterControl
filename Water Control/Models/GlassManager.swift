import Foundation
import Firebase

struct GlassManager {
    // использовал синглтон
    static var sharedInstance = GlassManager()
    let db = Firestore.firestore()
    
    var currentGoal: Float = 8
    let glassSizes: [String] = ["120", "180", "240", "270", "300", "340", "420", "480"]
}
