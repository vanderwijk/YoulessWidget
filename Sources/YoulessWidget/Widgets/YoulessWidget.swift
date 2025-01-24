import WidgetKit
import SwiftUI

struct YoulessWidgetExtEntry: TimelineEntry {
    let date: Date
    let powerUsage: Int
}

struct YoulessWidgetExtProvider: TimelineProvider {
    func placeholder(in context: Context) -> YoulessWidgetExtEntry {
        YoulessWidgetExtEntry(date: Date(), powerUsage: 0)
    }

    func getSnapshot(in context: Context, completion: @escaping (YoulessWidgetExtEntry) -> Void) {
        let entry = YoulessWidgetExtEntry(date: Date(), powerUsage: 0)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<YoulessWidgetExtEntry>) -> Void) {
        var entries: [YoulessWidgetExtEntry] = []

        // Fetch data from the Youless P1 meter
        let url = URL(string: "http://192.168.0.4/a?f=j")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                let entry = YoulessWidgetExtEntry(date: Date(), powerUsage: 0)
                entries.append(entry)
                let timeline = Timeline(entries: entries, policy: .atEnd)
                completion(timeline)
                return
            }

            let decoder = JSONDecoder()
            if let json = try? decoder.decode([String: Int].self, from: data), let powerUsage = json["pwr"] {
                let entry = YoulessWidgetExtEntry(date: Date(), powerUsage: powerUsage)
                entries.append(entry)
            } else {
                let entry = YoulessWidgetExtEntry(date: Date(), powerUsage: 0)
                entries.append(entry)
            }

            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
        task.resume()
    }
}

struct YoulessWidgetExtensionView: View {
    var entry: YoulessWidgetExtEntry

    var body: some View {
        VStack {
            Text("Current Power Usage")
                .font(.headline)
            Text("\(entry.powerUsage) W")
                .font(.largeTitle)
                .bold()
        }
        .padding()
    }
}

@main
struct YoulessWidget: Widget {
    let kind: String = "YoulessWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: YoulessWidgetExtProvider()) { entry in
            YoulessWidgetExtensionView(entry: entry)
        }
        .configurationDisplayName("Youless Widget")
        .description("Displays the current power usage from the Youless P1 meter.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
