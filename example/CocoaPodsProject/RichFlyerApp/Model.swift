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
	case launchCount
	case dayTime
	
	func getValues() -> Array<String> {
		switch self {
		case .genre:
			return ["comic", "magazine", "novel"]
		case .day:
			return ["月", "火", "水", "木", "金", "土", "日"]
		case .launchCount:
			return ["0-100", "101-1000", "1001-5000", "5001-10000"]
		case .dayTime:
			return ["朝", "昼", "晩", "深夜"]
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
	var segmentParams: [SegmentParameter] = [.genre, .day, .launchCount, .dayTime]
	var eventParams: [EventParameter] = [.store, .recommend, .wishList, .cart, .purchase]
	var notificationParams: [NotificationParameter] = [.store, .recommend, .wishList, .itemDetail, .feature, .web]

	var dictionary = [SegmentParameter.genre.rawValue: SegmentParameter.genre.getValues()[0],
					  SegmentParameter.day.rawValue: SegmentParameter.day.getValues()[0],
					  SegmentParameter.launchCount.rawValue: SegmentParameter.launchCount.getValues()[0],
					  SegmentParameter.dayTime.rawValue: SegmentParameter.dayTime.getValues()[0]]
	
	func setValue(key: SegmentParameter, value: String) {
		dictionary[key.rawValue] = value
	}

	func getValue() -> String {
		var str: String = ""
		for param in segmentParams {
			let value = dictionary[param.rawValue] ?? ""
			str = str + param.rawValue + " : " + value + "\n"
		}
		return str
	}
	
}
