import WidgetKit
import SwiftUI
import Intents

struct YoulessWidgetEntry: TimelineEntry {
    let date: Date
    let energyUsage: EnergyUsage
}

struct YoulessWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> YoulessWidgetEntry {
        YoulessWidgetEntry(date: Date(), energyUsage: EnergyUsage(cnt: "0", pwr: 0, lvl: 0, dev: "", det: "", con: "OK", sts: "(0)", cs0: "0", ps0: 0, raw: 0))
    }

    func getSnapshot(in context: Context, completion: @escaping (YoulessWidgetEntry) -> ()) {
        let entry = YoulessWidgetEntry(date: Date(), energyUsage: EnergyUsage(cnt: "0", pwr: 0, lvl: 0, dev: "", det: "", con: "OK", sts: "(0)", cs0: "0", ps0: 0, raw: 0))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<YoulessWidgetEntry>) -> ()) {
        fetchEnergyUsage { energyUsage in
            let entry = YoulessWidgetEntry(date: Date(), energyUsage: energyUsage)
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }

    private func fetchEnergyUsage(completion: @escaping (EnergyUsage) -> ()) {
        guard let url = URL(string: "http://192.168.0.4/a?f=j") else {
            completion(EnergyUsage(cnt: "0", pwr: 0, lvl: 0, dev: "", det: "", con: "ERROR", sts: "(0)", cs0: "0", ps0: 0, raw: 0))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(EnergyUsage(cnt: "0", pwr: 0, lvl: 0, dev: "", det: "", con: "ERROR", sts: "(0)", cs0: "0", ps0: 0, raw: 0))
                return
            }

            do {
                let energyUsage = try JSONDecoder().decode(EnergyUsage.self, from: data)
                completion(energyUsage)
            } catch {
                completion(EnergyUsage(cnt: "0", pwr: 0, lvl: 0, dev: "", det: "", con: "ERROR", sts: "(0)", cs0: "0", ps0: 0, raw: 0))
            }
        }
        task.resume()
    }
}

struct YoulessWidget: Widget {
    let kind: String = "YoulessWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: YoulessWidgetProvider()) { entry in
            YoulessWidgetView(entry: entry)
        }
        .configurationDisplayName("Youless Energy Usage")
        .description("Displays the current energy usage from your Youless P1 meter.")
    }
}

struct YoulessWidget_Previews: PreviewProvider {
    static var previews: some View {
        YoulessWidgetView(entry: YoulessWidgetEntry(date: Date(), energyUsage: EnergyUsage(cnt: "0", pwr: 0, lvl: 0, dev: "", det: "", con: "OK", sts: "(0)", cs0: "0", ps0: 0, raw: 0)))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}