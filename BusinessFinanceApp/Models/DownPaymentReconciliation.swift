struct DownPaymentReconciliation {
    let expectedFunds: Double
    let actualFundsBefore: Double
    let actualFundsAfter: Double

    var difference: Double {
        expectedFunds - actualFundsAfter
    }

    init(vehicle: StockVehicle, draft: DownPaymentDraft, current: LimitCheckerSnapshot) {
        expectedFunds = current.expectedFunds
        actualFundsBefore = current.actualFunds

        let stockAfter = current.stockValue - vehicle.buyPrice
        let pendingAfter = current.pendingFunds + draft.remainingBalance(for: vehicle)
        let availableAfter = current.availableFunds + draft.receivedAmount
        actualFundsAfter = stockAfter + current.totalCosting + availableAfter + pendingAfter + draft.costingAwaitingFullPayment
    }
}
