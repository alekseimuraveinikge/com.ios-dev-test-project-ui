import UIKit
import Photos

class ShareViewController: UIViewController {
	private let gif: Gif
	private var rootView: ShareView { view as! ShareView }
	
	init(gif: Gif) {
		self.gif = gif
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		self.view = ShareView()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		rootView.dismissButton.addTarget(
			self,
			action: #selector(didTapDismiss),
			for: .touchUpInside
		)
		
		rootView.exportButton.addTarget(
			self,
			action: #selector(didTapExport),
			for: .touchUpInside
		)
		
		rootView.copyLinkButton.addTarget(
			self,
			action: #selector(didTapCopyLink),
			for: .touchUpInside
		)
		
		rootView.imageView.setGifFromURL(
			gif.images.original.url,
			showLoader: false
		)
	}
	
	@objc private func didTapDismiss() {
		dismiss(animated: true)
	}
	
	@objc private func didTapExport() {
		DispatchQueue.global(qos: .userInitiated).async { [gif] in
			guard let data = try? Data(contentsOf: gif.images.original.url) else {
				return
			}
			
			PHPhotoLibrary.shared().performChanges {
				PHAssetCreationRequest.forAsset().addResource(
					with: .photo,
					data: data,
					options: nil
				)
			} completionHandler: { success, _ in
				if success {
					DispatchQueue.main.async {
						self.present(
							makeAlert(title: "Image was saved to your photo library"),
							animated: true
						)
					}
				}
			}
		}
	}
	
	@objc private func didTapCopyLink() {
		UIPasteboard.general.string = gif.images.original.url.absoluteString
		present(
			makeAlert(title: "Link copied!"),
			animated: true
		)
	}
}


private func makeAlert(title: String) -> UIAlertController {
	let alert = UIAlertController(
		title: title,
		message: nil,
		preferredStyle: .alert
	)
	alert.addAction(.init(title: "OK", style: .cancel, handler: nil))
	return alert
}
