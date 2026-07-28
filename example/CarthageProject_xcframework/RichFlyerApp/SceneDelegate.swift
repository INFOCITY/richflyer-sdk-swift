//
//  SceneDelegate.swift
//  RichFlyer
//
//  Copyright © 2019年 INFOCITY,Inc. All rights reserved.
//

import UIKit

import RichFlyer

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = scene as? UIWindowScene else { return }

		let window = UIWindow(windowScene: windowScene)
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		window.rootViewController = storyboard.instantiateInitialViewController()
		self.window = window
		window.makeKeyAndVisible()

		(UIApplication.shared.delegate as? AppDelegate)?.window = window
	}

	func sceneWillResignActive(_ scene: UIScene) {
	}

	func sceneWillEnterForeground(_ scene: UIScene) {
	}

	func sceneDidBecomeActive(_ scene: UIScene) {
		RFApp.resetBadgeNumber(application: UIApplication.shared)
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
		RFLastNotificationInfo.reset()
	}
}
