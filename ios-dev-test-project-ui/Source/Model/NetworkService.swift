import Foundation

class NetworkService {
	func loadTrending(
		offset: Int = 0,
		_ completion: @escaping (Trending) -> Void
	) {
		let queryItems = [
			URLQueryItem(name: "api_key", value: apiKey),
			URLQueryItem(name: "offset", value: String(offset))
		]
		
		let path = "\(baseURLString)/trending"

		guard var components = URLComponents(string: path) else { return }
		
		components.queryItems = queryItems
		guard let url = components.url else { return }
		
		URLSession.shared.dataTask(with: url) { data, _, _ in
			guard let data = data else { return }
			
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			
			guard let trending = try? decoder.decode(Trending.self, from: data) else {
				return
			}

			completion(trending)
		}
		.resume()
	}
}


private let baseURLString = "https://api.giphy.com/v1/gifs"
private let apiKey = "byGyzKQXUwH8ziCQB5m9qvVk8kw5q2M6"
