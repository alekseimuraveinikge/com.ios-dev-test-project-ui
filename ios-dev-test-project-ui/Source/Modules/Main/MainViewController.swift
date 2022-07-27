import UIKit
import CHTCollectionViewWaterfallLayout

class MainViewController: UIViewController {
	private let networkService: NetworkService
	private var rootView: MainView { view as! MainView }
	
	private var gifs: [Gif] = [] {
		didSet {
			if oldValue.isEmpty {
				rootView.collectionView.reloadData()
				return
			}
			
			rootView.collectionView.insertItems(
				at: (oldValue.count..<gifs.count).map {
					IndexPath(row: $0, section: 0)
				}
			)
		}
	}
	
	init(networkService: NetworkService) {
		self.networkService = networkService
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		self.view = MainView()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		rootView.collectionView.dataSource = self
		rootView.collectionView.delegate = self
		
		networkService.loadTrending { trending in
			DispatchQueue.main.async {
				self.gifs += trending.data
			}
		}
	}
}


// MARK: UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
	func collectionView(
		_ collectionView: UICollectionView,
		numberOfItemsInSection section: Int
	) -> Int {
		gifs.count
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		let cell = rootView.collectionView.dequeueReusableCell(
			withReuseIdentifier: ImageCell.identifier,
			for: indexPath
		)
		
		guard let imageCell = cell as? ImageCell else {
			assertionFailure("Unable to cast cell ti ImageCell")
			return UICollectionViewCell()
		}
		
		imageCell.configure(gif: gifs[indexPath.row])
		return imageCell
	}
}


// MARK: UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
	func collectionView(
		_ collectionView: UICollectionView,
		didSelectItemAt indexPath: IndexPath
	) {
		let gif = gifs[indexPath.row]
		let controller = ShareViewController(gif: gif)
		controller.modalPresentationStyle = .fullScreen
		present(controller, animated: true)
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumInteritemSpacingFor section: Int
	) -> CGFloat {
		8
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		willDisplay cell: UICollectionViewCell,
		forItemAt indexPath: IndexPath
	) {
		if indexPath.row == gifs.count - 1 {
			networkService.loadTrending(offset: gifs.count) { trending in
				DispatchQueue.main.async {
					self.gifs += trending.data
				}
			}
		}
	}
}


// MARK: CHTCollectionViewDelegateWaterfallLayout
extension MainViewController: CHTCollectionViewDelegateWaterfallLayout {
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		CGSize(
			width: cellWidth,
			height: gifs[indexPath.row].images.fixedWidth.height
		)
	}
}


private let screenWidth = UIScreen.main.bounds.width
private let cellWidth = (screenWidth - 8) / 2
private let heightCoefficient = cellWidth / 200
