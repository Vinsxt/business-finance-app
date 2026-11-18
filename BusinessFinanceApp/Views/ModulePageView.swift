import SwiftUI

struct ModulePageView: View {
    let route: AppRoute
    let selectedPartner: Partner

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                PageIntro(route: route, partner: selectedPartner)

                ContentUnavailableView {
                    Label("Skeleton ready", systemImage: route.systemImage)
                } description: {
                    Text("This page is ready for its data source and workflow actions.")
                } actions: {
                    Text("The next slice will connect \(route.title.lowercased()) to Supabase.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(FinanceDesign.pagePadding)
        }
        .navigationTitle(route.title)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Label(selectedPartner.shortName, systemImage: "person.crop.rectangle")
                    .labelStyle(.titleAndIcon)
            }
        }
    }
}

private struct PageIntro: View {
    let route: AppRoute
    let partner: Partner

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(route.title, systemImage: route.systemImage)
                .font(.title2.weight(.semibold))
            Text(route.subtitle)
                .foregroundStyle(.secondary)
            Text("Viewing \(partner.name)")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(FinanceDesign.accent)
        }
    }
}
