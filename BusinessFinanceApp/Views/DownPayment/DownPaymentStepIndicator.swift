import SwiftUI

struct DownPaymentStepIndicator: View {
    let currentStep: DownPaymentStep

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ProgressView(value: Double(currentStep.rawValue + 1), total: Double(DownPaymentStep.allCases.count))
                .tint(FinanceDesign.accent)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(DownPaymentStep.allCases) { step in
                        Label(step.title, systemImage: step.rawValue <= currentStep.rawValue ? "checkmark.circle.fill" : "circle")
                            .font(.caption.weight(.medium))
                            .foregroundStyle(step.rawValue <= currentStep.rawValue ? FinanceDesign.accent : .secondary)
                            .fixedSize(horizontal: true, vertical: false)
                    }
                }
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Workflow step \(currentStep.rawValue + 1) of \(DownPaymentStep.allCases.count): \(currentStep.title)")
    }
}
