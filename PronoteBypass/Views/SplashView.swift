import SwiftUI

struct SplashView: View {
    @State private var progress: CGFloat = 0.0

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            VStack(spacing: 12) {
                Image(systemName: "graduationcap.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(.white)

                Text("PRONOTE")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .kerning(6)
            }

            Spacer()

            ProgressView(value: progress)
                .tint(.white)
                .frame(width: 160)
                .padding(.bottom, 80)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.05, green: 0.28, blue: 0.55))
        .onAppear {
            withAnimation(.linear(duration: 1.8)) {
                progress = 1.0
            }
        }
    }
}
