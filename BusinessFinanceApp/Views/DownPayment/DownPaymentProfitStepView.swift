import SwiftUI

struct DownPaymentProfitStepView: View {
    let vehicle: StockVehicle
    let draft: DownPaymentDraft

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeading("3. Add to monthly profit", subtitle: "Record the sale now, but keep profit recognition pending settlement.")

            VStack(alignment: .leading, spacing: 12) {
                LabeledContent("Status", value: "Unpaid")
                LabeledContent("Date Purchase", value: vehicle.purchaseDate.formatted(date: .abbreviated, time: .omitted))
                LabeledContent("Date Sold", value: draft.transactionDate.formatted(date: .abbreviated, time: .omitted))
                LabeledContent("Type", value: vehicle.type)
                LabeledContent("Buy", value: vehicle.buyPrice.formatted(.currency(code: "IDR").precision(.fractionLength(0))))
                LabeledContent("Costing", value: vehicle.costingPrice.formatted(.currency(code: "IDR").precision(.fractionLength(0))))
                LabeledContent("Projected Profit", value: draft.projectedProfit(for: vehicle).formatted(.currency(code: "IDR").precision(.fractionLength(0))))
                LabeledContent("Projected Profit 50%", value: draft.profitShare(for: vehicle).formatted(.currency(code: "IDR").precision(.fractionLength(0))))
            }
            .padding(FinanceDesign.cardPadding)
            .background(FinanceDesign.surface, in: .rect(cornerRadius: FinanceDesign.cornerRadius))

            Label("Projected profit is visible for the book, but recognized profit remains zero until the customer is fully paid.", systemImage: "info.circle")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
}
