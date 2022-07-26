import UIKit

class MainView: UIView {
	init() {
		super.init(frame: .zero)
		
		backgroundColor = .white
		setupLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupLayout() {
		let label = UILabel()
		label.text = "Hello World!"
		
		[
			label
		]
		.forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			addSubview($0)
		}
		
		NSLayoutConstraint.activate([
			label.centerXAnchor.constraint(equalTo: centerXAnchor),
			label.centerYAnchor.constraint(equalTo: centerYAnchor)
		])
	}
}
