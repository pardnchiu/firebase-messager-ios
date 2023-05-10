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

var _black: UIColor = UIColor(named: "Black") ?? .clear;
var _gray: UIColor = UIColor(named: "Gray") ?? .clear;
var _darkGray: UIColor = UIColor(named: "DarkGray") ?? .clear;
var _white: UIColor = UIColor(named: "White") ?? .clear;

class loginVC: UIViewController {

	var bodyStackV: UIStackView!
	var emailTextField: UITextField!
	var passwordTextField: UITextField!

	override func viewDidLoad() {
		super.viewDidLoad();

		bodyStackV = UIStackView(axis: .vert, align: .top);

		emailTextField = UITextField()
			.text(placeholder: "輸入信箱")
			.font(weight: .regular, size: 18)
			.Weq(vw - 120)
			.Heq(30)

		passwordTextField =  UITextField()
			.text(placeholder: "輸入密碼")
			.font(weight: .regular, size: 18)
			.Weq(vw - 120)
			.Heq(30)

		_=view
			.child([
				bodyStackV
					.child([
						UIStackView(axis: .horz, align: .left, fill: .eqSpace)
							.padding(T:  vh / 5)
							.Weq(vw)
							.child([
								UIView(),
								UIStackView(axis: .horz, align: .left, gap: 15)
									.child([
										UIImageView()
											.img(UIImage(name: "logo"), mode: .scaleAspectFit)
											.shadow(color: .black, alpha: 0.2, blur: 3, x: 0, y: 3)
											.Weq(80)
											.Heq(80),
										UIStackView(axis: .vert, align: .top, gap: 3)
											.padding(T: 5)
											.child([
												UILabel()
													.text("Firebase Messager", color: .black, align: .left, row: 1, wrap: .byClipping)
													.font(weight: .regular, size: 16),
												UILabel()
													.text("Firebase 即時訊息", color: .black, align: .left, row: 1, wrap: .byClipping)
													.font(weight: .bold, size: 22),
												UILabel()
													.text("iOS 版本", color: .black, align: .left, row: 1, wrap: .byClipping)
													.font(weight: .regular, size: 18)
											])
									]),
								UIView()
							]),
						UIStackView(axis: .vert, align: .top, gap: 30)
							.padding(T: 40)
							.padding(horz: 60)
							.child([
								emailTextField,
								passwordTextField,
								UIStackView(axis: .horz, align: .left, gap: 30)
									.child([
										UIButton()
											.text("登入", color: .systemBlue)
											.font(weight: .medium, size: 20)
											.bg(color: UIColor(hex: "eee"))
											.Weq((vw - 150) / 2)
											.Heq(35)
											.touch(down: self, #selector(login)),
										UIButton()
											.text("註冊", color: .systemBlue)
											.font(weight: .regular, size: 20)
											.bg(color: UIColor(hex: "eee"))
											.Weq((vw - 150) / 2)
											.Heq(35)
											.touch(down: self, #selector(signup))
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

	override func viewDidAppear(_ animated: Bool) {
		if (Auth.auth().currentUser != nil) {
			let vc = homeVC();
			vc.modalPresentationStyle = .overFullScreen;
			self.present(vc, animated: true)
			return;
		};
	};

	@objc func login() {
		guard let email = emailTextField.text, let password = passwordTextField.text else { return; };

		Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
			if let error = error {
				print(error);
				return;
			};
			present();
		};

		func present() {
			let vc = homeVC();
			vc.modalPresentationStyle = .overFullScreen;
			self.present(vc, animated: true)
		}
	};

	@objc func signup() {
		let vc = signupVC();
		present(vc, animated: true)
	};
};
