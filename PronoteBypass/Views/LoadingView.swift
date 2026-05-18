import SwiftUI

struct LoadingView: View {
    @State private var showText = false

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Image(systemName: "graduationcap.fill")
                .font(.system(size: 56))
                .foregroundStyle(.white)

            Text("PRONOTE")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
                .kerning(5)

            Spacer().frame(height: 20)

            ProgressView()
                .scaleEffect(1.2)
                .tint(.white.opacity(0.8))

            if showText {
                Text("Connexion en cours…")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.7))
                    .transition(.opacity)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.05, green: 0.28, blue: 0.55))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                withAnimation { showText = true }
            }
        }
    }
}
