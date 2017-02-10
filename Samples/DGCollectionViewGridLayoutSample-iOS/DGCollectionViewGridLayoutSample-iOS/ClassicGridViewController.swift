//
//  ClassicGridViewController.swift
//  DGCollectionViewGridLayoutSample-iOS
//
//  Created by Julien Sarazin on 16/01/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import UIKit
import DGCollectionViewGridLayout

class ClassicGridViewController: OriginalViewController {
	var control = UIRefreshControl()
	var itemCount = 100

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		self.configureLayout()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func configureLayout() {
		let layout = DGCollectionViewGridLayout()
		layout.lineSpacing = 10
		layout.columnSpacing = 10
		layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

		self.collectionView.collectionViewLayout = layout
		self.collectionView.delegate = self
		self.collectionView.dataSource = self
		if #available(iOS 10.0, *) {
			self.control.addTarget(self, action: #selector(reloadData), for: UIControlEvents.allEvents)
			self.collectionView.refreshControl = control

		} else {
			// Fallback on earlier versions
		}
	}

	func reloadData() {
		self.itemCount = 0
		DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
			self.collectionView.reloadData()
			self.control.endRefreshing()
		})
	}
}

extension ClassicGridViewController: DGCollectionViewGridLayoutDelegate {
	func collectionView(_ collectionView: UICollectionView,
	                    layout collectionViewLayout: DGCollectionViewGridLayout,
	                    heightForItemAt indexPath: IndexPath, columnWidth: CGFloat) -> CGFloat {
		return 80
	}
}

extension ClassicGridViewController: DGCollectionViewGridLayoutDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 3
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return itemCount

	}

	func numberOfColumns(in collectionView: UICollectionView) -> Int {
		return 3
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PathCell.Identifier, for: indexPath) as? PathCell
		cell?.set(indexPath: indexPath)
		return cell!
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print("did selected item at: \(indexPath)")
	}
}
