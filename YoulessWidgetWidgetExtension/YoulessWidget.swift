import WidgetKit
import SwiftUI

struct YoulessWidget: Widget {
    let kind: String = "YoulessWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: YoulessWidgetProvider()) { entry in
            YoulessWidgetView(entry: entry)
        }
        .configurationDisplayName("Youless Energy Usage")
        .description("Displays the current energy usage from your Youless P1 meter.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}