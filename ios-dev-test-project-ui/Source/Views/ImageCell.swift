import UIKit
import SwiftyGif

class ImageCell: UICollectionViewCell {
	static var identifier: String { String(describing: Self.self) }
	
	private let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.backgroundColor = UIColor.randomColor
		imageView.layer.cornerRadius = 4
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private var task: URLSessionDataTask?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.addSubview(imageView)
		contentView.clipsToBounds = true
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		imageView.frame = contentView.bounds
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		task?.cancel()
		imageView.clear()
	}
	
	func configure(gif: Gif) {
		task = imageView.setGifFromURL(
			gif.images.fixedWidth.url,
			showLoader: false
		)
	}
}
