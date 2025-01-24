import SwiftUI
import WidgetKit

struct YoulessWidgetView: View {
    var entry: YoulessWidgetEntry

    @available(macOS 10.15, *)
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

struct YoulessWidgetView_Previews: PreviewProvider {
    @available(macOS 10.15, *)
    static var previews: some View {
        let sampleEntry = YoulessWidgetEntry(date: Date(), energyUsage: EnergyUsage(cnt: "45468,786", pwr: 210, lvl: 0, dev: "", det: "", con: "OK", sts: "(47)", cs0: "0,000", ps0: 0, raw: 0))
        YoulessWidgetView(entry: sampleEntry)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
