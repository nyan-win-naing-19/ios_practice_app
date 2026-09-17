import SwiftUI
import MapKit

struct DestinationMapView: View {
    let name: String
    let coordinate: CLLocationCoordinate2D

    private var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(
                latitudeDelta: 0.05,
                longitudeDelta: 0.05
            )
        )
    }

    var body: some View {
        Map(initialPosition: .region(region)) {
            Marker(
                name,
                coordinate: coordinate
            )
        }
        .tint(Color("BrandPrimary"))
    }
}
