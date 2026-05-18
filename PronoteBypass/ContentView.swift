import SwiftUI

enum AppStep: Equatable {
    case splash
    case limit
    case loading
}

struct ContentView: View {
    @State private var step: AppStep = .splash
    @State private var showApproval = false
    @State private var showPasscode = false

    var body: some View {
        ZStack {
            switch step {
            case .splash:
                SplashView()
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation(.easeInOut(duration: 0.6)) {
                                step = .limit
                            }
                        }
                    }

            case .limit:
                LimitView(askParent: { showApproval = true })
                    .transition(.opacity)

            case .loading:
                LoadingView()
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                            withAnimation(.easeInOut(duration: 0.6)) {
                                step = .limit
                            }
                        }
                    }
            }
        }
        .animation(.default, value: step)
        .sheet(isPresented: $showApproval) {
            ApprovalSheet(
                onApprove15: { dismissAndLoad() },
                onApprove1h: { dismissAndLoad() },
                onEnterCode: {
                    showApproval = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                        showPasscode = true
                    }
                },
                onCancel: { showApproval = false }
            )
            .presentationDetents([.fraction(0.52)])
            .presentationDragIndicator(.visible)
        }
        .fullScreenCover(isPresented: $showPasscode) {
            PasscodeView(
                onCodeEntered: { code in
                    CodeManager.shared.save(code)
                    showPasscode = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation(.easeInOut(duration: 0.6)) {
                            step = .loading
                        }
                    }
                },
                onDismiss: { showPasscode = false }
            )
        }
    }

    private func dismissAndLoad() {
        showApproval = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            withAnimation(.easeInOut(duration: 0.6)) {
                step = .loading
            }
        }
    }
}
