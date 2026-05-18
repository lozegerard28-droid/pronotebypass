import SwiftUI

struct ApprovalSheet: View {
    let onApprove15: () -> Void
    let onApprove1h: () -> Void
    let onEnterCode: () -> Void
    let onCancel: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Capsule()
                .fill(.tertiary)
                .frame(width: 36, height: 5)
                .padding(.top, 12)

            VStack(spacing: 4) {
                Image(systemName: "hourglass.circle.fill")
                    .font(.system(size: 48))
                    .foregroundStyle(.indigo)
                    .padding(.top, 8)

                Text("Temps d'écran")
                    .font(.title3)
                    .fontWeight(.semibold)

                Text("Vous avez atteint votre limite\npour PRONOTE")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top, 4)
            }
            .padding(.bottom, 20)

            VStack(spacing: 12) {
                Button(action: onApprove15) {
                    Text("Approuver pour 15 minutes")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(Color.accentColor, in: RoundedRectangle(cornerRadius: 14))
                }

                Button(action: onApprove1h) {
                    Text("Approuver pour 1 heure")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(Color.accentColor, in: RoundedRectangle(cornerRadius: 14))
                }

                Button(action: onEnterCode) {
                    Text("Saisir le code de « Temps d'écran »")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(.accent)
                }
                .padding(.top, 6)

                Button(action: onCancel) {
                    Text("Annuler")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 4)
            }

            Spacer()
        }
        .padding(.horizontal, 24)
        .background(Color(.systemBackground))
    }
}
