import SwiftUI

struct ContentView: View {
    @State private var selectedRoute: AppRoute? = .dashboard
    @State private var selectedPartner = SampleData.partners[0]

    var body: some View {
        NavigationSplitView {
            SidebarView(selection: $selectedRoute, selectedPartner: $selectedPartner)
        } detail: {
            NavigationStack {
                RouteView(route: selectedRoute ?? .dashboard, selectedPartner: selectedPartner) { route in
                    selectedRoute = route
                }
            }
        }
        .tint(FinanceDesign.accent)
    }
}

#Preview {
    ContentView()
}
