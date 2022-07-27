//
//  CookieState.swift
//  SampleMacAppSwiftUI
//
//  Created by HaiPham on 27/07/2022.
//

import WebKit

struct Cookie {
	let b_cookie: String
	let y_cookie: String
	let t_cookie: String
	let n_cookie: String
}

class CookieState: ObservableObject {
	@Published var listCookie = [Cookie]()
	private var completion: (() -> Void)?
	
	// MARK: ================================= Init =================================
	init() {
		var listCookie = [Cookie]()
		
		
		self.listCookie = listCookie
	}
	
	final func startLoading(on completion: (() -> Void)?) {
		self.completion = completion
		return changeState()
	}
	
	final func translateToGet(body: String) {
		
	}
	
	final func translateToPost(body: String) {
		
	}
}

// MARK: Sample
private extension CookieState {
	func changeState() {
		//		Task {
		//			await self.changeStateAfter2Seconds()
		//		}
	}
	//
	//	@MainActor
	//	private func changeStateAfter2Seconds() async {
	//		try? await Task.sleep(nanoseconds: 1_000_000_000)
	//
	//		listPath.append(Path(location: "file:///Users/haipham/Desktop/scripts/sample/"))
	//		if listPath.count > 100 {
	//			completion?()
	//			return
	//		}
	//
	//		return await changeStateAfter2Seconds()
	//	}
}
