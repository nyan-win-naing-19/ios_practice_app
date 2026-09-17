import SwiftUI

struct SettingsView: View {
    let showsDoneButton: Bool

    @AppStorage("isDarkMode")
    private var isDarkMode = false

    @Environment(\.dismiss)
    private var dismiss

    init(showsDoneButton: Bool = false) {
        self.showsDoneButton = showsDoneButton
    }

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
                if showsDoneButton {
                    ToolbarItem(
                        placement: .confirmationAction
                    ) {
                        Button("Done") {
                            dismiss()
                        }
                    }
                }
            }
            .tint(Color("BrandPrimary"))
        }
    }
}
