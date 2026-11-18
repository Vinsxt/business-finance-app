import SwiftUI

struct DownPaymentPendingStepView: View {
    let vehicle: StockVehicle
    let draft: DownPaymentDraft

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeading("2. Move to Pending Funds", subtitle: "The unit leaves Stock and keeps its identity in the pending book.")

            VStack(alignment: .leading, spacing: 12) {
                Label(vehicle.displayName, systemImage: "car.side")
                    .font(.headline)
                StatusBadge(title: "SOLD · Unpaid", tint: FinanceDesign.warning)
                Divider()
                LabeledContent("Capital", value: vehicle.buyPrice.formatted(.currency(code: "IDR").precision(.fractionLength(0))))
                LabeledContent("Funds Received", value: draft.receivedAmount.formatted(.currency(code: "IDR").precision(.fractionLength(0))))
                LabeledContent("Remaining Balance", value: draft.remainingBalance(for: vehicle).formatted(.currency(code: "IDR").precision(.fractionLength(0))))
            }
            .padding(FinanceDesign.cardPadding)
            .background(FinanceDesign.surface, in: .rect(cornerRadius: FinanceDesign.cornerRadius))
        }
    }
}
