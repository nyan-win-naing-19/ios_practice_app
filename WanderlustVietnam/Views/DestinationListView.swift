import SwiftData
import SwiftUI

struct DestinationListView: View {
    @StateObject private var viewModel =
        DestinationViewModel()

    @Query(
        sort: \SavedDestination.name
    )
    private var savedDestinations: [SavedDestination]

    @State private var showingSettings = false
    @State private var showingAddDestination = false
    
    /// Delete
    @Environment(\.modelContext)
    private var modelContext
    
    // Delete
    @State private var destinationToDelete:
        SavedDestination?

    @State private var showingDeleteConfirmation = false

    /// Search Feature
    @State private var searchText = ""

    /// Search Feature for Normal Destinations
    private var filteredDestinations: [Destination] {
        let query = searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !query.isEmpty else {
            return viewModel.destinations
        }

        return viewModel.destinations.filter { destination in
            destination.name
                .localizedCaseInsensitiveContains(query)
                || destination.province
                    .localizedCaseInsensitiveContains(query)
                || destination.headline
                    .localizedCaseInsensitiveContains(query)
        }
    }

    /// Search Feature for Saved Destinations
    private var filteredSavedDestinations: [SavedDestination] {

        let query = searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !query.isEmpty else {
            return savedDestinations
        }

        return savedDestinations.filter { destination in
            destination.name
                .localizedCaseInsensitiveContains(query)
                || destination.province
                    .localizedCaseInsensitiveContains(query)
                || destination.details
                    .localizedCaseInsensitiveContains(query)
        }
    }

    var body: some View {
        Group {
            if let errorMessage = viewModel.errorMessage {
                ContentUnavailableView {
                    Label(
                        "Unable to Load Destinations",
                        systemImage: "exclamationmark.triangle"
                    )
                } description: {
                    Text(errorMessage)
                }
            } else {
                List {
                    Section("Featured Destinations") {

                        /// Original Destinations List without Search
                        //                        ForEach(
                        //                            viewModel.destinations
                        //                        ) { destination in
                        //                            NavigationLink {
                        //                                DestinationDetailView(
                        //                                    destination: destination
                        //                                )
                        //                            } label: {
                        //                                DestinationRowView(
                        //                                    destination: destination
                        //                                )
                        //                            }
                        //                        }

                        /// Search Feature
                        ForEach(
                            filteredDestinations
                        ) { destination in
                            NavigationLink {
                                DestinationDetailView(
                                    destination: destination
                                )
                            } label: {
                                DestinationRowView(
                                    destination: destination
                                )
                            }
                        }
                    }

                    /// Original Save Destinations
                    //                    if !savedDestinations.isEmpty {
                    /// Search Save Destinations
                    if !filteredSavedDestinations.isEmpty {
                        Section("My Destinations") {

                            // Original Read Data for SavedDestinations
                            //                            ForEach(
                            //                                savedDestinations
                            //                            ) { savedDestination in

                            /// Searched Read Data for SavedDestinations
                            ForEach(
                                filteredSavedDestinations
                            ) { savedDestination in
                                NavigationLink {
                                    DestinationDetailView(
                                        savedDestination:
                                            savedDestination
                                    )
                                } label: {
                                    HStack(spacing: 12) {
                                        Image(
                                            systemName:
                                                "mappin.circle.fill"
                                        )
                                        .font(.largeTitle)
                                        .foregroundStyle(
                                            Color("BrandPrimary")
                                        )
                                        .frame(
                                            width: 90,
                                            height: 70
                                        )

                                        VStack(
                                            alignment: .leading,
                                            spacing: 6
                                        ) {
                                            Text(
                                                savedDestination.name
                                            )
                                            .font(.headline)
                                            .foregroundStyle(
                                                Color("BrandPrimary")
                                            )

                                            Text(
                                                savedDestination.province
                                            )
                                            .font(.subheadline)
                                            .foregroundStyle(
                                                Color("BrandSecondary")
                                            )
                                        }
                                    }
                                    .padding(.vertical, 4)
                                }
                                .swipeActions(
                                    edge: .trailing,
                                    allowsFullSwipe: false
                                ) {
                                    Button(role: .destructive) {
                                        destinationToDelete =
                                            savedDestination

                                        showingDeleteConfirmation = true
                                    } label: {
                                        Label(
                                            "Delete",
                                            systemImage: "trash"
                                        )
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Destinations")
        .searchable(
            text: $searchText,
            prompt: "Search destinations"
        )
        .toolbar {
            ToolbarItemGroup(
                placement: .topBarTrailing
            ) {
                Button {
                    showingAddDestination = true
                } label: {
                    Image(systemName: "plus")
                }

                Button {
                    showingSettings = true
                } label: {
                    Image(systemName: "gear")
                }
            }
        }
        .sheet(
            isPresented: $showingAddDestination
        ) {
            AddDestinationView()
        }
        .sheet(
            isPresented: $showingSettings
        ) {
            SettingsView()
        }
        .confirmationDialog(
            "Delete Destination?",
            isPresented: $showingDeleteConfirmation,
            presenting: destinationToDelete
        ) { destination in
            Button(
                "Delete \(destination.name)",
                role: .destructive
            ) {
                deleteDestination(destination)
            }

            Button("Cancel", role: .cancel) {
                destinationToDelete = nil
            }
        } message: { destination in
            Text(
                "\(destination.name) will be permanently deleted."
            )
        }
        .tint(Color("BrandPrimary"))
    }
    
    private func deleteDestination(
        _ destination: SavedDestination
    ) {
        modelContext.delete(destination)

        do {
            try modelContext.save()
            destinationToDelete = nil
        } catch {
            print(
                "Unable to delete destination: \(error)"
            )
        }
    }
}

#Preview {
    NavigationStack {
        DestinationListView()
    }
}
