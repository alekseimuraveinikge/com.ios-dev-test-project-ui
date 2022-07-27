import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
	
		let window = UIWindow(frame: UIScreen.main.bounds)
		let controller = MainViewController(
			networkService: NetworkService()
		)
		window.rootViewController = controller
		window.makeKeyAndVisible()
		self.window = window
		
		return true
	}
}
