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
	
	@IBOutlet var tableView: UITableView!
	let reuseIdentifier: String = "recievedData"
	var recievedData: [RFContent]? = nil
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		recievedData = RFApp.getReceivedData()
		tableView.reloadData()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(UINib(nibName: "RecievedNotificationCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
	}
	
	func show(content: RFContent) {
		// ローカル通知作成
		guard #available(iOS 10.0, *) else {
			return
		}
	
		let display = RFContentDisplay.init(content: content)
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

extension RecieveViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let recievedData = self.recievedData {
			return recievedData.count
		} else {
			return 1
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var content: RFContent? = nil
		if let recievedData = recievedData {
			content = recievedData[indexPath.row]
		}
		
		let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
		if let cell = cell as? RecievedNotificationCell {
			cell.setup(content: content)
			return cell
		} else {
			let newCell = UINib(nibName: "RecievedNotificationCell", bundle: nil).instantiate(withOwner: self, options: nil).first as! RecievedNotificationCell
			newCell.setup(content: content)
			return newCell
		}
	}
}

extension RecieveViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		guard let recievedData = self.recievedData else {
			return
		}
		
		show(content: recievedData[indexPath.row])
	}
}
