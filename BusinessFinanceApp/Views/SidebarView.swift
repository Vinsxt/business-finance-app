import SwiftUI

struct SidebarView: View {
    @Binding var selection: AppRoute?
    @Binding var selectedPartner: Partner

    var body: some View {
        List(selection: $selection) {
            Section("Workspace") {
                SidebarLink(route: .dashboard)
                SidebarLink(route: .partnerBooks)
            }

            Section("Finance") {
                ForEach([
                    AppRoute.monthlyProfit,
                    .vehicleStock,
                    .pendingFunds,
                    .costing,
                    .transactions,
                    .limitChecker,
                    .bookClosing,
                    .dataExport
                ]) { route in
                    SidebarLink(route: route)
                }
            }

            Section("Administration") {
                SidebarLink(route: .userManagement)
                SidebarLink(route: .settings)
            }
        }
        .navigationTitle("Finance")
        .safeAreaInset(edge: .bottom) {
            PartnerPicker(selectedPartner: $selectedPartner)
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
                .background(.bar)
        }
    }
}

private struct SidebarLink: View {
    let route: AppRoute

    var body: some View {
        Label(route.title, systemImage: route.systemImage)
            .tag(route)
    }
}

private struct PartnerPicker: View {
    @Binding var selectedPartner: Partner

    var body: some View {
        Picker("Partner book", selection: $selectedPartner) {
            ForEach(SampleData.partners) { partner in
                Text(partner.name).tag(partner)
            }
        }
        .pickerStyle(.menu)
        .accessibilityHint("Choose the partner book shown in the workspace")
    }
}
