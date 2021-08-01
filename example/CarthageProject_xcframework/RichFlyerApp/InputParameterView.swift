//
//  InputParameterView.swift
//  RichFlyer
//
//  Copyright © 2019年 INFOCITY,Inc. All rights reserved.
//

import Foundation
import UIKit

class InputParameterView: UIView {

	let margin: CGFloat = 8

	var model: Model?
	var type: SegmentParameter?
	
	var contentView = UIView()
	var titleLabel = UILabel()
	var textField: UITextField = UITextField()
	var pickerView: UIPickerView = UIPickerView()
	var underBar = UIView()
	
	var list: Array<String>?
	
	func loadView() {
		self.backgroundColor = UIColor.init(red: 0 / 256, green: 150 / 256, blue: 136 / 256, alpha: 1.0)
		self.layer.masksToBounds = true
		self.layer.cornerRadius = margin

		list = type?.getValues()
		
		self.addSubview(contentView)

		titleLabel.text = type?.rawValue
		titleLabel.textColor = UIColor.white
		contentView.addSubview(titleLabel)

		pickerView.delegate = self
		pickerView.dataSource = self
		pickerView.showsSelectionIndicator = true
		
		let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 35))
		let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
		toolbar.setItems([doneItem], animated: true)
		
		self.textField.text = list?[0]
		textField.textColor = UIColor.white
		textField.textAlignment = .center
		textField.inputView = pickerView
		textField.inputAccessoryView = toolbar
		contentView.addSubview(textField)
		
		underBar.backgroundColor = UIColor.white
		contentView.addSubview(underBar)
	}
	
	func viewDidLayoutSubviews() {
		contentView.frame = CGRect(x: margin, y: margin, width: self.frame.width - margin * 2, height: self.frame.height - margin * 2)
		titleLabel.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height / 2)
		textField.frame = CGRect(x: 0, y: contentView.frame.height / 2, width: contentView.frame.width, height: contentView.frame.height / 2 - 1)
		underBar.frame = CGRect(x: 0, y: contentView.frame.height - 1, width: contentView.frame.width, height: 1)
	}
	
	@objc func done() {
		self.textField.endEditing(true)
	}
	
}

extension InputParameterView: UIPickerViewDelegate, UIPickerViewDataSource {
	
	public func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return list?.count ?? 0
	}

	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return list?[row]
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		self.textField.text = list?[row]
		if let type = type, let value = list?[row] {
			model?.setValue(key: type, value: value)
		}
	}
	
}
