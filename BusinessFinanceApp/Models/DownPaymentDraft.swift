import Foundation

struct DownPaymentDraft {
    var transactionDate = Date.now
    var vehicleID = SampleData.stockVehicles[0].id
    var receivedAmount = 5_000_000.0
    var description = "DP Vellfire"
    var costingAwaitingFullPayment = SampleData.limitChecker.costingAwaitingFullPayment

    func remainingBalance(for vehicle: StockVehicle) -> Double {
        vehicle.buyPrice - receivedAmount
    }

    func projectedProfit(for vehicle: StockVehicle) -> Double {
        vehicle.sellPrice - (vehicle.buyPrice + vehicle.costingPrice)
    }

    func profitShare(for vehicle: StockVehicle) -> Double {
        projectedProfit(for: vehicle) / 2
    }

    var isValid: Bool {
        receivedAmount > 0 && !description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
