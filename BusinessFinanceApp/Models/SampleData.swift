import Foundation

enum SampleData {
    static let partners = [
        Partner(id: UUID(), name: "Partner A", shortName: "P-A", status: "Active"),
        Partner(id: UUID(), name: "Partner B", shortName: "P-B", status: "Active"),
        Partner(id: UUID(), name: "Partner C", shortName: "P-C", status: "Review")
    ]

    static let summary = FinanceSummary(
        availableFunds: 1_248_500_000,
        stockValue: 2_730_000_000,
        pendingFunds: 865_000_000,
        recognizedProfit: 184_500_000,
        reconciliationDifference: 0,
        activeVehicles: 12,
        pendingVehicles: 4
    )
}
