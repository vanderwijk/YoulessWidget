import WidgetKit
import SwiftUI
import Intents

struct YoulessWidgetProvider: TimelineProvider {
    typealias Entry = YoulessWidgetEntry

    func placeholder(in context: Context) -> YoulessWidgetEntry {
        YoulessWidgetEntry(date: Date(), powerUsage: "Loading...")
    }

    func getSnapshot(in context: Context, completion: @escaping (YoulessWidgetEntry) -> ()) {
        let entry = YoulessWidgetEntry(date: Date(), powerUsage: "Snapshot")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        fetchEnergyUsage { powerUsage in
            let entry = YoulessWidgetEntry(date: Date(), powerUsage: powerUsage)
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }

    private func fetchEnergyUsage(completion: @escaping (String) -> Void) {
        guard let url = URL(string: "http://192.168.0.4/a?f=j") else {
            completion("Error")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, 
               let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let power = json["pwr"] as? Int {
                completion("\(power) W")
            } else {
                completion("Error")
            }
        }
        task.resume()
    }
}