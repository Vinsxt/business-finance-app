import SwiftUI

struct DownPaymentTransactionStepView: View {
    @Binding var draft: DownPaymentDraft
    let vehicles: [StockVehicle]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeading("1. Record cash inflow", subtitle: "Capture the DP in TRX before moving the vehicle.")

            VStack(spacing: 12) {
                Picker("Vehicle", selection: $draft.vehicleID) {
                    ForEach(vehicles) { vehicle in
                        Text(vehicle.displayName).tag(vehicle.id)
                    }
                }
                .pickerStyle(.menu)

                DatePicker("Transaction date", selection: $draft.transactionDate, displayedComponents: .date)

                TextField("Description", text: $draft.description, prompt: Text("e.g. DP Vellfire"))

                TextField("DP amount", value: $draft.receivedAmount, format: .number)
                    .keyboardType(.decimalPad)
            }
            .padding(FinanceDesign.cardPadding)
            .background(FinanceDesign.surface, in: .rect(cornerRadius: FinanceDesign.cornerRadius))

            Text("Amount must be greater than zero and cannot exceed the vehicle’s capital.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
}
