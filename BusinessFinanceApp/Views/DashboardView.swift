import SwiftUI

struct DashboardView: View {
    let selectedPartner: Partner
    let onSelectRoute: (AppRoute) -> Void

    private let summary = SampleData.summary

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                DashboardHeader(partner: selectedPartner)

                NewDownPaymentPrompt {
                    onSelectRoute(.newDownPayment)
                }

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 170), spacing: 12)], spacing: 12) {
                    MetricCard(
                        title: "Available funds",
                        value: summary.availableFunds.formatted(.currency(code: "IDR").precision(.fractionLength(0))),
                        detail: "Current account balance",
                        systemImage: "banknote",
                        tint: FinanceDesign.positive
                    )
                    MetricCard(
                        title: "Stock value",
                        value: summary.stockValue.formatted(.currency(code: "IDR").precision(.fractionLength(0))),
                        detail: "(summary.activeVehicles) active vehicles",
                        systemImage: "car.side",
                        tint: .blue
                    )
                    MetricCard(
                        title: "Pending funds",
                        value: summary.pendingFunds.formatted(.currency(code: "IDR").precision(.fractionLength(0))),
                        detail: "(summary.pendingVehicles) vehicles awaiting payment",
                        systemImage: "clock",
                        tint: FinanceDesign.warning
                    )
                    MetricCard(
                        title: "Recognized profit",
                        value: summary.recognizedProfit.formatted(.currency(code: "IDR").precision(.fractionLength(0))),
                        detail: "November 2026",
                        systemImage: "chart.line.uptrend.xyaxis",
                        tint: .purple
                    )
                }

                ReconciliationCard(difference: summary.reconciliationDifference) {
                    onSelectRoute(.limitChecker)
                }

                QuickActionsView(onSelectRoute: onSelectRoute)
            }
            .padding(FinanceDesign.pagePadding)
        }
        .background(Color(uiColor: .systemBackground))
        .navigationTitle("Dashboard")
    }
}

private struct DashboardHeader: View {
    let partner: Partner

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Good morning")
                .font(.largeTitle.weight(.bold))
            Text("Here’s the latest position for (partner.name).")
                .foregroundStyle(.secondary)
        }
    }
}

private struct NewDownPaymentPrompt: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: "arrow.down.circle.fill")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .frame(width: 44, height: 44)
                    .background(FinanceDesign.accent, in: Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text("Record a new DP")
                        .font(.headline)
                        .foregroundStyle(.primary)
                    Text("Move a vehicle through TRX, Dana Pending, Profit, Stock, and Limit Checker.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.leading)
                }

                Spacer(minLength: 8)
                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
            }
            .padding(FinanceDesign.cardPadding)
            .background(FinanceDesign.surface, in: .rect(cornerRadius: FinanceDesign.cornerRadius))
        }
        .buttonStyle(.plain)
        .accessibilityHint("Opens the guided new down payment transaction workflow")
    }
}

private struct ReconciliationCard: View {
    let difference: Double
    let action: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Label("Limit Checker", systemImage: "checkmark.shield")
                    .font(.headline)
                Spacer()
                StatusBadge(title: difference == 0 ? "Balanced" : "Review", tint: difference == 0 ? .green : .orange)
            }

            Text(difference.formatted(.currency(code: "IDR").precision(.fractionLength(0))))
                .font(.title.weight(.semibold))
            Text("Financial difference")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Button("Open Limit Checker", systemImage: "arrow.right", action: action)
                .buttonStyle(.bordered)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(FinanceDesign.cardPadding)
        .background(.green.opacity(0.08), in: .rect(cornerRadius: FinanceDesign.cornerRadius))
    }
}

private struct QuickActionsView: View {
    let onSelectRoute: (AppRoute) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeading("Quick actions", subtitle: "Continue where the finance team works most often.")
            ViewThatFits(in: .horizontal) {
                HStack(spacing: 12) {
                    actionButton(.newDownPayment)
                    actionButton(.vehicleStock)
                    actionButton(.pendingFunds)
                }
                VStack(spacing: 12) {
                    actionButton(.newDownPayment)
                    actionButton(.vehicleStock)
                    actionButton(.pendingFunds)
                }
            }
        }
    }

    private func actionButton(_ route: AppRoute) -> some View {
        Button {
            onSelectRoute(route)
        } label: {
            Label(route.title, systemImage: route.systemImage)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .buttonStyle(.bordered)
        .controlSize(.large)
    }
}
