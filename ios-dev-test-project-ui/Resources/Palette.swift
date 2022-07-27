import UIKit

extension UIColor {
	static let cyan = UIColor(named: "Cyan")!
	static let magenta = UIColor(named: "Magenta")!
	static let purple = UIColor(named: "Purple")!
	
	static var randomColor: UIColor {
		[
			cyan,
			magenta,
			purple
		]
		.randomElement()!
	}
}
