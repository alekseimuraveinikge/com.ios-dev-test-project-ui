import UIKit

class ShareView: UIView {
	let dismissButton: UIButton = {
		let dismissButton = UIButton()
		dismissButton.setImage(UIImage(systemName: "xmark"), for: .normal)
		dismissButton.tintColor = .white
		return dismissButton
	}()
	
	let exportButton: UIButton = {
		let exportButton = UIButton()
		exportButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
		exportButton.tintColor = .white
		return exportButton
	}()
	
	let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.layer.cornerRadius = 4
		imageView.clipsToBounds = true
		return imageView
	}()
	
	let copyLinkButton: UIButton = {
		let copyLinkButton = UIButton()
		copyLinkButton.setTitle("Copy GIF Link", for: .normal)
		copyLinkButton.setTitleColor(.white, for: .normal)
		copyLinkButton.backgroundColor = .purple
		return copyLinkButton
	}()
	
	init() {
		super.init(frame: .zero)
		
		backgroundColor = .black
		
		setupLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupLayout() {
		[
			dismissButton,
			exportButton,
			imageView,
			copyLinkButton
		]
		.forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			addSubview($0)
		}
				
		NSLayoutConstraint.activate([
			dismissButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			dismissButton.leadingAnchor.constraint(equalTo: leadingAnchor),
			dismissButton.widthAnchor.constraint(equalToConstant: 48),
			dismissButton.heightAnchor.constraint(equalTo: dismissButton.widthAnchor),
			
			exportButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			exportButton.trailingAnchor.constraint(equalTo: trailingAnchor),
			exportButton.widthAnchor.constraint(equalToConstant: 48),
			exportButton.heightAnchor.constraint(equalTo: exportButton.widthAnchor),
			
			imageView.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: 32),
			imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
			imageView.widthAnchor.constraint(equalTo: widthAnchor, constant: -32),
			
			imageView.bottomAnchor.constraint(lessThanOrEqualTo: copyLinkButton.topAnchor, constant: -32),
			
			copyLinkButton.heightAnchor.constraint(equalToConstant: 48),
			copyLinkButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -32),
			copyLinkButton.centerXAnchor.constraint(equalTo: centerXAnchor),
			copyLinkButton.widthAnchor.constraint(equalTo: widthAnchor, constant: -64)
		])
	}
}
