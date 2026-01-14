import SwiftUI
import FamilyControls
import DeviceActivity

let y = Calendar.current.dateInterval(of: .day, for: Calendar.current.date(byAdding: .day, value: 1, to: .now)!)

struct ContentView: View {
    @State private var authorized = false

    private let filter = DeviceActivityFilter(
        segment: .daily(
            during: y!        )
    )

    var body: some View {
        VStack(spacing: 16) {
            Text(authorized ? "✅ Authorized" : "Requesting permissionz…")
                .font(.headline)

            // 🔴 THIS IS THE CRITICAL PART
            if authorized {
                DeviceActivityReport(
                    DeviceActivityReport.Context("Total Activity"),
                    filter: filter
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray.opacity(0.2))
            }
        }
        .padding()
        .onAppear {
            Task {
                do {
                    try await AuthorizationCenter.shared
                        .requestAuthorization(for: .individual)

                    await MainActor.run {
                        authorized = true
                    }
                } catch {
                    print("Authorization failed:", error)
                }
            }
        }
    }
}
