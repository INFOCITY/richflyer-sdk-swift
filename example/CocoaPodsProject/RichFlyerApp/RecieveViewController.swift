//
//  RecieveViewController.swift
//  RichFlyer
//
//  Copyright © 2019年 INFOCITY,Inc. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import RichFlyer

class RecieveViewController: UIViewController {
	
	@IBOutlet var button: UIButton!
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		self.button.layer.masksToBounds = true
		self.button.layer.cornerRadius = self.button.frame.size.height / 2
    self.button.setTitle("受信した通知を表示", for: UIControl.State.normal)
	}
	
	
	@IBAction func show() {
		// ローカル通知作成
		guard #available(iOS 10.0, *) else {
			return
		}
	
		if let latestContent : RFContent = RFApp.getLatestReceivedData() {
			let display = RFContentDisplay.init(content: latestContent)
			display.present(parent: self, completeHandler:{ (action : RFAction) in
				
				if (action.type == "url") {
					if let url = URL(string: action.value) {
						UIApplication.shared.open(url, options: [:], completionHandler: nil)
					}
				}
				display.dismiss()
				
			})
		}
	}
}
