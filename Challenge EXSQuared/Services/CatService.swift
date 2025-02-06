//
//  CatService.swift
//  Challenge EXSQuared
//
//  Created by Matias Nicolas Morales on 06/02/2025.
//

import Foundation

class CatService {
    private let baseURL = "https://api.thecatapi.com/v1/images/search?limit=10"

    func fetchCats(from url: String, completion: @escaping (Result<[CatModel], Error>) -> Void) {
        guard let url = URL(string: baseURL) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }

            do {
                let cats = try JSONDecoder().decode([CatModel].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(cats))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
