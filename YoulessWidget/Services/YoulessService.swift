class YoulessService {
    let url = URL(string: "http://192.168.0.4/a?f=j")!

    func fetchEnergyUsage(completion: @escaping (EnergyUsage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            do {
                let energyUsage = try JSONDecoder().decode(EnergyUsage.self, from: data)
                completion(energyUsage)
            } catch {
                completion(nil)
            }
        }
        task.resume()
    }
}