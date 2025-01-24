import WidgetKit
import SwiftUI

struct YoulessWidgetEntry: TimelineEntry {
    let date: Date
    let powerUsage: Int
}

struct YoulessWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> YoulessWidgetEntry {
        YoulessWidgetEntry(date: Date(), powerUsage: 0)
    }

    func getSnapshot(in context: Context, completion: @escaping (YoulessWidgetEntry) -> Void) {
        let entry = YoulessWidgetEntry(date: Date(), powerUsage: 0)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<YoulessWidgetEntry>) -> Void) {
        var entries: [YoulessWidgetEntry] = []

        // Fetch data from the Youless P1 meter
        let url = URL(string: "http://192.168.0.4/a?f=j")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                let entry = YoulessWidgetEntry(date: Date(), powerUsage: 0)
                entries.append(entry)
                let timeline = Timeline(entries: entries, policy: .atEnd)
                completion(timeline)
                return
            }

            let decoder = JSONDecoder()
            if let json = try? decoder.decode([String: Int].self, from: data), let powerUsage = json["pwr"] {
                let entry = YoulessWidgetEntry(date: Date(), powerUsage: powerUsage)
                entries.append(entry)
            } else {
                let entry = YoulessWidgetEntry(date: Date(), powerUsage: 0)
                entries.append(entry)
            }

            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
        task.resume()
    }
}

struct YoulessWidgetView: View {
    var entry: YoulessWidgetProvider.Entry

    var body: some View {
        Text("Power Usage: \(entry.powerUsage) W")
    }
}

@main
struct YoulessWidget: Widget {
    let kind: String = "YoulessWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: YoulessWidgetProvider()) { entry in
            YoulessWidgetView(entry: entry)
        }
        .configurationDisplayName("Youless Widget")
        .description("Displays the current power usage from the Youless P1 meter.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}