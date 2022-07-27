import UIKit
import CHTCollectionViewWaterfallLayout

class MainView: UIView {
	let collectionView: UICollectionView = {
		let layout = CHTCollectionViewWaterfallLayout()
		layout.itemRenderDirection = .leftToRight
		layout.columnCount = 2
		layout.minimumColumnSpacing = 8
		
		let collectionView = UICollectionView(
			frame: .zero,
			collectionViewLayout: layout
		)
		collectionView.register(
			ImageCell.self,
			forCellWithReuseIdentifier: ImageCell.identifier
		)
		
		return collectionView
	}()
	
	init() {
		super.init(frame: .zero)
		
		backgroundColor = .black
		collectionView.backgroundColor = .clear
		
		setupLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupLayout() {
		addSubview(collectionView)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
			collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
		])
	}
}
