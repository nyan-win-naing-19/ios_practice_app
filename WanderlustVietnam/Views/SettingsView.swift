import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode")
    private var isDarkMode = false

    @Environment(\.dismiss)
    private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Toggle(
                    "Enable Dark Mode",
                    isOn: $isDarkMode
                )
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(
                    placement: .confirmationAction
                ) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .tint(Color("BrandPrimary"))
        }
    }
}

#Preview {
    SettingsView()
}
