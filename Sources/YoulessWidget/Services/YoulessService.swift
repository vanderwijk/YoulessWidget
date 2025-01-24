import Foundation

class YoulessService {
    let url = URL(string: "http://192.168.0.4/a?f=j")!

    func fetchEnergyUsage(completion: @escaping (Result<EnergyUsage, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            do {
                let energyUsage = try JSONDecoder().decode(EnergyUsage.self, from: data)
                completion(.success(energyUsage))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}