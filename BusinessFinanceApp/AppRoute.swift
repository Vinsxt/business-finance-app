import SwiftUI

enum AppRoute: String, CaseIterable, Identifiable, Hashable {
    case dashboard
    case partnerBooks
    case monthlyProfit
    case vehicleStock
    case pendingFunds
    case costing
    case transactions
    case limitChecker
    case bookClosing
    case dataExport
    case userManagement
    case settings

    var id: String { rawValue }

    var title: String {
        switch self {
        case .dashboard: "Dashboard"
        case .partnerBooks: "Partner Books"
        case .monthlyProfit: "Monthly Profit"
        case .vehicleStock: "Vehicle Stock"
        case .pendingFunds: "Pending Funds"
        case .costing: "Costing"
        case .transactions: "Bank Transactions"
        case .limitChecker: "Limit Checker"
        case .bookClosing: "Book Closing"
        case .dataExport: "Data Export"
        case .userManagement: "User Management"
        case .settings: "Settings"
        }
    }

    var subtitle: String {
        switch self {
        case .dashboard: "A quick view of today’s financial position."
        case .partnerBooks: "Switch between partner financial books."
        case .monthlyProfit: "Recognized profit after full customer payment."
        case .vehicleStock: "Active vehicles and capital in stock."
        case .pendingFunds: "Sold vehicles awaiting customer payment."
        case .costing: "Vehicle costs and capital per car."
        case .transactions: "Incoming and outgoing bank activity."
        case .limitChecker: "Reconcile expected and actual funds."
        case .bookClosing: "Daily and monthly closing controls."
        case .dataExport: "Export authorized financial records."
        case .userManagement: "Accounts, roles, and partner access."
        case .settings: "App preferences and account settings."
        }
    }

    var systemImage: String {
        switch self {
        case .dashboard: "rectangle.grid.2x2"
        case .partnerBooks: "books.vertical"
        case .monthlyProfit: "chart.line.uptrend.xyaxis"
        case .vehicleStock: "car.side"
        case .pendingFunds: "clock.badge.checkmark"
        case .costing: "wrench.and.screwdriver"
        case .transactions: "arrow.left.arrow.right"
        case .limitChecker: "checkmark.shield"
        case .bookClosing: "lock.document"
        case .dataExport: "square.and.arrow.up"
        case .userManagement: "person.2"
        case .settings: "gearshape"
        }
    }
}
