import SwiftUI
import MapKit

struct DestinationDetailView: View {
    private let name: String
    private let province: String
    private let details: String
    private let mainImageName: String?
    private let galleryImages: [String]

    init(destination: Destination) {
        self.name = destination.name
        self.province = destination.province
        self.details = destination.description
        self.mainImageName = destination.imageName
        self.galleryImages =
            destination.galleryImages
    }

    init(savedDestination: SavedDestination) {
        self.name = savedDestination.name
        self.province = savedDestination.province
        self.details = savedDestination.details
        self.mainImageName = nil
        self.galleryImages = []
    }
    
    
    /// Map
    private var coordinate: CLLocationCoordinate2D? {
        switch mainImageName {
        case "halong-1":
            return CLLocationCoordinate2D(
                latitude: 20.9101,
                longitude: 107.1839
            )

        case "hoian-1":
            return CLLocationCoordinate2D(
                latitude: 15.8770,
                longitude: 108.3268
            )

        case "phongnha-1":
            return CLLocationCoordinate2D(
                latitude: 17.5833,
                longitude: 106.2833
            )

        case "hanoi-1":
            return CLLocationCoordinate2D(
                latitude: 21.0287,
                longitude: 105.8524
            )

        default:
            return nil
        }
    }

    var body: some View {
        ScrollView {
            VStack(
                alignment: .leading,
                spacing: 16
            ) {
                if let mainImageName {
                    Image(mainImageName)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 260)
                        .clipped()
                } else {
                    ZStack {
                        Color("BrandSecondary")
                            .opacity(0.2)

                        Image(
                            systemName:
                                "mappin.and.ellipse"
                        )
                        .font(.system(size: 70))
                        .foregroundStyle(
                            Color("BrandPrimary")
                        )
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 220)
                }

                VStack(
                    alignment: .leading,
                    spacing: 12
                ) {
                    Text(name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(
                            Color("BrandPrimary")
                        )

                    Text(province)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(
                            Color("BrandSecondary")
                        )

                    Divider()

                    Text(details)
                        .font(.body)
                        .foregroundStyle(.primary)
                        .fixedSize(
                            horizontal: false,
                            vertical: true
                        )
                    
                    
                    /// Map
                    if let coordinate {
                        Text("Location")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top, 8)

                        DestinationMapView(
                            name: name,
                            coordinate: coordinate
                        )
                        .frame(height: 250)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 12)
                        )
                    }

                    if !galleryImages.isEmpty {
                        Text("Image Gallery")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top, 8)

                        ScrollView(
                            .horizontal,
                            showsIndicators: false
                        ) {
                            LazyHStack(spacing: 12) {
                                ForEach(
                                    galleryImages,
                                    id: \.self
                                ) { imageName in
                                    Image(imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(
                                            width: 170,
                                            height: 120
                                        )
                                        .clipShape(
                                            RoundedRectangle(
                                                cornerRadius: 10
                                            )
                                        )
                                        .shadow(
                                            color:
                                                .black.opacity(0.25),
                                            radius: 3,
                                            x: 0,
                                            y: 2
                                        )
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 24)
        }
        .background(
            Color("BackgroundColor")
                .ignoresSafeArea()
        )
        .navigationTitle(name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
