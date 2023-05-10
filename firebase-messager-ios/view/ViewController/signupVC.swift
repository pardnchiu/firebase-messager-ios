//
//  loginVC.swift
//  firebase-messager-ios
//
//  Created by Pardn on 2023/5/9.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

class signupVC: UIViewController {

	var bodyStackV	: UIStackView!
	var headBtn			: UIButton!
	var nameTextF		: UITextField!
	var emailTextF	: UITextField!
	var passwdTextF	: UITextField!
	var checkTextF	: UITextField!

	var ref: DatabaseReference!

	override func viewDidLoad() {
		super.viewDidLoad();

		ref = Database.database().reference();

		bodyStackV = UIStackView(axis: .vert, align: .top);

		headBtn = UIButton()
			.text("選擇頭像", color: _gray)
			.img(UIImage(sys: "person.fill"), align: .left, gap: 5)
			.bg(color: .white)
			.Weq(140)
			.Heq(140)
			.radius(70)
			.clip(view: true)
			.touch(down: self, #selector(presentHeadSelectVC))

		nameTextF = UITextField()
			.text(placeholder: "輸入名稱")
			.font(weight: .regular, size: 18)
			.Weq(vw - 120)
			.Heq(30)

		emailTextF = UITextField()
			.text(placeholder: "輸入信箱")
			.font(weight: .regular, size: 18)
			.Weq(vw - 120)
			.Heq(30)

		passwdTextF = UITextField()
			.text(placeholder: "輸入密碼")
			.font(weight: .regular, size: 18)
			.Weq(vw - 120)
			.Heq(30)

		checkTextF = UITextField()
			.text(placeholder: "確認密碼")
			.font(weight: .regular, size: 18)
			.Weq(vw - 120)
			.Heq(30)

		_=view
			.child([
				UIVisualEffectView(style: .extraLight)
					.frame(0, 0, vw, vh),
				bodyStackV
					.child([
						UIStackView(axis: .horz, align: .left, fill: .eqSpace)
							.padding(T: 60)
							.Weq(vw)
							.child([
								UIView(),
								UIStackView(axis: .horz, align: .left, gap: 15)
									.child([
										headBtn
									]),
								UIView()
							]),
						UIStackView(axis: .vert, align: .top, gap: 30)
							.padding(T: 40)
							.padding(horz: 60)
							.child([
								nameTextF,
								emailTextF,
								passwdTextF,
								checkTextF,
								UIStackView(axis: .horz, align: .left)
									.child([
										UIButton()
											.text("確定註冊", color: .systemBlue)
											.font(weight: .medium, size: 18)
											.bg(color: .white)
											.Weq(vw - 120)
											.Heq(35)
											.touch(down: self, #selector(singup))
									])
							]),
						UIView()
					])
			]);

		_=bodyStackV
			.Teq(T: view)
			.Leq(L: view)
			.Beq(B: view)
			.Req(R: view);
	};

	@objc func presentHeadSelectVC() {
		let vc = headSelectVC();
		present(vc, animated: true);
	};

	@objc func singup() {
		guard
			let name = nameTextF.text,
			let email = emailTextF.text,
			let password = passwdTextF.text,
			let check = checkTextF.text,
			let head = headBtn.configuration?.background.image?.imageAsset?.value(forKey: "assetName")
		else { return; };

		if (check != password) { return; };

		let now = Date();
		let timestamp = "\(now.timeIntervalSince1970)";

		Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
			guard let user = authResult?.user else { return; };
			self.ref.child("users").child(user.uid).setValue([
				"head": head,
				"name": name,
				"signup": timestamp
			]) { (error: Error?, ref: DatabaseReference) in
				if let _ = error { return; };
				self.dismiss(animated: true);
			};
		};
	};
};
