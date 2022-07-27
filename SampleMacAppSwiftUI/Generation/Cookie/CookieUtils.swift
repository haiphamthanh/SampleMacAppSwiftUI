//
//  CookieUtils.swift
//  SampleMacAppSwiftUI
//
//  Created by HaiPham on 27/07/2022.
//

import SwiftUI
import WebKit
import Combine

class WebViewData: ObservableObject {
	@Published var loading: Bool = false
	@Published var url: URL?;
	
	init (url: URL) {
		self.url = url
	}
}

@available(OSX 11.0, *)
struct WebView: NSViewRepresentable {
	@ObservedObject var data: WebViewData
	var webView: WKWebView?
	
	func makeNSView(context: Context) -> WKWebView {
		return context.coordinator.webView
	}
	
	func updateNSView(_ nsView: WKWebView, context: Context) {
		
		guard context.coordinator.loadedUrl != data.url else { return }
		context.coordinator.loadedUrl = data.url
		
		if let url = data.url {
			DispatchQueue.main.async {
				let request = URLRequest(url: url)
				nsView.load(request)
			}
		}
		
		context.coordinator.data.url = data.url
	}
	
	func makeCoordinator() -> WebViewCoordinator {
		let coor = WebViewCoordinator(data: data)
		return coor
	}
}

@available(OSX 11.0, *)
class WebViewCoordinator: NSObject, WKNavigationDelegate {
	@ObservedObject var data: WebViewData
	
	var webView: WKWebView = WKWebView()
	var loadedUrl: URL? = nil
	
	init(data: WebViewData) {
		self.data = data
		
		super.init()
		
		webView.navigationDelegate = self
	}
	
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		DispatchQueue.main.async {
			self.data.loading = false
			self.webView.getCookies() { data in
				  print("=========================================")
//				  print("\(url.absoluteString)")
				  print(data)
			}
		}
	}
	
	func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
		DispatchQueue.main.async { self.data.loading = true }
	}
	
	func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
		showError(title: "Navigation Error", message: error.localizedDescription)
		DispatchQueue.main.async { self.data.loading = false }
	}
	
	func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
		showError(title: "Loading Error", message: error.localizedDescription)
		DispatchQueue.main.async { self.data.loading = false }
	}
	
	
	func showError(title: String, message: String) {
#if os(macOS)
		let alert: NSAlert = NSAlert()
		
		alert.messageText = title
		alert.informativeText = message
		alert.alertStyle = .warning
		
		alert.runModal()
#else
		print("\(title): \(message)")
#endif
	}
}

extension WKWebView {
	
	private var httpCookieStore: WKHTTPCookieStore  { return WKWebsiteDataStore.default().httpCookieStore }
	
	func getCookies(for domain: String? = nil, completion: @escaping ([String : Any])->())  {
		var cookieDict = [String : AnyObject]()
		httpCookieStore.getAllCookies { cookies in
			for cookie in cookies {
				if let domain = domain {
					if cookie.domain.contains(domain) {
						cookieDict[cookie.name] = cookie.properties as AnyObject?
					}
				} else {
					cookieDict[cookie.name] = cookie.properties as AnyObject?
				}
			}
			completion(cookieDict)
		}
	}
}




//var body: some View {
////		WebView(data: WebViewData(url: self.bundleURL(fileName: "index", fileExtension: "html")))
//	   WebView(data: WebViewData())
//   }
//   
//   
//   func bundleURL(fileName: String, fileExtension: String) -> URL {
//	   if let fileURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension, subdirectory: "www") {
//		   return fileURL
//	   } else {
//		   print("File not found")
//		   return URL(string: "")!
//	   }
//   }
