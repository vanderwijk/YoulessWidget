import WidgetKit
import SwiftUI

struct YoulessWidgetTimeline: TimelineProvider {
    typealias Entry = YoulessWidgetEntry

    func placeholder(in context: Context) -> YoulessWidgetEntry {
        YoulessWidgetEntry(date: Date(), powerUsage: "Loading...")
    }

    func getSnapshot(in context: Context, completion: @escaping (YoulessWidgetEntry) -> ()) {
        let entry = YoulessWidgetEntry(date: Date(), powerUsage: "Snapshot")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [YoulessWidgetEntry] = []
        
        // Fetch data from Youless service
        YoulessService.fetchEnergyUsage { energyUsage in
            let entry = YoulessWidgetEntry(date: Date(), powerUsage: energyUsage.pwr)
            entries.append(entry)
            
            // Create a timeline with a refresh after 15 minutes
            let timeline = Timeline(entries: entries, policy: .after(Date().addingTimeInterval(15 * 60)))
            completion(timeline)
        }
    }
}