import SwiftUI
import WidgetKit
import YoulessWidget

struct YoulessWidgetExtEntry: TimelineEntry {
    let date: Date
    let energyUsage: EnergyUsage
}

struct YoulessWidgetExtensionView: View {
    var entry: YoulessWidgetExtEntry

    var body: some View {
        VStack {
            Text("Current Power Usage")
                .font(.headline)
            Text("\(entry.energyUsage.pwr) W")
                .font(.largeTitle)
                .bold()
        }
        .padding()
    }
}

struct YoulessWidgetExtensionView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleEntry = YoulessWidgetExtEntry(
            date: Date(),
            energyUsage: EnergyUsage(cnt: "45468,786",
                                     pwr: 210,
                                     lvl: 0,
                                     dev: "",
                                     det: "",
                                     con: "OK",
                                     sts: "(47)",
                                     cs0: "0,000",
                                     ps0: 0,
                                     raw: 0)
        )
        if #available(macOS 11.0, *) {
            YoulessWidgetExtensionView(entry: sampleEntry)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        } else {
            // Fallback on earlier versions
        };if #available(macOS 11.0, *) {
            YoulessWidgetExtensionView(entry: sampleEntry)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        } else {
            // Fallback on earlier versions
        };if #available(macOS 11.0, *) {
            YoulessWidgetExtensionView(entry: sampleEntry)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        } else {
            // Fallback on earlier versions
        };if #available(macOS 11.0, *) {
            YoulessWidgetExtensionView(entry: sampleEntry)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        } else {
            // Fallback on earlier versions
        };if #available(macOS 11.0, *) {
            YoulessWidgetExtensionView(entry: sampleEntry)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        } else {
            // Fallback on earlier versions
        };if #available(macOS 11.0, *) {
            YoulessWidgetExtensionView(entry: sampleEntry)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        } else {
            // Fallback on earlier versions
        }
    }
}
