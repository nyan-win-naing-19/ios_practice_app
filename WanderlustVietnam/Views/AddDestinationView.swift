import SwiftUI
import SwiftData

struct AddDestinationView: View {
    @Environment(\.modelContext)
    private var modelContext

    @Environment(\.dismiss)
    private var dismiss
    
    

    @State private var name = ""
    @State private var province = ""
    @State private var details = ""

    private var canSave: Bool {
        !name.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty
        &&
        !province.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Basic Information") {
                    TextField(
                        "Destination Name",
                        text: $name
                    )

                    TextField(
                        "Province",
                        text: $province
                    )
                }

                Section("Description") {
                    TextEditor(text: $details)
                        .frame(minHeight: 150)
                }
            }
            .navigationTitle("Add Destination")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(
                    placement: .cancellationAction
                ) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(
                    placement: .confirmationAction
                ) {
                    Button("Save") {
                        saveDestination()
                    }
                    .disabled(!canSave)
                }
            }
            .tint(Color("BrandPrimary"))
        }
    }

    private func saveDestination() {
        let newDestination = SavedDestination(
            name: name.trimmingCharacters(
                in: .whitespacesAndNewlines
            ),
            province: province.trimmingCharacters(
                in: .whitespacesAndNewlines
            ),
            details: details.trimmingCharacters(
                in: .whitespacesAndNewlines
            )
        )

        modelContext.insert(newDestination)

        do {
            try modelContext.save()
            dismiss()
        } catch {
            print(
                "Unable to save destination: \(error)"
            )
        }
    }
}

#Preview {
    AddDestinationView()
        .modelContainer(
            for: SavedDestination.self,
            inMemory: true
        )
}
