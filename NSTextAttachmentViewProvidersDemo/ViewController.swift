//
//  ViewController.swift
//  NSTextAttachmentViewProvidersDemo
//
//  Created by Zachary Drayer on 9/5/21.
//

import UIKit

class SomeView: UIView {
	func animate() {
		UIView.animate(withDuration: 1.0) {
			self.alpha = 0.0
			self.transform = .identity.rotated(by: 360.0)
		} completion: { _ in
			self.reset()
		}
	}

	func reset() {
		UIView.animate(withDuration: 1.0) {
			self.alpha = 1.0
			self.transform = .identity
		} completion: { _ in
			self.animate()
		}
	}
}

// MARK: -

class SomeNSTextAttachmentViewProvider : NSTextAttachmentViewProvider {
	override func loadView() {
		view = SomeView()
		view?.backgroundColor = .purple
		(view as? SomeView)?.animate()
	}
}

// MARK: -

class ViewController: UIViewController {
	@IBOutlet var textView: UITextView?

	override func viewDidLoad() {
		super.viewDidLoad()

		NSTextAttachment.registerViewProviderClass(SomeNSTextAttachmentViewProvider.self, forFileType: "public.data")

		let demo = NSMutableAttributedString()
		demo.append(NSAttributedString("purple box: "))
		demo.append(NSAttributedString(attachment: NSTextAttachment(data: nil, ofType: "public.data")))
		textView?.attributedText = demo
	}
}
