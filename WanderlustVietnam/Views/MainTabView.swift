import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            WelcomeView()
                .tabItem {
                    Label(
                        "Home",
                        systemImage: "house"
                    )
                }

            NavigationStack {
                DestinationListView()
            }
            .tabItem {
                Label(
                    "Destinations",
                    systemImage: "map"
                )
            }

            SettingsView()
                .tabItem {
                    Label(
                        "Settings",
                        systemImage: "gear"
                    )
                }
        }
        .tint(Color("BrandPrimary"))
    }
}
