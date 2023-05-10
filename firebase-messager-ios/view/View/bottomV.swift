//
//  bottomView.swift
//  firebase-messager-ios
//
//  Created by Pardn on 2023/5/8.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseAuth

class bottomV: UIView {

	var root: homeVC!
	var body: UIStackView!
	var btn_qrcode	: UIButton!
	var btn_mode		: UIButton!
	var btn_logout	: UIButton!
	var btn_scanner	: UIButton!
	var btn_ban			: UIButton!
	var btn_unknow	: UIButton!
	var btn_archieve: UIButton!
	var btn_license	: UIButton!

	enum __target {
		case account;
		case friends;
		case chats;
		case about;
	};

	convenience init(target: homeVC, show: __target) {
		self.init();

		_=bg(color: _white)

		root = target;

		btn_qrcode = UIButton()
			.text(color: _black)
			.img(UIImage(sys: "qrcode"))
			.bg(color: _gray)
			.radius(20)
			.Weq(40)
			.Heq(40)
			.touch(down: self, #selector(showQrcodeViewController));

		btn_mode = UIButton()
			.text(color: _black)
			.img(UIImage(sys: "moon.circle"))
			.bg(color: _gray)
			.radius(20)
			.Weq(40)
			.Heq(40)
			.touch(down: self, #selector(changeMode));

		btn_logout = UIButton()
			.text(color: _black)
			.img(UIImage(sys: "rectangle.portrait.and.arrow.right"))
			.bg(color: _gray)
			.radius(20)
			.Weq(40)
			.Heq(40)
			.touch(down: self, #selector(logout));

		btn_scanner = UIButton()
			.text(color: _black)
			.img(UIImage(sys: "qrcode.viewfinder"))
			.bg(color: _gray)
			.radius(20)
			.Weq(40)
			.Heq(40)
			.touch(down: self, #selector(openScannerVC));

		btn_ban = UIButton()
			.text(color: _black)
			.img(UIImage(sys: "person.2.slash"))
			.bg(color: _gray)
			.radius(20)
			.Weq(40)
			.Heq(40);

		btn_unknow = UIButton()
			.text(color: _black)
			.img(UIImage(sys: "person.wave.2"))
			.bg(color: _gray)
			.radius(20)
			.Weq(40)
			.Heq(40);

		btn_archieve = UIButton()
			.text(color: _black)
			.img(UIImage(sys: "archivebox"))
			.bg(color: _gray)
			.radius(20)
			.Weq(40)
			.Heq(40);

		btn_license = UIButton()
			.text(color: _black)
			.img(UIImage(sys: "l.circle"))
			.bg(color: _gray)
			.radius(20)
			.Weq(40)
			.Heq(40);

		body = UIStackView(axis: .horz, align: .center, fill: .eqSpace, gap: 30)

		_=self
			.child([
				body
					.child([
						btn_scanner,
						btn_ban
					])
					.Heq(60)
			])
			.layer([
				CALayer()._ { e in
					e.frame = CGRect(0, 0, vw, 1);
					e.backgroundColor = _gray.cgColor;
				}
			])
			.clip(view: true)

		_=body
			.Xeq(X: self)
			.Yeq(Y: self);
	};

	func change(to: __target) {
		body.subviews.forEach { e in
			e.removeFromSuperview();
		};
		switch to {
			case .account:
				_=body
					.child([
						btn_qrcode,
						btn_mode,
						btn_logout
					]);
				break;
			case .friends:
				_=body
					.child([
						btn_scanner,
						btn_ban
					]);
				break;
			case .chats:
				_=body
					.child([
						btn_unknow,
						btn_archieve
					]);
				break;
			case .about:
				_=body
					.child([
						btn_license,
					]);
				break;
		}
	};

	@objc func showQrcodeViewController() {
		let vc = qrcodeVC();
		guard let _ = root.presentedViewController else {
			root.present(vc, animated: true);
			return;
		};
	};

	@objc func openScannerVC() {
		let vc = scannerVC();
		guard let _ = root.presentedViewController else {
			root.present(vc, animated: true);
			return;
		};
	};

	var isDark: Bool = false;
	@objc func changeMode() {
		let isDark = window?.traitCollection.userInterfaceStyle == .dark;
		window?.overrideUserInterfaceStyle = isDark ? .light : .dark
	};

	@objc func logout() {
		let firebaseAuth = Auth.auth()
		do {
			try firebaseAuth.signOut()
		} catch let signOutError as NSError {
			print("Error signing out: %@", signOutError)
		}
		root.dismiss(animated: true);
	};
};
