//
//  NetworkingAPI.swift
//  FmzrNews
//
//  Created by Irfandi Kurniawan Anwar on 29/08/23.
//

import Foundation

class NetworkingAPI: ObservableObject {
    
    @Published var Hasil = [Article]()
    
    func fetchData() {
        
        if let url = URL(string: "https://api.spaceflightnewsapi.net/v4/articles/?limit=100"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let result = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.async {
                                self.Hasil = result.results
                            }
                        } catch {
                            print(error)
                            
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
