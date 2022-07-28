//
//  CommandView.swift
//  SampleMacAppSwiftUI
//
//  Created by HaiPham on 28/07/2022.
//
// https://stackoverflow.com/questions/70981389/how-to-center-a-scrollable-text-in-swiftui

import SwiftUI

struct CommandView: View {
	@ObservedObject var state: CommandState
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
	
	@ViewBuilder
	func contentView() -> some View {
		ScrollView {
			Text(state.log)
				.font(.system(size: 12, weight: .light))
		}
		.background(
			Rectangle()
				.stroke(gradient, lineWidth: 2)
				.saturation(1.8)
		)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
	
	@ViewBuilder
	func righSideMenu() -> some View {
		VStack(spacing: 40) {
			Button(action: {
				withAnimation(.easeInOut(duration: 0.2)) {
					state.runCmd()
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
			
			Button(action: {
				withAnimation(.easeInOut(duration: 0.2)) {
					state.runCmd()
				}
			}, label: {
				HStack {
					Text("EXPORT")
						.frame(maxWidth: .infinity, maxHeight: .infinity)
						.frame(alignment: .center)
				}
			})
			.buttonStyle(NeumorphicButtonStyle(colorScheme: colorScheme))
			.frame(maxWidth: 150, maxHeight: 50)
		}
	}
}


struct CommandView_Previews: PreviewProvider {
	static var previews: some View {
		
		let state = CommandState()
		CommandView(state: state)
	}
}


class CommandState: ObservableObject {
	@Published var log: String = ""
	private var completion: (() -> Void)?
	
	// MARK: ================================= Init =================================
	init() {
	}
	
	final func startLoading(on completion: (() -> Void)?) {
		self.completion = completion
		return changeState()
	}
	
	func runCmd() {
		let command = "sh /Users/haipham/Desktop/Testing/scripts/run.sh"
		DispatchQueue.global().async {
			let cmdContent = self.shell(command)
			DispatchQueue.main.async {
				self.log = cmdContent
			}
		}
	}
	
	func shell(_ command: String) -> String {
		let task = Process()
		let pipe = Pipe()
		
		task.standardOutput = pipe
		task.standardError = pipe
		task.arguments = ["-c", command]
		task.launchPath = "/bin/zsh"
		task.standardInput = nil
		task.launch()
		
		let data = pipe.fileHandleForReading.readDataToEndOfFile()
		let output = String(data: data, encoding: .utf8)!
		
		return output
	}
	
}

// MARK: Sample
private extension CommandState {
	func changeState() {
		Task {
			await self.changeStateAfter2Seconds()
		}
	}
	
	@MainActor
	private func changeStateAfter2Seconds() async {
		try? await Task.sleep(nanoseconds: 1_000_000_000)
		
//		listPath.append(Path(location: "file:///Users/haipham/Desktop/scripts/sample/"))
//		if listPath.count > 100 {
//			completion?()
//			return
//		}
		
		return await changeStateAfter2Seconds()
	}
}
