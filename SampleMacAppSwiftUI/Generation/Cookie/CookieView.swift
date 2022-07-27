//
//  CookieView.swift
//  SampleMacAppSwiftUI
//
//  Created by HaiPham on 27/07/2022.
//

import SwiftUI

struct CookieView: View {
	@ObservedObject var state: CookieState
	@Environment(\.colorScheme) private var colorScheme
	@State private var path: String = ""
	
	@State var showStoreDropDown: Bool = false
	@State var showTimeframeDropDown: Bool = false
	let gradient = LinearGradient(gradient: Gradient(colors: [.orange, .green]),
								  startPoint: .topLeading,
								  endPoint: .bottomTrailing)
	
	var body: some View {
		VStack {
			VStack {
				// Header
				headerView()
				
				HStack {
					
					// Content
					contentView()
					
					// Footer
					righSideMenu()
				}
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
	func righSideMenu() -> some View {
		VStack(spacing: 40) {
			Button(action: {
				withAnimation(.easeInOut(duration: 4)) {
				}
			}, label: {
				HStack {
					Text("CREATE")
						.frame(maxWidth: .infinity, maxHeight: .infinity)
						.frame(alignment: .center)
				}
			})
			.buttonStyle(NeumorphicButtonStyle(colorScheme: colorScheme))
			.frame(maxWidth: 150, maxHeight: 50)
			
			Button(action: {
				withAnimation(.easeInOut(duration: 4)) {
				}
			}, label: {
				HStack {
					Text("RUN")
						.frame(maxWidth: .infinity, maxHeight: .infinity)
						.frame(alignment: .center)
				}
			})
			.buttonStyle(NeumorphicButtonStyle(colorScheme: colorScheme))
			.frame(maxWidth: 150, maxHeight: 50)
		}
	}
	
	
	
	@ViewBuilder
	func contentView() -> some View {
		HStack {
			VStack {
				Menu {
					Button {
						print("Select 1")
					} label: {
						Text("Platform A")
						Image(systemName: "arrow.down.right.circle")
					}
					Button {
						print("Platform B")
					} label: {
						Text("Radial")
						Image(systemName: "arrow.up.and.down.circle")
					}
				} label: {
					Text("Chọn Platform")
					Image(systemName: "tag.circle")
				}
				
				sampleABC()
			}
			
			
			VStack {
				
				sampleABC()
				
				sampleABC()
			}
		}
	}
	
	@ViewBuilder
	func sampleABC() -> some View {
		VStack {
			Text("")
				.background(
					Rectangle()
						.stroke(gradient, lineWidth: 2)
						.saturation(1.8)
				)
		}
	}
}

struct CookieView_Previews: PreviewProvider {
	static var previews: some View {
		let state = CookieState()
		CookieView(state: state)
	}
}
