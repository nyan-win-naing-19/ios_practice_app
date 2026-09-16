import SwiftUI

struct DestinationRowView: View {
    let destination: Destination

    var body: some View {
        HStack(spacing: 12) {
            Image(destination.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 90, height: 70)
                .clipShape(
                    RoundedRectangle(cornerRadius: 8)
                )

            VStack(alignment: .leading, spacing: 6) {
                Text(destination.name)
                    .font(.headline)
                    .foregroundStyle(
                        Color("BrandPrimary")
                    )

                Text(destination.headline)
                    .font(.subheadline)
                    .foregroundStyle(
                        Color("BrandSecondary")
                    )
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 4)
    }
}
