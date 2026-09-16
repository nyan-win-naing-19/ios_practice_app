import SwiftUI
import SwiftData

struct AddDestinationView: View {
    @Environment(\.modelContext)
    private var modelContext

    @Environment(\.dismiss)
    private var dismiss

    private let destinationToEdit: SavedDestination?

    @State private var name: String
    @State private var province: String
    @State private var details: String

    @State private var showingSaveError = false
    @State private var saveErrorMessage = ""

    init(
        destinationToEdit: SavedDestination? = nil
    ) {
        self.destinationToEdit = destinationToEdit

        _name = State(
            initialValue: destinationToEdit?.name ?? ""
        )

        _province = State(
            initialValue: destinationToEdit?.province ?? ""
        )

        _details = State(
            initialValue: destinationToEdit?.details ?? ""
        )
    }

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
            .navigationTitle(
                destinationToEdit == nil
                ? "Add Destination"
                : "Edit Destination"
            )
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
            .alert(
                "Unable to Save",
                isPresented: $showingSaveError
            ) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(saveErrorMessage)
            }
        }
    }

    private func saveDestination() {
        let trimmedName = name.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let trimmedProvince = province.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let trimmedDetails = details.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        if let destination = destinationToEdit {
            let oldName = destination.name
            let oldProvince = destination.province
            let oldDetails = destination.details

            destination.name = trimmedName
            destination.province = trimmedProvince
            destination.details = trimmedDetails

            do {
                try modelContext.save()
                dismiss()
            } catch {
                destination.name = oldName
                destination.province = oldProvince
                destination.details = oldDetails

                saveErrorMessage =
                    error.localizedDescription

                showingSaveError = true
            }
        } else {
            let newDestination = SavedDestination(
                name: trimmedName,
                province: trimmedProvince,
                details: trimmedDetails
            )

            modelContext.insert(newDestination)

            do {
                try modelContext.save()
                dismiss()
            } catch {
                modelContext.delete(newDestination)

                saveErrorMessage =
                    error.localizedDescription

                showingSaveError = true
            }
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
