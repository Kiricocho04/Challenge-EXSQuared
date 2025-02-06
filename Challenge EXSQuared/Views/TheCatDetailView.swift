//
//  TheCatDetailView.swift
//  Challenge EXSQuared
//
//  Created by Matias Nicolas Morales on 06/02/2025.
//

import SwiftUI

struct TheCatDetailView: View {
    let cat: CatModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: cat.url)) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 300)
                .cornerRadius(12)
                .shadow(radius: 5)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(cat.breeds.first?.name ?? "Unknown Breed")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    if let breed = cat.breeds.first {
                        Text("🌍 Origin: \(breed.origin)")
                            .font(.subheadline)
                        
                        Text("🧬 Temperament: \(breed.temperament)")
                            .font(.subheadline)
                        
                        Text("⏳ Lifespan: \(breed.life_span) years")
                            .font(.subheadline)
                    
                    } else {
                        Text("No breed information available.")
                            .italic()
                    }
                }
                .padding()
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Cat Details")
    }
}

