import SwiftUI

struct WorkflowHeader: View {
    let partner: Partner

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("Guided finance workflow", systemImage: "checklist")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(FinanceDesign.accent)
            Text("New down payment transaction")
                .font(.largeTitle.weight(.bold))
            Text("Complete the related book updates in one controlled sequence for \(partner.name).")
                .foregroundStyle(.secondary)
        }
    }
}
