import Foundation
import SwiftUI
import Combine

@MainActor
final class DestinationViewModel: ObservableObject {
    @Published var destinations: [Destination] = []
    @Published var errorMessage: String?

    init() {
        loadDestinations()
    }

    func loadDestinations() {
        guard let fileURL = Bundle.main.url(
            forResource: "destinations",
            withExtension: "json"
        ) else {
            errorMessage = "destinations.json file was not found."
            print(errorMessage ?? "")
            return
        }

        do {
            let jsonData = try Data(contentsOf: fileURL)

            destinations = try JSONDecoder().decode(
                [Destination].self,
                from: jsonData
            )

            print(
                "Successfully loaded \(destinations.count) destinations."
            )
        } catch {
            errorMessage = "JSON decoding failed: \(error.localizedDescription)"
            print(errorMessage ?? "")
        }
    }
}
