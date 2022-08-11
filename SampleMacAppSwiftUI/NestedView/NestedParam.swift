//
//  NestedParam.swift
//  SampleAppMac
//
//  Created by HaiPham on 11/08/2022.
//

import Foundation

struct NestedParam: Identifiable {
	let id = UUID()
	var name: String
	var value: String
	var isPrimative: Bool
	var isArray: Bool
	var values: [String]
	var nested: [NestedParam]?
}
