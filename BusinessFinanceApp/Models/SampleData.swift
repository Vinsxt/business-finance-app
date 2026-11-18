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

    static let stockVehicles = [
        StockVehicle(
            id: UUID(),
            brand: "Toyota",
            type: "Vellfire",
            plateNumber: "B 1234 VLF",
            manufacturingYear: 2022,
            purchaseDate: Date.now.addingTimeInterval(-86_400 * 24),
            buyPrice: 400_000_000,
            costingPrice: 10_000_000,
            sellPrice: 450_000_000
        ),
        StockVehicle(
            id: UUID(),
            brand: "Honda",
            type: "Civic RS",
            plateNumber: "B 5678 HN",
            manufacturingYear: 2023,
            purchaseDate: Date.now.addingTimeInterval(-86_400 * 14),
            buyPrice: 325_000_000,
            costingPrice: 7_500_000,
            sellPrice: 365_000_000
        )
    ]

    static let limitChecker = LimitCheckerSnapshot(
        circulatingFunds: 4_984_000_000,
        recognizedProfit: 184_500_000,
        stockValue: 2_730_000_000,
        totalCosting: 200_000_000,
        availableFunds: 1_248_500_000,
        pendingFunds: 865_000_000,
        costingAwaitingFullPayment: 125_000_000
    )
}
