//
//  RecieveNotificationCell.swift
//  RichFlyerDevelopmentSwift
//
//  Created by akita on 2020/06/17.
//  Copyright © 2020 INFOCITY, Inc. All rights reserved.
//

import UIKit
import RichFlyer

class RecievedNotificationCell: UITableViewCell {
	
	@IBOutlet private var titleLabel: UILabel!
	@IBOutlet private var bodyLabel: UILabel!
	@IBOutlet private var recievedImageView: UIImageView!
	
	@IBOutlet private var titleLeftMarginConstraint: NSLayoutConstraint!
	@IBOutlet private var bodyLeftMarginConstraint: NSLayoutConstraint!
	@IBOutlet private var imageWidthConstraint: NSLayoutConstraint!

	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}
	
	func setup(content: RFContent?) {
		if let content = content {
			titleLabel.text = content.title
			bodyLabel.text = content.body
			
			if content.type == .text || content.imagePath == nil {
				imageWidthConstraint.constant = 0
				titleLeftMarginConstraint.constant = 0
				bodyLeftMarginConstraint.constant = 0
			} else {
				do {
					let imageData = try Data(contentsOf: content.imagePath!)
					recievedImageView.image = UIImage(data: imageData)
				} catch {
					print("画像の取得に失敗しました")
				}
			}
		} else {
			imageWidthConstraint.constant = 0
			titleLeftMarginConstraint.constant = 0
			bodyLeftMarginConstraint.constant = 0
			
			titleLabel.text = "受信した通知がありません"
			bodyLabel.text = ""
		}
	}
}
