import UIKit

struct Trending: Decodable {
	let data: [Gif]
}

struct Gif: Decodable {
	let images: Images
}

struct Images: Decodable {
	let original: Original
	let fixedWidth: FixedWidth
}

struct Original: Decodable {
	let url: URL
}

struct FixedWidth: Decodable {
	let url: URL
	let height: CGFloat
	
	enum CodingKeys: String, CodingKey {
		case url
		case height
	}
	
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		
		url = try values.decode(URL.self, forKey: .url)
		let stringHeight = try values.decode(String.self, forKey: .height)
		
		guard let number = NumberFormatter().number(from: stringHeight) else {
			throw TrendingDecodingError.wrongHeight
		}
		
		height = CGFloat(truncating: number)
	}
}


enum TrendingDecodingError: Error {
	case wrongHeight
}
