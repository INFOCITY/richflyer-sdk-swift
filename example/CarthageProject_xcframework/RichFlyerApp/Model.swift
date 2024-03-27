//
//  Model.swift
//  RichFlyer
//
//  Copyright © 2019年 INFOCITY,Inc. All rights reserved.
//

import Foundation


enum SegmentParameter: String, CaseIterable {
	case genre
	case day
	case age
	case registered
  case birthday
  case installedDate
	
	func getValues() -> Array<Any> {
		switch self {
		case .genre:
			return ["comic", "magazine", "novel"]
		case .day:
			return ["月", "火", "水", "木", "金", "土", "日"]
		case .age:
			return [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
		case .registered:
			return ["true", "false"]
    case .birthday:
      return [Date()]
    case .installedDate:
      return [Date()]
		}
	}
	
	func getName() -> String {
		switch self {
		case .genre:
			return "ジャンル"
		case .day:
			return "曜日"
		case .age:
			return "年齢"
		case .registered:
			return "登録状況"
		case .birthday:
			return "誕生日"
		case .installedDate:
			return "インストール日"
		}
	}

}

enum EventParameter: CaseIterable {
	case store
	case recommend
	case wishList
	case cart
	case purchase
	
	func getEventName() -> String {
		switch self {
		case .store:
			return "OpenStore"
		case .recommend:
			return "OpenRecommend"
		case .wishList:
			return "AddWishList"
		case .cart:
			return "AddCart"
		case .purchase:
			return "Purchase"
		}
	}
	
	func getTitle() -> String {
		switch self {
		case .store:
			return "ストアを開く"
		case .recommend:
			return "オススメ画面を開く"
		case .wishList:
			return "ほしいものリスト追加"
		case .cart:
			return "カート追加"
		case .purchase:
			return "購入"
		}
	}
}

enum NotificationParameter: CaseIterable {
	case store
	case recommend
	case wishList
	case itemDetail
	case feature
	case web
	
	func getEventName() -> String {
		switch self {
		case .store:
			return "NotificationOpenStore"
		case .recommend:
			return "NotificationOpenRecommend"
		case .wishList:
			return "NotificationAddWishList"
		case .itemDetail:
			return "NotificationOpenItemDetailPage"
		case .feature:
			return "NotificationOpenFeaturePage"
		case .web:
			return "NotificationOpenWebPage"
		}
	}
	
	func getTitle() -> String {
		switch self {
		case .store:
			return "ストアを開く"
		case .recommend:
			return "オススメ画面を開く"
		case .wishList:
			return "ほしいものリスト追加"
		case .itemDetail:
			return "商品詳細ページを開く"
		case .feature:
			return "特集ページを開く"
		case .web:
			return "案内ページを開く"
		}
	}
}

class Model {
  var segmentParams: [SegmentParameter] = [.genre, .day, .age, .registered, .birthday, .installedDate]
	var eventParams: [EventParameter] = [.store, .recommend, .wishList, .cart, .purchase]
	var notificationParams: [NotificationParameter] = [.store, .recommend, .wishList, .itemDetail, .feature, .web]


	var dictionary = [SegmentParameter.genre.rawValue: SegmentParameter.genre.getValues()[0],
					  SegmentParameter.day.rawValue: SegmentParameter.day.getValues()[0],
					  SegmentParameter.age.rawValue: SegmentParameter.age.getValues()[0],
					  SegmentParameter.registered.rawValue: SegmentParameter.registered.getValues()[0],
										SegmentParameter.birthday.rawValue: SegmentParameter.birthday.getValues()[0],
										SegmentParameter.installedDate.rawValue: SegmentParameter.installedDate.getValues()[0]
  ]

  static func getDateString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat  = "yyyy/MM/dd"
    return dateFormatter.string(from: date)
  }
  
	func setValue(key: SegmentParameter, value: Any) {
		dictionary[key.rawValue] = value
	}

	func getValue() -> String {
		var str: String = ""
		for param in segmentParams {
			let value = dictionary[param.rawValue] ?? ""
            str = str + param.rawValue + " : " + String(describing: value) + "\n"
		}
		return str
	}
	
}
