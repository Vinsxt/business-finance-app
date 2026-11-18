import SwiftUI

struct DownPaymentStockStepView: View {
    let vehicle: StockVehicle

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeading("4. Remove from active Stock", subtitle: "This prevents the vehicle from being counted twice.")

            VStack(alignment: .leading, spacing: 12) {
                Label("Stock", systemImage: "minus.circle")
                    .foregroundStyle(.secondary)
                Text(vehicle.displayName)
                    .font(.headline)
                Text(vehicle.buyPrice.formatted(.currency(code: "IDR").precision(.fractionLength(0))))
                    .font(.title3.weight(.semibold))
                Divider()
                Label("The vehicle will be represented by its Pending Funds record.", systemImage: "arrow.right.circle")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(FinanceDesign.cardPadding)
            .background(FinanceDesign.surface, in: .rect(cornerRadius: FinanceDesign.cornerRadius))
        }
    }
}
