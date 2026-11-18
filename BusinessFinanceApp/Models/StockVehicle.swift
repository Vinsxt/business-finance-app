import Foundation

struct StockVehicle: Identifiable, Hashable {
    let id: UUID
    let brand: String
    let type: String
    let plateNumber: String
    let manufacturingYear: Int
    let purchaseDate: Date
    let buyPrice: Double
    let costingPrice: Double
    let sellPrice: Double

    var displayName: String {
        "\(brand) \(type) · \(plateNumber)"
    }
}
