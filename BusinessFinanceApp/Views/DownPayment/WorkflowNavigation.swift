import SwiftUI

struct WorkflowNavigation: View {
    let currentStep: DownPaymentStep
    let canContinue: Bool
    let isPreparedForReview: Bool
    let onBack: () -> Void
    let onContinue: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            if currentStep != .transaction {
                Button("Back", systemImage: "chevron.left", action: onBack)
                    .buttonStyle(.bordered)
            }

            Spacer()

            Button(buttonTitle, systemImage: buttonImage, action: onContinue)
                .buttonStyle(.borderedProminent)
                .disabled(!canContinue || isPreparedForReview)
        }
    }

    private var buttonTitle: String {
        if currentStep == .reconciliation { return isPreparedForReview ? "Ready for review" : "Prepare review" }
        return "Continue"
    }

    private var buttonImage: String {
        currentStep == .reconciliation ? "checkmark" : "chevron.right"
    }
}
