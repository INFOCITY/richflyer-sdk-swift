//
//  EventViewController.swift
//  RichFlyerDevelopmentSwift
//
//  Created by Takeshi Goto on 2023/11/24.
//  Copyright © 2023 INFOCITY, Inc. All rights reserved.
//

import UIKit
import RichFlyer

class EventViewController: UIViewController, UITextFieldDelegate {
		
	let eventText1 = UITextField()
	let eventText2 = UITextField()
	let eventText3 = UITextField()
	let eventBaseView = UIView();
	
	let variable1Name = UITextField()
	let variable1Value = UITextField()
	let variable2Name = UITextField()
	let variable2Value = UITextField()
	let variable3Name = UITextField()
	let variable3Value = UITextField()
	let variableBaseView = UIView();

	let standbyTime = UITextField()
	let standbyTimeBaseView = UIView();

	var sendButton = UIButton()
	var cancelButton = UIButton()

	var postIds: [String] = []
	
	let itemHeight = 30.0
	let itemTopMargin = 10.0
	let itemSideMargin = 5.0
	let baseViewColor = UIColor.init(red: 0 / 256, green: 150 / 256, blue: 136 / 256, alpha: 1.0)
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	override func loadView() {
		super.loadView()
		
		
		initEventView()
		
		initVariableView()
		
		initStanbyTimeView()
		
		initSendButton()
		
		initCancelButton()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
		view.addGestureRecognizer(tap)
	}
	
	private func initEventView() {

		let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
		let navBarHeight = self.navigationController?.navigationBar.frame.size.height ?? 0

		
		setBaseView(baseView: eventBaseView,
								frame: CGRect(x: itemSideMargin, y: statusBarHeight + navBarHeight,
															width: self.view.bounds.width - itemSideMargin*2,
															height: (itemHeight+itemTopMargin) * 4 + itemTopMargin * 2))
		
		let itemWidth = self.view.bounds.width - itemSideMargin * 4

		let label = UILabel()
		setLabel(label: label,
						 frame: CGRect(x: itemSideMargin, y: itemTopMargin, width: itemWidth, height: itemHeight),
						 text: "イベント名",
						 baseView: eventBaseView)

		setTextField(textField: eventText1,
								 frame: CGRect(x: itemSideMargin, y: label.frame.maxY + itemTopMargin, width: itemWidth, height: itemHeight),
								 placeholder: "event1",
								 baseView: eventBaseView)

		setTextField(textField: eventText2,
								 frame: CGRect(x: itemSideMargin, y: eventText1.frame.maxY + itemTopMargin, width: itemWidth, height: itemHeight),
								 placeholder: "event2",
								 baseView: eventBaseView)

		setTextField(textField: eventText3,
								 frame: CGRect(x: itemSideMargin, y: eventText2.frame.maxY + itemTopMargin, width: itemWidth, height: itemHeight),
								 placeholder: "event3",
								 baseView: eventBaseView)
		
		self.view.addSubview(eventBaseView)
	}
	
