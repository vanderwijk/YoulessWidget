struct YoulessWidgetEntry: TimelineEntry {
    let date: Date
    let energyUsage: EnergyUsage
}

extension YoulessWidgetEntry {
    static func fetchEnergyUsage(completion: @escaping (YoulessWidgetEntry?) -> Void) {
        guard let url = URL(string: "http://192.168.0.4/a?f=j") else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let energyUsage = try JSONDecoder().decode(EnergyUsage.self, from: data)
                let entry = YoulessWidgetEntry(date: Date(), energyUsage: energyUsage)
                completion(entry)
            } catch {
                completion(nil)
            }
        }
        
        task.resume()
    }
}