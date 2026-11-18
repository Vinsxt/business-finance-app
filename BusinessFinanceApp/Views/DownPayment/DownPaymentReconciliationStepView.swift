import SwiftUI

struct DownPaymentReconciliationStepView: View {
    @Binding var draft: DownPaymentDraft
    let reconciliation: DownPaymentReconciliation

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeading("5. Confirm Limit Checker", subtitle: "Finalization is allowed only when the discrepancy is zero.")

            TextField("Costing Nunggu Lunas", value: $draft.costingAwaitingFullPayment, format: .number)
                .keyboardType(.decimalPad)
                .padding(FinanceDesign.cardPadding)
                .background(FinanceDesign.surface, in: .rect(cornerRadius: FinanceDesign.cornerRadius))

            VStack(alignment: .leading, spacing: 12) {
                LabeledContent("Total Dana Seharusnya", value: reconciliation.expectedFunds.formatted(.currency(code: "IDR").precision(.fractionLength(0))))
                LabeledContent("Actual Before", value: reconciliation.actualFundsBefore.formatted(.currency(code: "IDR").precision(.fractionLength(0))))
                LabeledContent("Actual After", value: reconciliation.actualFundsAfter.formatted(.currency(code: "IDR").precision(.fractionLength(0))))
                Divider()
                LabeledContent("Dana yang Kurang", value: reconciliation.difference.formatted(.currency(code: "IDR").precision(.fractionLength(0))))
                    .font(.headline)
            }
            .padding(FinanceDesign.cardPadding)
            .background((reconciliation.difference == 0 ? Color.green : Color.orange).opacity(0.1), in: .rect(cornerRadius: FinanceDesign.cornerRadius))

            Label(
                reconciliation.difference == 0 ? "Reconciled. The five sheet updates balance." : "Stop and audit TRX, Dana Pending, Stock, and Limit Checker.",
                systemImage: reconciliation.difference == 0 ? "checkmark.shield" : "exclamationmark.triangle"
            )
            .font(.subheadline)
            .foregroundStyle(reconciliation.difference == 0 ? .green : .orange)
        }
    }
}
