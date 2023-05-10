//
//  headSelectorViewController.swift
//  firebase-messager-ios
//
//  Created by Pardn on 2023/5/8.
//

import Foundation
import UIKit

class headSelectVC: UIViewController {

	let heads: [String] = [
		"01", "3DDD-1", "3DDD-2", "3DDD-3", "3DDD-4", "3DDD",
		"Afterclap-1", "Afterclap-2", "Afterclap-3", "Afterclap-4",
		"Afterclap-5", "Afterclap-6", "Afterclap-7", "Afterclap-8",
		"Afterclap-9", "Afterclap", "Cranks-1", "Cranks-2", "Cranks",
		"Delivery boy-1", "Delivery boy-2", "Delivery boy-3", "Delivery boy-4",
		"Delivery boy-5", "Delivery boy", "E-commerce-1", "E-commerce-2", "E-commerce",
		"Funny Bunny-1", "Funny Bunny-2", "Funny Bunny-3", "Funny Bunny-4",
		"Funny Bunny-5", "Funny Bunny-6", "Funny Bunny-7", "Funny Bunny-8",
		"Funny Bunny", "Guacamole-1", "Guacamole-2", "Guacamole-3", "Guacamole",
		"Juicy-1", "Juicy", "No comments 3", "No comments 4", "No comments 5",
		"No comments 6", "No comments 7", "No comments 8", "No comments 9", "No Comments-1",
		"No Comments-2", "No Comments-3", "No Comments", "No gravity-1", "No gravity-2",
		"No gravity-3", "No gravity", "OSLO-1", "OSLO-2", "OSLO-3", "OSLO-4",
		"OSLO-5", "OSLO-6", "OSLO-7", "OSLO-8", "OSLO-9", "OSLO-10", "OSLO-11",
		"OSLO-12", "OSLO-13", "OSLO-14", "OSLO", "Teamwork-1", "Teamwork-2", "Teamwork-3",
		"Teamwork-4", "Teamwork-5", "Teamwork-6", "Teamwork-7", "Teamwork-8", "Teamwork",
		"Upstream-1", "Upstream-2", "Upstream-3", "Upstream-4", "Upstream-5", "Upstream-6",
		"Upstream-7", "Upstream-8", "Upstream-9", "Upstream-10", "Upstream-11", "Upstream-12",
		"Upstream-13", "Upstream-14", "Upstream-15", "Upstream-16", "Upstream-17", "Upstream"
	];

	var grid: UICollectionView!

	override func viewDidLoad() {
		super.viewDidLoad();

		let isDark = traitCollection.userInterfaceStyle == .dark;

		let gridLayout = UICollectionViewFlowLayout()._ { e in
			let width: CGFloat = CGFloat(vw / 3)
			e.minimumLineSpacing = 0;
			e.minimumInteritemSpacing = 0;
			e.scrollDirection = .vertical;
			e.estimatedItemSize = CGSize(width, width);
		};

		grid = UICollectionView(0, 0, vw, vh, gridLayout)
			.proto(self, self)
			.cell(headCollVCell.self, "headCollectionViewCell")
			.bg(color: .clear);

		grid.allowsFocus = true;

		_=view
			.child([
				UIVisualEffectView(style: isDark ? .dark : .extraLight)
					.frame(0, 0, vw, vh),
				grid
			]);
	};

	override func viewDidAppear(_ animated: Bool) {
		_=grid
			.Teq(T: view)
			.Leq(L: view)
			.Beq(B: view)
			.Req(R: view)
	}

	@objc func closeSelector(_ sender: UIButton) {
		let name = sender.configuration?.background.image?.imageAsset?.value(forKey: "assetName") as? String ?? "";
		print(name)
		if let presenter = presentingViewController as? signupVC {
			_=presenter.headBtn
				.bg(image: UIImage(name: name), mode: .scaleAspectFit)
		}
		self.dismiss(animated: true)
	}
};

extension headSelectVC: UICollectionViewDelegate, UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return heads.count;
	};

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(vw / 3, vw / 3);
	};

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.cell(reuse: "headCollectionViewCell", indexPath) as? headCollVCell else { return UICollectionViewCell(); };
		let data: String = heads[indexPath.row];
		_=cell.headBtn
			.bg(image: UIImage(name: data), mode: .scaleAspectFit)
			.touch(down: self, #selector(closeSelector));
		return cell;
	};
};


