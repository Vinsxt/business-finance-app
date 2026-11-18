import SwiftUI

struct DownPaymentStepIndicator: View {
    let currentStep: DownPaymentStep

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ProgressView(value: Double(currentStep.rawValue + 1), total: Double(DownPaymentStep.allCases.count))
                .tint(FinanceDesign.accent)

            HStack(spacing: 0) {
                ForEach(DownPaymentStep.allCases) { step in
                    Label(step.title, systemImage: step.rawValue <= currentStep.rawValue ? "checkmark.circle.fill" : "circle")
                        .font(.caption.weight(.medium))
                        .foregroundStyle(step.rawValue <= currentStep.rawValue ? FinanceDesign.accent : .secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Workflow step (currentStep.rawValue + 1) of (DownPaymentStep.allCases.count): (currentStep.title)")
    }
}
