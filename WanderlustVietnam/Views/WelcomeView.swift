import SwiftUI

struct WelcomeView: View {
    @State private var isRotating = false
    
    @Environment(\.colorScheme)
    private var colorScheme

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()

                VStack(spacing: 24) {
                    Spacer()

                    Image(
                        colorScheme == .dark
                        ? "wanderlust-vietnam-dark"
                        : "wanderlust-vietnam-light"
                    )
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                        .rotationEffect(
                            .degrees(isRotating ? 360 : 0)
                        )
                        .animation(
                            isRotating
                            ? .linear(duration: 5)
                                .repeatForever(autoreverses: false)
                            : .default,
                            value: isRotating
                        )
                        .onTapGesture {
                            isRotating = !isRotating
                        }

                    Text("Wanderlust Vietnam")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(
                            Color("BrandPrimary")
                        )

                    Text("Nyan Win Naing")
                        .font(
                            .custom(
                                "Sacramento-Regular",
                                size: 34
                            )
                        )
                        .foregroundStyle(
                            Color("BrandSecondary")
                        )

                    Text("s4115096")
                        .font(
                            .custom(
                                "Sacramento-Regular",
                                size: 30
                            )
                        )
                        .foregroundStyle(
                            Color("BrandSecondary")
                        )

                    NavigationLink {
//                        Text("Destination List View")
                        
                        DestinationListView()
                    } label: {
                        Text("Explore Destinations")
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 14)
                            .background(
                                Color("BrandPrimary")
                            )
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: 10
                                )
                            )
                    }

                    Spacer()
                }
                .padding()
            }
        }
    }
}

#Preview {
    WelcomeView()
}
