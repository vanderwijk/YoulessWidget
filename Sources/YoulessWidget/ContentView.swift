import SwiftUI

struct ContentView: View {
    @State private var energyUsage: EnergyUsage?

    var body: some View {
        VStack {
            if let usage = energyUsage {
                Text("Current Power Usage: \(usage.pwr) W")
                    .font(.largeTitle)
                    .padding()
            } else {
                Text("Loading...")
                    .font(.title)
                    .padding()
            }
        }
        .onAppear {
            fetchEnergyUsage()
        }
    }

    private func fetchEnergyUsage() {
        YoulessService().fetchEnergyUsage { result in
            switch result {
            case .success(let usage):
                DispatchQueue.main.async {
                    self.energyUsage = usage
                }
            case .failure(let error):
                print("Error fetching energy usage: \(error)")
            }
        }
    }
}