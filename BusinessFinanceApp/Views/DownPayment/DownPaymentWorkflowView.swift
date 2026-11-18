import SwiftUI

struct NewDownPaymentView: View {
    let selectedPartner: Partner

    @State private var draft = DownPaymentDraft()
    @State private var currentStep: DownPaymentStep = .transaction
    @State private var isPreparedForReview = false

    private var selectedVehicle: StockVehicle {
        SampleData.stockVehicles.first { $0.id == draft.vehicleID } ?? SampleData.stockVehicles[0]
    }

    private var reconciliation: DownPaymentReconciliation {
        DownPaymentReconciliation(
            vehicle: selectedVehicle,
            draft: draft,
            current: SampleData.limitChecker
        )
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                WorkflowHeader(partner: selectedPartner)
                DownPaymentStepIndicator(currentStep: currentStep)
                stepContent
                WorkflowNavigation(
                    currentStep: currentStep,
                    canContinue: canContinue,
                    isPreparedForReview: isPreparedForReview,
                    onBack: goBack,
                    onContinue: advance
                )
            }
            .padding(FinanceDesign.pagePadding)
        }
        .background(Color(uiColor: .systemBackground))
        .navigationTitle("New DP Transaction")
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Label(selectedPartner.shortName, systemImage: "person.crop.rectangle")
            }
        }
    }

    @ViewBuilder
    private var stepContent: some View {
        switch currentStep {
        case .transaction:
            DownPaymentTransactionStepView(draft: $draft, vehicles: SampleData.stockVehicles)
        case .pendingFunds:
            DownPaymentPendingStepView(vehicle: selectedVehicle, draft: draft)
        case .monthlyProfit:
            DownPaymentProfitStepView(vehicle: selectedVehicle, draft: draft)
        case .stock:
            DownPaymentStockStepView(vehicle: selectedVehicle)
        case .reconciliation:
            DownPaymentReconciliationStepView(draft: $draft, reconciliation: reconciliation)
        }
    }

    private var canContinue: Bool {
        switch currentStep {
        case .transaction:
            draft.isValid && draft.receivedAmount <= selectedVehicle.buyPrice
        case .pendingFunds, .monthlyProfit, .stock:
            true
        case .reconciliation:
            reconciliation.difference == 0
        }
    }

    private func goBack() {
        guard let previous = DownPaymentStep(rawValue: currentStep.rawValue - 1) else { return }
        currentStep = previous
        isPreparedForReview = false
    }

    private func advance() {
        guard canContinue else { return }
        if currentStep == .reconciliation {
            isPreparedForReview = true
        } else if let next = DownPaymentStep(rawValue: currentStep.rawValue + 1) {
            currentStep = next
        }
    }
}
