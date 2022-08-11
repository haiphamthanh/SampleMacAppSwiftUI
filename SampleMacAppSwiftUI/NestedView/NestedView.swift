//
//  NestedView.swift
//  SampleAppMac
//
//  Created by HaiPham on 10/08/2022.
//
// https://swiftuirecipes.com/blog/file-tree-with-expanding-list-in-swiftui

import SwiftUI

struct NestedView: View {
	@State var items = [NestedParam]()
	
	@State var textParam: String = ""
	
	var body: some View {
		VStack {
			List($items, children: \.nested) { $item in
				HStack {
					TextField(item.name, text: $item.name)
					TextField(item.value, text: $item.value)
				}
			}
			
			Button {
				update()
			} label: {
				Text("Update")
			}
			
			Button {
				execute()
			} label: {
				Text("EXECUTION")
			}

			
			TextField("Input your text", text: $textParam)
		}
	}
	
	func update() {
		self.items = translate(text: textParam)
	}
	
	func execute() {
		let dict = recursiveNested(items)
		if let theJSONData = try?  JSONSerialization.data(
			withJSONObject: dict,
			options: .prettyPrinted
		),
		   let theJSONText = String(data: theJSONData,
									encoding: String.Encoding.ascii) {
			print("JSON string = \n\(theJSONText)")
		}
	}
	
	func recursiveNested(_ listNested: [NestedParam]?) -> [String: Any]? {
		guard let listNested = listNested else {
			return nil
		}
		
		var dict = [String: Any]()
		for nested in listNested {
			if nested.isPrimative {
				dict[nested.name] = nested.value
				continue
			}
			
			if nested.isArray {
				dict[nested.name] = nested.values
				continue
			}
			
			if let newDict = recursiveNested(nested.nested) {
				dict[nested.name] = newDict
			}
		}
		
		return dict
	}
	
	func translate(text: String) -> [NestedParam] {
		let dict = convertToDictionary(text: text)
		let values = recursiveDict(dict)
		
		
		return values ?? []
	}
	
	func recursiveDict(_ dict: Dictionary<String, Any>?) -> [NestedParam]? {
		guard let dict = dict else {
			return nil
		}
		
		var nestedArray = [NestedParam]()
		let keys = dict.keys
		for key in keys {
			var isPrimativeValue = true
			var nested = [NestedParam]()
			var list = [String]()
			if let newDict = dict[key] as? Dictionary<String, Any> {
				isPrimativeValue = false
				
				if let params = recursiveDict(newDict) {
					nested.append(contentsOf: params)
				}
			}
			
			if let array = dict[key] as? Array<Any> {
				let temp = loopArray(array)
				isPrimativeValue = false
				
				if let params = temp.0 {
					nested.append(contentsOf: params)
				}
				if let params = temp.1 {
					list.append(contentsOf: params)
				}
			}
			
			let value = isPrimativeValue ? "\(dict[key] ?? "")" : ""
			let param = NestedParam(name: key, value: value,
									isPrimative: isPrimativeValue,
									isArray: !isPrimativeValue && nested.isEmpty,
									values: list,
									nested: nested)
			nestedArray.append(param)
		}
		
		return nestedArray
	}
	
	func loopArray(_ array: [Any]?) -> ([NestedParam]?, [String]?) {
		guard let array = array else {
			return (nil, nil)
		}
		
		var items = [NestedParam]()
		var list = [String]()
		for item in array {
			if let value = item as? String {
				list.append(value)
			}
			
			if let newDict = item as? Dictionary<String, Any> {
				if let params = recursiveDict(newDict) {
					items.append(contentsOf: params)
				}
			}
			
			if let array = item as? Array<Any> {
				let temp = loopArray(array)
				if let params = temp.0 {
					items.append(contentsOf: params)
				}
				if let params = temp.1 {
					list.append(contentsOf: params)
				}
			}
		}
		
		return (items, list)
	}
	
	func convertToDictionary(text: String) -> [String: Any]? {
		if let data = text.data(using: .utf8) {
			do {
				return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
			} catch {
				print(error.localizedDescription)
			}
		}
		return nil
	}
}

struct NestedView_Previews: PreviewProvider {
    static var previews: some View {
        NestedView()
    }
}
