//
//  NewsRowView.swift
//  FmzrNews
//
//  Created by Irfandi Kurniawan Anwar on 29/08/23.
//

import SwiftUI

struct NewsRowView: View {
    
    @ObservedObject var netApi = NetworkingAPI()
    @State private var selectedArticle: Article?
    
    var body: some View {
        NavigationView {
            List(netApi.Hasil) { hasil in
                VStack(alignment: .leading, spacing: 16) {
                    AsyncImage(url: hasil.imageURL) { phase in
                        switch phase {
                        case .empty:
                            HStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .failure(_):
                            Image(systemName: "photo")
                        @unknown default:
                            fatalError()
                        }
                    }
                    .frame(minHeight: 200, maxHeight: 300)
                    .background(Color.gray.opacity(0.3))
                    .clipped()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(hasil.title)
                            .font(.headline)
                            .lineLimit(3)
                        Text(hasil.summary)
                            .font(.subheadline)
                            .lineLimit(2)
                        
                        HStack {
                            Text(hasil.news_site)
                                .lineLimit(1)
                                .foregroundColor(.secondary)
                                .font(.caption)
                            
                            Spacer()
                            
                            Button {
                                presentShareSheet(url: hasil.siteURL!)
                            } label: {
                                Image(systemName: "square.and.arrow.up")
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                    .padding([.horizontal, .bottom])
                    .onTapGesture {
                        selectedArticle = hasil
                    }
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .sheet(item: $selectedArticle) {
                SafariView(url: $0.siteURL!)
                    .edgesIgnoringSafeArea(.bottom)
            }
        }
        .onAppear {
            self.netApi.fetchData()
        }
    }
}

extension View {
    func presentShareSheet(url: URL) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .keyWindow?
            .rootViewController?
            .present(activityVC, animated: true)
    }
}

struct NewsRowView_Previews: PreviewProvider {
    static var previews: some View {
            NewsRowView()
    }
}