	private func initVariableView() {
		setBaseView(baseView: variableBaseView,
								frame: CGRect(x: itemSideMargin, y: eventBaseView.frame.maxY+itemTopMargin,
															width: self.view.bounds.width - itemSideMargin*2, 
															height: (itemHeight+itemTopMargin) * 4 + itemTopMargin * 2))
		
		var itemWidth = self.view.bounds.width - itemSideMargin * 4

		let label = UILabel()
		setLabel(label: label,
						 frame: CGRect(x: itemSideMargin, y: itemTopMargin, width: itemWidth, height: itemHeight),
						 text: "変数",
						 baseView: variableBaseView)

		itemWidth = itemWidth / 2 - itemTopMargin
		setTextField(textField: variable1Name,
								 frame: CGRect(x: itemSideMargin, y: label.frame.maxY + itemTopMargin, width: itemWidth, height: itemHeight),
								 placeholder: "名前",
								 baseView: variableBaseView)

		setTextField(textField: variable1Value,
								 frame: CGRect(x: variableBaseView.bounds.width - (itemWidth + itemSideMargin), y: variable1Name.frame.origin.y, width: itemWidth, height: itemHeight),
								 placeholder: "値",
								 baseView: variableBaseView)

		setTextField(textField: variable2Name,
								 frame: CGRect(x: itemSideMargin, y: variable1Name.frame.maxY + itemTopMargin, width: itemWidth, height: itemHeight),
								 placeholder: "名前",
								 baseView: variableBaseView)

		setTextField(textField: variable2Value,
								 frame: CGRect(x: variableBaseView.bounds.width - (itemWidth + itemSideMargin), y: variable2Name.frame.origin.y, width: itemWidth, height: itemHeight),
								 placeholder: "値",
								 baseView: variableBaseView)

		setTextField(textField: variable3Name,
								 frame: CGRect(x: itemSideMargin, y: variable2Name.frame.maxY + itemTopMargin, width: itemWidth, height: itemHeight),
								 placeholder: "名前",
								 baseView: variableBaseView)

		setTextField(textField: variable3Value,
								 frame: CGRect(x: variableBaseView.bounds.width - (itemWidth + itemSideMargin), y: variable3Name.frame.origin.y, width: itemWidth, height: itemHeight),
								 placeholder: "値",
								 baseView: variableBaseView)

		
		self.view.addSubview(variableBaseView)

	}
	
	private func initStanbyTimeView() {
		setBaseView(baseView: standbyTimeBaseView,
								frame: CGRect(x: itemSideMargin, y: variableBaseView.frame.maxY+itemTopMargin, 
															width: self.view.bounds.width - itemSideMargin*2, height: (itemHeight+itemTopMargin) * 2 + itemTopMargin * 2))
		
		let itemWidth = self.view.bounds.width - itemSideMargin * 4

		let label = UILabel()
		setLabel(label: label,
						 frame: CGRect(x: itemSideMargin, y: itemTopMargin, width: itemWidth, height: itemHeight),
						 text: "待機時間",
						 baseView: standbyTimeBaseView)

		setTextField(textField: standbyTime,
								 frame: CGRect(x: itemSideMargin, y: label.frame.maxY + itemTopMargin, width: itemWidth, height: itemHeight),
								 placeholder: "分",
								 baseView: standbyTimeBaseView)
		
		self.view.addSubview(standbyTimeBaseView)

	}
	
