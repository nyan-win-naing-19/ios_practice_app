import Foundation
import SwiftData

@Model
final class SavedDestination {
    @Attribute(.unique)
    var id: UUID

    var name: String
    var province: String
    var details: String

    init(
        name: String,
        province: String,
        details: String
    ) {
        self.id = UUID()
        self.name = name
        self.province = province
        self.details = details
    }
}
