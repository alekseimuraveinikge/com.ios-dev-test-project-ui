//
//  AppDelegate.swift
//  ios-dev-test-project-ui
//
//  Created by Apple on 26.07.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
	
		let window = UIWindow(frame: UIScreen.main.bounds)
		let controller = MainViewController()
		window.rootViewController = controller
		window.makeKeyAndVisible()
		self.window = window
		
		return true
	}
}
