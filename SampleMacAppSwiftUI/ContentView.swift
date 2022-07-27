//
//  ContentView.swift
//  SampleMacAppSwiftUI
//
//  Created by HaiPham on 24/07/2022.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		NavigationView {
			VStack(spacing: 30) {
				NavigationLink(destination: GenerationView(state: DataCollectState(listPath: []))) {
					Text("Monitoring data")
				}
				
				NavigationLink(destination: DataCollectView(state: DataCollectState(listPath: []))) {
					Text("Collect data")
				}
				
				NavigationLink(destination: CookieView(state: CookieState())) {
					Text("Webview")
				}
			}
			.navigationTitle("Navigation")
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
