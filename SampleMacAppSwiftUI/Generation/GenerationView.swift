//
//  GenerationView.swift
//  SampleMacAppSwiftUI
//
//  Created by HaiPham on 24/07/2022.
//

import SwiftUI

struct GenerationView: View {
	@State private var path: String = ""
	
	var body: some View {
		VStack {
			VStack {
				// Header
				headerView()
				
				// Content
				contentView()
				
				// Footer
				footerView()
			}
			.padding(20)
		}
	}
	
	
	// View builders
	@ViewBuilder
	func headerView() -> some View {
		HStack {
			TextField("Chọn đường dẫn chứa file ", text: $path)
			
			// Open button.
			Button(action: {
				let openURL = showOpenPanel()
				// Do something with opened url
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
			// Do something with opened url
		}, label: {
			HStack {
				Image(systemName: "figure.run")
				Text("RUN")
			}
			.frame(width: 80)
		})
	}

	// Functions
	func showOpenPanel() -> URL? {
		let openPanel = NSOpenPanel()
		openPanel.allowsMultipleSelection = false
		openPanel.canChooseDirectories = false
		openPanel.canChooseFiles = true
		let response = openPanel.runModal()
		return response == .OK ? openPanel.url : nil
	}
}

struct GenerationView_Previews: PreviewProvider {
	static var previews: some View {
		GenerationView()
	}
}
