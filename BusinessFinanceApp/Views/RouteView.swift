import SwiftUI

struct RouteView: View {
    let route: AppRoute
    let selectedPartner: Partner
    let onSelectRoute: (AppRoute) -> Void

    var body: some View {
        switch route {
        case .dashboard:
            DashboardView(selectedPartner: selectedPartner, onSelectRoute: onSelectRoute)
        case .newDownPayment:
            NewDownPaymentView(selectedPartner: selectedPartner)
        default:
            ModulePageView(route: route, selectedPartner: selectedPartner)
        }
    }
}
