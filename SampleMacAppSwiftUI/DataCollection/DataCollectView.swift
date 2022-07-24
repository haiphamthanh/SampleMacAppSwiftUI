//
//  DataCollectView.swift
//  SampleMacAppSwiftUI
//
//  Created by HaiPham on 24/07/2022.
//

import SwiftUI

struct DataCollectView: View {
	@State private var pathA: String = "file:///Users/haipham/Desktop/scripts/sample/"
	@State private var pathB: String = "file:///Users/haipham/Desktop/scripts/sample/"
	
	@State private var isAnimation: Bool = true
	var foreverAnimation: Animation? {
		!isAnimation ? Animation.linear(duration: 2.0)
			.repeatForever(autoreverses: false) : .default
	}
	
	var body: some View {
		
		VStack {
			// Header
			headerView()
			
			// Content
			contentView()
			
			// Footer
			footerView()
				.frame(maxWidth: .infinity)
		}
		.padding(20)
	}
	
	
	// View builders
	@ViewBuilder
	func headerView() -> some View {
		HStack {
			TextField("Chọn đường dẫn chứa toàn bộ module <... server name ...> ", text: $pathA)
				.disabled(true)
				.foregroundColor(.yellow)
				.textFieldStyle(.roundedBorder)
				.interactiveDismissDisabled()
			
			// Open button.
			Button(action: {
				let selectedUrl = showOpenPanel()
				if let validUrl = validateUrl(selectedUrl) {
					self.pathA = validUrl.absoluteString
				}
			}, label: {
				HStack {
					Image(systemName: "square.and.arrow.up")
					Text("Select")
				}
				.frame(width: 80)
			})
		}
		
		HStack {
			TextField("Chọn đường dẫn chứa scripts <... server name ...> ", text: $pathB)
				.disabled(true)
				.foregroundColor(.yellow)
				.textFieldStyle(.roundedBorder)
				.interactiveDismissDisabled()
			
			// Open button.
			Button(action: {
				let selectedUrl = showOpenPanel()
				if let validUrl = validateUrl(selectedUrl) {
					self.pathB = validUrl.absoluteString
				}
			}, label: {
				HStack {
					Image(systemName: "square.and.arrow.up")
					Text("Select")
				}
				.frame(width: 80)
			})
		}
	}
	
	@ViewBuilder
	func contentView() -> some View {
		
	}
	
	@ViewBuilder
	func footerView() -> some View {
		Button(action: {
			isAnimation.toggle()
			
			// TODO: Do something with opened url
		}, label: {
			HStack {
				ZStack {
					Image(systemName: "gear")
						.rotationEffect(Angle(degrees: self.isAnimation ? 360 : 0.0))
						.animation(foreverAnimation, value: isAnimation)
						.offset(x: -13, y: 0)
					Image(systemName: "gear")
						.rotationEffect(Angle(degrees: self.isAnimation ? 0 : 360.0))
						.animation(foreverAnimation, value: isAnimation)
						.offset(x: 0, y: -6)
					Image(systemName: "gear")
						.rotationEffect(Angle(degrees: self.isAnimation ? 360 : 0.0))
						.animation(foreverAnimation, value: isAnimation)
						.offset(x: 0, y: 7)
				}
				.padding(.top, 0)
				
				Text("START COLLECTING")
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.frame(alignment: .center)
			}
		})
		.frame(maxWidth: 200, maxHeight: 50)
	}
	
	// Functions
	func showOpenPanel() -> URL? {
		let openPanel = NSOpenPanel()
		openPanel.canChooseDirectories = true
		openPanel.allowsMultipleSelection = false
		openPanel.canChooseFiles = false
		let response = openPanel.runModal()
		return response == .OK ? openPanel.url : nil
	}
	
	func validateUrl(_ url: URL?) -> URL? {
		guard let url = url else {
			return nil
		}
		
		// TODO: Valid url if content <... server name ...> folders
		return url
	}
}

struct DataCollectView_Previews: PreviewProvider {
	static var previews: some View {
		DataCollectView()
	}
}

extension View {
	func withoutAnimation() -> some View {
		self.animation(nil, value: UUID())
	}
}
