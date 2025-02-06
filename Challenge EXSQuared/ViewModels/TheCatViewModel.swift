//
//  TheCatViewModel.swift
//  Challenge EXSQuared
//
//  Created by Matias Nicolas Morales on 06/02/2025.
//

import Foundation

class TheCatViewModel: ObservableObject {
    @Published var cats: [CatModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showingError = false


    private var service = CatService()
    private var currentPage = 0
    private let limit = 10

    func fetchCats() {
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        let url = "https://api.thecatapi.com/v1/images/search?limit=\(limit)&page=\(currentPage)"

        service.fetchCats(from: url) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let newCats):
                    self?.cats.append(contentsOf: newCats)
                    self?.currentPage += 1
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showingError = true
                }
            }
        }
    }
}

