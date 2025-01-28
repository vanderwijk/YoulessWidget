import WidgetKit
import SwiftUI
import YoulessWidget

struct YoulessWidgetEntry: TimelineEntry {
    let date: Date
    let energyUsage: EnergyUsage?
    
    static let placeholder = YoulessWidgetEntry(date: Date(), energyUsage: nil)
}

struct YoulessWidgetProvider: TimelineProvider {
    let service = YoulessService()
    
    func placeholder(in context: Context) -> YoulessWidgetEntry {
        YoulessWidgetEntry.placeholder
    }

    func getSnapshot(in context: Context, completion: @escaping (YoulessWidgetEntry) -> Void) {
        if context.isPreview {
            completion(YoulessWidgetEntry.placeholder)
            return
        }
        
        fetchLatestUsage { entry in
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<YoulessWidgetEntry>) -> Void) {
        fetchLatestUsage { entry in
            let timeline = Timeline(
                entries: [entry],
                policy: .after(Date().addingTimeInterval(300)) // Refresh every 5 minutes
            )
            completion(timeline)
        }
    }
    
    private func fetchLatestUsage(completion: @escaping (YoulessWidgetEntry) -> Void) {
        service.fetchEnergyUsage { result in
            let entry: YoulessWidgetEntry
            switch result {
            case .success(let usage):
                entry = YoulessWidgetEntry(date: Date(), energyUsage: usage)
            case .failure:
                entry = YoulessWidgetEntry(date: Date(), energyUsage: nil)
            }
            completion(entry)
        }
    }
}

struct YoulessWidgetEntryView: View {
    var entry: YoulessWidgetEntry
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
struct YoulessWidget_Previews: PreviewProvider {
    static var previews: some View {
        YoulessWidgetEntryView(entry: .placeholder)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        
        YoulessWidgetEntryView(entry: .placeholder)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
} 