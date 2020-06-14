//
//  AppDelegate.swift
//  RichFlyer
//
//  Copyright © 2019年 INFOCITY,Inc. All rights reserved.
//

import UIKit
import UserNotifications

import RichFlyer
import RichFlyerEvent

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	let notificationIdKey: String = "notificationId"
	
	//MARK: UIApplicationDelegate
	func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

    if let confPath = Bundle.main.path(forResource: "RichFlyer", ofType: "plist") {
      if let rfConf = NSDictionary(contentsOfFile: confPath) {
        if let serviceKey = rfConf["serviceKey"] as? String,
          let groupId = rfConf["groupId"] as? String {
          RFApp.setServiceKey(serviceKey: serviceKey,
                            appGroupId: groupId,
                            sandbox: true)
        }
      }
    }

    if #available(iOS 10.0, *) {
			//通知のDelegate設定
			RFApp.setRFNotficationDelegate(delegate: self)
		}
		
		return true
	}
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		//OSの通知許可確認ダイアログより先にダイアログを出す場合、この処理を削除する
		//RichFlyer.requestAuthorization()

		return true
	}
	
	func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
		//通知を受け取るためにデバイスを登録
		RFApp.registDevice(deviceToken: deviceToken, completion: { (result: RFResult) in
            if (!result.result) {
                // 失敗
                print(result.message + "(code:\(result.code))")
            }
        })
		
		#if DEBUG
			let token = deviceToken.map{String(format: "%.2hhx", $0)}.joined()
			print("deviceToken: \(token)")
		#endif
	}
	
	func applicationWillResignActive(_ application: UIApplication) {
	}
	
	func applicationDidEnterBackground(_ application: UIApplication) {
		RFLastNotificationInfo.reset()
	}
	
	func applicationWillEnterForeground(_ application: UIApplication) {
	}
	
	func applicationDidBecomeActive(_ application: UIApplication) {
		RFApp.resetBadgeNumber(application: application)
	}
	
	func applicationWillTerminate(_ application: UIApplication) {
	}
}

@available(iOS 10, *)
extension AppDelegate: RFNotificationDelegate {
    func dismissedContentDisplay(_ action: RFAction?, content: RFContent?) {
        if let rfcontent = content {
            print(rfcontent.notificationId)
        }
        
        if action?.type == "url", let urlStr: String = action?.value {
            if let url: URL = URL(string: urlStr), (url.scheme == "http" || url.scheme == "https") {
                UIApplication.shared.open(url, options: [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly: NSNumber.init(booleanLiteral: false)], completionHandler: nil)
            }
        }
    }
    
	func willPresentNotification(_ center: UNUserNotificationCenter,
	                             willPresent notification: UNNotification,
	                             withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
		//		RichFlyer.createAction(notification: notification)
		RFApp.willPresentNotification(options: [.badge, .alert, .sound], completionHandler: completionHandler)
	}
	
	func didReceiveNotification(_ center: UNUserNotificationCenter,
	                            didReceive response: UNNotificationResponse,
	                            withCompletionHandler completionHandler: @escaping () -> Void) {
		
		RFApp.didReceiveNotification(response: response) { (act, extendedProperty) in
			let notificationId: String = response.notification.request.identifier
			
			let nc = NotificationCenter.default
			var notificationParam: Dictionary = ["id": notificationId, "actionType": act?.type, "actionValue": act?.value]
			if let title: String = act?.title {
				notificationParam["title"] = title
			}
			
			if let action = act {
				let _ = action.title
				let _ = action.value
			}
			
			if let prop = extendedProperty {
				print(prop)
			}
			nc.post(name: Notification.Name(rawValue: "openNotification"), object: notificationParam)
			
			if act?.type == "url", let urlStr: String = act?.value {
				if let url: URL = URL(string: urlStr), (url.scheme == "http" || url.scheme == "https") {
          UIApplication.shared.open(url, options: [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly: NSNumber.init(booleanLiteral: false)], completionHandler: nil)
				}
			}
		}
		
		completionHandler()
	}
	
}

