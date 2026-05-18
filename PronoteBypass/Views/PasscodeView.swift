import SwiftUI

struct PasscodeView: View {
    let onCodeEntered: (String) -> Void
    let onDismiss: () -> Void

    @State private var code = ""
    @State private var showError = false
    @State private var isResetting = false

    private let maxLen = 4

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
                .onTapGesture { }

            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button(action: onDismiss) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.tertiary)
                    }
                    .padding(.trailing, 20)
                    .padding(.top, 16)
                }

                Spacer()

                VStack(spacing: 32) {
                    Text("Saisissez le code de\n« Temps d'écran »")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.primary)

                    if showError {
                        Text("1 tentative a échoué.")
                            .font(.caption)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 6)
                            .background(Color.red, in: Capsule())
                    }

                    HStack(spacing: 20) {
                        ForEach(0..<maxLen, id: \.self) { i in
                            Circle()
                                .stroke(Color.primary.opacity(i < code.count ? 1 : 0.25), lineWidth: 1.8)
                                .fill(i < code.count ? Color.primary : Color.clear)
                                .frame(width: 14, height: 14)
                                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: code.count)
                        }
                    }
                }

                Spacer()

                VStack(spacing: 8) {
                    ForEach(0..<3, id: \.self) { row in
                        HStack(spacing: 8) {
                            ForEach(0..<3, id: \.self) { col in
                                let n = row * 3 + col + 1
                                keyButton(String(n))
                            }
                        }
                    }
                    HStack(spacing: 8) {
                        Color.clear.frame(width: 80, height: 56)

                        keyButton("0")

                        Button(action: deleteTapped) {
                            Image(systemName: "delete.left")
                                .font(.title2)
                                .foregroundStyle(.primary)
                                .frame(width: 80, height: 56)
                                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 28)
                .background(Color(.systemGray6))
            }
        }
        .disabled(isResetting)
    }

    private func keyButton(_ label: String) -> some View {
        Button(action: { digitTapped(label) }) {
            VStack(spacing: 0) {
                Text(label)
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundStyle(.primary)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 10))
        }
    }

    private func digitTapped(_ digit: String) {
        guard code.count < maxLen else { return }
        code += digit
        if code.count == maxLen {
            if code == "5169" {
                showError = true
                isResetting = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    code = ""
                    isResetting = false
                }
            } else {
                onCodeEntered(code)
            }
        }
    }

    private func deleteTapped() {
        guard !code.isEmpty else { return }
        code.removeLast()
    }
}
