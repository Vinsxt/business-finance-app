struct LimitCheckerSnapshot {
    let circulatingFunds: Double
    let recognizedProfit: Double
    let stockValue: Double
    let totalCosting: Double
    let availableFunds: Double
    let pendingFunds: Double
    let costingAwaitingFullPayment: Double

    var expectedFunds: Double {
        circulatingFunds + recognizedProfit
    }

    var actualFunds: Double {
        stockValue + totalCosting + availableFunds + pendingFunds + costingAwaitingFullPayment
    }

    var difference: Double {
        expectedFunds - actualFunds
    }
}
