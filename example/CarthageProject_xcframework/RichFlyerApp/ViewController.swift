//
//  ViewController.swift
//  RichFlyer
//
//  Copyright © 2019年 INFOCITY,Inc. All rights reserved.
//

import UIKit

import RichFlyer

class ViewController: UIViewController {
	
	//MARK: property
	
	let margin: CGFloat = 8
	let itemCount: CGFloat = 7

	var model = Model()
	
	var inputViews = Array<InputParameterView>()
	
	var sendSegment = UIButton()
	
	//MARK: initialize
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		initViews()
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		initViews()
	}
	
	convenience init() {
		self.init(nibName: nil, bundle: nil)
	}
	
	func initViews() {
        let segmentsParam = model.segmentParams
        let segments = segmentsParam
        
        for type in segments {
            let input = InputParameterView()
            input.model = model
            input.type = type
          inputViews.append(input)
        }
	}
	
	//MARK: ViewController's life cycle
	
	override func loadView() {
		super.loadView()
		
		self.view.backgroundColor = UIColor.white
		#if STAGING
		if let wkTitle = self.title {
			self.title = wkTitle + "(Staging)"
		}
		#endif
		
		for input in inputViews {
			input.loadView()
			self.view.addSubview(input)
		}
		
		#if APNS_SANDBOX
		sendSegment.setTitle("登録(SB)", for: .normal)
		#else
		sendSegment.setTitle("登録", for: .normal)
		#endif
		sendSegment.setTitleColor(UIColor.white, for: .normal)
		sendSegment.backgroundColor = UIColor.darkGray
		sendSegment.addTarget(self, action: #selector(registerSegment), for: .touchUpInside)
		self.view.addSubview(sendSegment)
    }
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		let nc: NotificationCenter = NotificationCenter.default
		nc.addObserver(self, selector: #selector(type(of: self).onOpenPushNotification(notification:)), name: Notification.Name("openNotification"), object: nil)
    
    RFAlertController(application: UIApplication.shared, title: "プッシュ通知", message: "プッシュ通知を許可してお得な情報をゲット！").addImage(imageName: "Information").present(completeHandler: {
      RFApp.requestAuthorization(application: UIApplication.shared, applicationDelegate: UIApplication.shared.delegate!)
    })

	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
		let navBarHeight = self.navigationController?.navigationBar.frame.size.height ?? 0
		let tabBarHeight = self.tabBarController?.tabBar.frame.size.height ?? 0
		
		let contentsHeight = self.view.frame.height - (statusBarHeight + navBarHeight + tabBarHeight)
		
		let viewWidth: CGFloat = self.view.frame.width - margin * 2
		let viewHeight: CGFloat = (contentsHeight - (margin * (itemCount + 1))) / itemCount
		
		var y = statusBarHeight + navBarHeight + margin
		for input in inputViews {
			input.frame = CGRect(x: margin, y: y, width: viewWidth, height: viewHeight)
			input.viewDidLayoutSubviews()
			y = y + margin + viewHeight
		}
		
		sendSegment.layer.masksToBounds = true
		sendSegment.layer.cornerRadius = viewHeight / 2
		sendSegment.frame = CGRect(x: self.view.frame.width / 2 - viewHeight / 2, y: y, width: viewHeight, height: viewHeight)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	//MARK: etc method
	@objc func registerSegment() {

		let segments = model.dictionary;

		var stringSegments : [String : String] = [:]
		var intSegments : [String : Int] = [:]
		var boolSegments : [String : Bool] = [:]
		var dateSegments : [String : Date] = [:]
        
    segments.forEach { (key: String, value: Any) in
      
			switch value {
			case is String:
					let strValue = value as! String
					if strValue == "YES" || strValue == "true" {
							boolSegments[key] = true
					} else if strValue == "NO" || strValue == "false" {
							boolSegments[key] = false
					} else {
							stringSegments[key] = strValue
					}
			case is Int:
					intSegments[key] = (value as! Int)
			case is Date:
				dateSegments[key] = (value as! Date)
			default:
					return
			}
		}
		
		RFApp.registSegments(stringSegments: stringSegments, intSegments: intSegments,
                             boolSegments: boolSegments, dateSegments: dateSegments, completion: { (result: RFResult) in
			DispatchQueue.main.async {
				var message = ""
                if result.result {
					message = "「\(self.model.getValue())」でSegmentを登録しました。"
				} else {
					message = result.message + "(code:\(result.code))"
				}
				
				let alert:UIAlertController = UIAlertController(title:"Segmentの登録",
																												message: message,
																												preferredStyle: UIAlertController.Style.alert)
				let defaultAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil)
				alert.addAction(defaultAction)
				self.present(alert, animated: true, completion: nil)
			}
		})
	}
	
	@objc func onOpenPushNotification(notification: Notification) {
		if let dictionary = notification.object as? Dictionary<String, String> {
			for param in model.notificationParams {
				if let title = dictionary["title"], title == param.getTitle() {
					break;
				}
			}
		}
	}

}

