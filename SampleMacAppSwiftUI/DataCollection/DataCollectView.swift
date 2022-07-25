//
//  DataCollectView.swift
//  SampleMacAppSwiftUI
//
//  Created by HaiPham on 24/07/2022.
//

import SwiftUI

struct DataCollectView: View {
	@ObservedObject var state: DataCollectState
	
	@State private var pathA: String = "file:///Users/haipham/Desktop/scripts/sample/"
	@State private var pathB: String = "file:///Users/haipham/Desktop/scripts/sample/"
	
	@State private var isAnimation: Bool = true
	let gradient = LinearGradient(gradient: Gradient(colors: [.orange, .green]),
								  startPoint: .topLeading,
								  endPoint: .bottomTrailing)
	@Environment(\.colorScheme) private var colorScheme
	var foreverAnimation: Animation? {
		!isAnimation ? Animation.linear(duration: 2.0).repeatForever(autoreverses: false) : .default
	}
	var foreverAnimationA: Animation? {
		!isAnimation ? Animation.easeInOut(duration: 5.0).repeatForever(autoreverses: true) : .default
	}
	
	@State private var startAnimation: Bool = false
	
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
		VStack {
			ZStack(alignment: .center) {
				Text("PROCESS DATA")
					.frame(maxWidth: 100)
					.padding(8)
					.background(Capsule()
						.stroke(gradient, lineWidth: 2)
						.saturation(1.8))
				Image(systemName: "fanblades")
					.rotationEffect(Angle(degrees: self.isAnimation ? 360.0 : 0))
					.animation(foreverAnimation, value: isAnimation)
					.font(.system(size: 40, weight: .light))
					.offset(x: 80, y: 0)
					.foregroundColor(.yellow)
				
				Text("🚟")
					.font(.custom("Arial", size: 50))
					.offset(x: self.isAnimation ? -500 : -85)
					.animation(foreverAnimationA, value: isAnimation)
			}
			
			ScrollView {
				LazyVStack(alignment: .leading, spacing: 4) {
					ForEach(state.listPath) { path in
						Text(path.location)
						Divider()
					}
				}
			}
			.background(
				Rectangle()
					.stroke(gradient, lineWidth: 2)
					.saturation(1.8)
			)
		}
	}
	
	@ViewBuilder
	func footerView() -> some View {
		ZStack(alignment: .center) {
			HStack {
				Spacer()
				
				Button(action: {
					withAnimation(.easeInOut(duration: 4)) {
						isAnimation.toggle()
						state.startLoading {
							isAnimation.toggle()
							print("Action Completed...!")
						}
					}
				}, label: {
					HStack {
						Text("START COLLECTING")
							.frame(maxWidth: .infinity, maxHeight: .infinity)
							.frame(alignment: .center)
					}
				})
				.buttonStyle(NeumorphicButtonStyle(colorScheme: colorScheme))
				.frame(maxWidth: 220, maxHeight: 50)
				Spacer()
			}
			
			
			Group {
				Image(systemName: "gear")
					.rotationEffect(Angle(degrees: self.isAnimation ? 360 : 0.0))
					.animation(foreverAnimation, value: isAnimation)
					.font(.system(size: 30))
					.offset(x: -27, y: 0)
					.foregroundColor(.blue)
				Image(systemName: "gear")
					.rotationEffect(Angle(degrees: self.isAnimation ? 0 : 360.0))
					.animation(foreverAnimation, value: isAnimation)
					.font(.system(size: 26))
					.offset(x: -8, y: -9)
					.foregroundColor(.yellow)
				Image(systemName: "gear")
					.rotationEffect(Angle(degrees: self.isAnimation ? 360 : 0.0))
					.animation(foreverAnimation, value: isAnimation)
					.font(.system(size: 22))
					.offset(x: 0, y: 6)
					.foregroundColor(.red)
			}
			.padding(.leading, -100)
		}
		.frame(height: 100)
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
		let state = DataCollectState(listPath: [])
		DataCollectView(state: state)
	}
}
