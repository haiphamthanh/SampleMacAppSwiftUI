//
//  DataCollectState.swift
//  SampleMacAppSwiftUI
//
//  Created by HaiPham on 25/07/2022.
//

import Foundation

struct Path: Identifiable {
	let id = UUID()
	let location: String
}

class DataCollectState: ObservableObject {
	@Published var listPath = [Path]()
	private var completion: (() -> Void)?
	
	// MARK: ================================= Init =================================
	init(listPath: [Path]) {
		self.listPath = listPath
	}
	
	final func startLoading(on completion: (() -> Void)?) {
		self.completion = completion
		return changeState()
	}
	
}

// MARK: Sample
private extension DataCollectState {
	func changeState() {
		Task {
			await self.changeStateAfter2Seconds()
		}
	}
	
	@MainActor
	private func changeStateAfter2Seconds() async {
		try? await Task.sleep(nanoseconds: 1_000_000_000)
		
		listPath.append(Path(location: "file:///Users/haipham/Desktop/scripts/sample/"))
		if listPath.count > 100 {
			completion?()
			return
		}
		
		return await changeStateAfter2Seconds()
	}
}
