import SwiftUI

struct LimitView: View {
    let askParent: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "hourglass")
                .font(.system(size: 72))
                .foregroundStyle(.secondary)

            VStack(spacing: 8) {
                Text("Limite de temps")
                    .font(.title)
                    .fontWeight(.semibold)

                Text("Vous avez atteint votre limite\npour PRONOTE")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            Spacer()

            Button(action: askParent) {
                Text("Demander plus de temps")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: 280)
                    .padding(.vertical, 16)
                    .background(Color.accentColor, in: RoundedRectangle(cornerRadius: 14))
            }

            Spacer().frame(height: 40)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}
