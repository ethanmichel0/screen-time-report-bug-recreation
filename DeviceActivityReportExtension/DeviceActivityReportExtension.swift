import DeviceActivity
import SwiftUI
import ExtensionKit

@main
struct MyReportExtension: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        TotalActivityReportz { config in
            TotalActivityViewz()
        }
    }
}

// 1️⃣ Define a configuration type
struct EmptyConfiguration {}

// 2️⃣ Conform properly
struct TotalActivityReportz: DeviceActivityReportScene {

    typealias Configuration = EmptyConfiguration

    let context = DeviceActivityReport.Context("Total Activity")

    let content: (EmptyConfiguration) -> TotalActivityViewz

    func makeConfiguration(
        representing data: DeviceActivityResults<DeviceActivityData>
    ) async -> EmptyConfiguration {
        // Ignore data for now
        fatalError("da fatal error")
    }
}

// 3️⃣ View
struct TotalActivityViewz: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("✅ Report Extension Loaded")
                .font(.headline)
            Text("This UI is coming from the extension.")
                .font(.subheadline)
        }
        .padding()
    }
}
