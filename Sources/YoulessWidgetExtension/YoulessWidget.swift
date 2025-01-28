import WidgetKit
import SwiftUI
import YoulessWidget

@available(iOS 14.0, macOS 11.0, *)
struct WidgetEntry: TimelineEntry {
    let date: Date
    let energyUsage: EnergyUsage?
    
    static let placeholder = WidgetEntry(date: Date(), energyUsage: nil)
}

@available(iOS 14.0, macOS 11.0, *)
struct YoulessWidgetProvider: TimelineProvider {
    let service = YoulessService()
    
    func placeholder(in context: Context) -> WidgetEntry {
        WidgetEntry.placeholder
    }

    func getSnapshot(in context: Context, completion: @escaping (WidgetEntry) -> Void) {
        if context.isPreview {
            completion(WidgetEntry.placeholder)
            return
        }
        
        fetchLatestUsage { entry in
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<WidgetEntry>) -> Void) {
        fetchLatestUsage { entry in
            let timeline = Timeline(
                entries: [entry],
                policy: .after(Date().addingTimeInterval(300)) // Refresh every 5 minutes
            )
            completion(timeline)
        }
    }
    
    private func fetchLatestUsage(completion: @escaping (WidgetEntry) -> Void) {
        service.fetchEnergyUsage { result in
            let entry: WidgetEntry
            switch result {
            case .success(let usage):
                entry = WidgetEntry(date: Date(), energyUsage: usage)
            case .failure:
                entry = WidgetEntry(date: Date(), energyUsage: nil)
            }
            completion(entry)
        }
    }
}

@available(iOS 14.0, macOS 11.0, *)
struct YoulessWidgetEntryView: View {
    var entry: WidgetEntry
    @Environment(\.widgetFamily) var family

    var body: some View {
        VStack {
            Text("Current Power Usage")
                .font(.headline)
            if let usage = entry.energyUsage {
                Text("\(usage.pwr) W")
                    .font(.largeTitle)
                    .bold()
            } else {
                Text("--")
                    .font(.largeTitle)
                    .bold()
            }
        }
        .padding()
    }
}

@available(iOS 14.0, macOS 11.0, *)
@main
struct YoulessWidget: Widget {
    private let kind = "YoulessWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: YoulessWidgetProvider()) { entry in
            YoulessWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Youless Widget")
        .description("Displays current power usage from Youless P1 meter")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// MARK: - Preview
@available(iOS 14.0, macOS 11.0, *)
struct YoulessWidget_Previews: PreviewProvider {
    static var previews: some View {
        YoulessWidgetEntryView(entry: .placeholder)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        
        YoulessWidgetEntryView(entry: .placeholder)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
} 