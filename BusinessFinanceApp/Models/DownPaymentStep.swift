import Foundation

enum DownPaymentStep: Int, CaseIterable, Identifiable {
    case transaction
    case pendingFunds
    case monthlyProfit
    case stock
    case reconciliation

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .transaction: "TRX"
        case .pendingFunds: "Dana Pending"
        case .monthlyProfit: "Profit Bulanan"
        case .stock: "Stock"
        case .reconciliation: "Limit Checker"
        }
    }

    var detail: String {
        switch self {
        case .transaction: "Record the incoming DP"
        case .pendingFunds: "Move the vehicle and calculate the balance"
        case .monthlyProfit: "Mark the unit sold but unpaid"
        case .stock: "Remove it from active inventory"
        case .reconciliation: "Confirm the difference is zero"
        }
    }
}
