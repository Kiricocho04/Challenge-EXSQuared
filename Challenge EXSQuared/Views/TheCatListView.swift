//
//  TheCatListView.swift
//  Challenge EXSQuared
//
//  Created by Matias Nicolas Morales on 06/02/2025.
//

import SwiftUI

struct TheCatListView: View {
    @StateObject private var viewModel = TheCatViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading && viewModel.cats.isEmpty {
                    VStack {
                        ProgressView("Loading cats...")
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(viewModel.cats) { cat in
                            NavigationLink(destination: TheCatDetailView(cat: cat)) {
                                HStack {
                                    AsyncImage(url: URL(string: cat.url)) { image in
                                        image.resizable().scaledToFit()
                                    } placeholder: {
                                        Color.gray.opacity(0.3)
                                    }
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(8)
                                    
                                    Text(cat.breeds.first?.name ?? "Unknown")
                                        .font(.headline)
                                }
                            }
                        }
                        
                        if viewModel.isLoading {
                            ProgressView()
                        } else {
                            Button("Load More") {
                                viewModel.fetchCats()
                            }
                        }
                    }
                    .accessibilityIdentifier("CatList")
                }
            }
            .navigationTitle("Cat Gallery")
            .onAppear {
                if viewModel.cats.isEmpty {
                    viewModel.fetchCats()
                }
            }
        }
    }
}