	private func initSendButton() {
		sendButton.setTitle("送信", for: .normal)
		sendButton.setTitleColor(UIColor.white, for: .normal)
		sendButton.backgroundColor = UIColor.darkGray
		sendButton.addTarget(self, action: #selector(onSendButtonTapped), for: .touchUpInside)

		let buttonHeight = itemHeight * 3
		sendButton.layer.masksToBounds = true
		sendButton.layer.cornerRadius = buttonHeight / 2
		sendButton.frame = CGRect(x: self.view.frame.width / 2.0 - buttonHeight / 2.0,
															y: standbyTimeBaseView.frame.maxY + itemTopMargin,
															width: buttonHeight, height: buttonHeight)
		
		self.view.addSubview(sendButton)

	}

	private func initCancelButton() {
		cancelButton.setTitle("キャンセル", for: .normal)
		cancelButton.setTitleColor(UIColor.white, for: .normal)
		cancelButton.backgroundColor = UIColor.darkGray
		cancelButton.addTarget(self, action: #selector(onCancelButtonTapped), for: .touchUpInside)

		let buttonHeight = itemHeight * 3
		cancelButton.layer.masksToBounds = true
		cancelButton.layer.cornerRadius = buttonHeight / 2
		cancelButton.frame = CGRect(x: self.view.frame.width / 2.0 - buttonHeight / 2.0,
															y: sendButton.frame.maxY + itemTopMargin,
															width: buttonHeight, height: buttonHeight)
		
		self.view.addSubview(cancelButton)

	}

	
	private func setBaseView(baseView: UIView, frame: CGRect) {
		baseView.frame = frame
		baseView.backgroundColor = baseViewColor
		baseView.layer.masksToBounds = true
		baseView.layer.cornerRadius = 5
		self.view.addSubview(baseView)
	}
	
	private func setLabel(label: UILabel, frame: CGRect, text: String, baseView: UIView) {
		label.text = text
		label.textColor = .white
		label.frame = frame
		baseView.addSubview(label)
	}
	
	private func setTextField(textField: UITextField, frame: CGRect, placeholder: String, baseView: UIView) {
		textField.frame = frame
		textField.backgroundColor = .clear
		textField.attributedPlaceholder = NSAttributedString(string: placeholder,
																												 attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
		textField.layer.cornerRadius = 5
		textField.layer.masksToBounds = true
		textField.autocapitalizationType = .none
		textField.textColor = .white
		
		let bottomLine = CALayer()
		bottomLine.frame = CGRect(x: 0.0, y: frame.size.height - 1.0, width: frame.size.width, height: 1.0)
		bottomLine.backgroundColor = UIColor.white.cgColor
		textField.borderStyle = .none
		textField.layer.addSublayer(bottomLine)
		
		baseView.addSubview(textField)
	}
	
	@objc private func onSendButtonTapped(){
		
		var events : [String] = []
		if let event = self.eventText1.text, event.count > 0 {
			
			events.append(event)
		}
		if let event = self.eventText2.text, event.count > 0 {
			events.append(event)
		}
		if let event = self.eventText3.text, event.count > 0 {
			events.append(event)
		}
		
		var variables : [String : String] = [:]
		if let name = self.variable1Name.text, let value = self.variable1Value.text {
			variables[name] = value
		}
		if let name = self.variable2Name.text, let value = self.variable2Value.text {
			variables[name] = value
		}
		if let name = self.variable3Name.text, let value = self.variable3Value.text {
			variables[name] = value
		}

		var standbyTime : NSNumber? = nil
		if let standbyTimeStr = self.standbyTime.text, let standbyTimeInt = Int(standbyTimeStr) {
			standbyTime = NSNumber(value: standbyTimeInt)
		}
		
		
		RFApp.postMessage(events: events, variables: variables, standbyTime: standbyTime) { result, eventPostIds in

      var message : String
      if (result.result) {
        var postIds : String = ""
        eventPostIds?.forEach({ postId in
          print("PostId:\(postId)")
          self.postIds.append(postId)
          postIds += "\(postId)\n"
        })
        message = "メッセージ送信リクエストに成功しました。\n送信ID:\n\(postIds)"
				print("Post Message has succeeded.")
			} else {
        message = "メッセージ送信リクエストに失敗しました。\nstatus:\(result.code)\nmessage:\(result.message)"
				print("Post Message has failed.")
			}
			
      DispatchQueue.main.async {
        let alert:UIAlertController = UIAlertController(title:"イベント送信",
                                                        message: message,
                                                        preferredStyle: UIAlertController.Style.alert)
        let defaultAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
      }
		}
		
	}
	
	@objc func onCancelButtonTapped() {
		postIds.forEach { postId in
			RFApp.cancelPosting(postId) { result in
				if (result.result) {
					print("Cancel Message has succeeded. ID: \(postId)")
				} else {
					print("Cancel Message has faled. ID: \(postId)")
				}
			}
		}
	}
	
	@objc func keyBoardWillShow(notification: NSNotification) {
	}
	
	
	@objc func keyBoardWillHide(notification: NSNotification) {
	}
	
	
	@objc func dismissKeyboard() {
			//Causes the view (or one of its embedded text fields) to resign the first responder status.
			view.endEditing(true)
	}
}
