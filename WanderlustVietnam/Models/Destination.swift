import Foundation

struct Destination: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let province: String
    let headline: String
    let description: String
    let imageName: String
    let galleryImages: [String]
}
