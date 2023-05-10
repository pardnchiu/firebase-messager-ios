/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation
import UIKit

class accountV: UIScrollView {
	
	var rootVC			: homeVC!
	var headerLbl		: UILabel!
	var bodyStackV	: UIStackView!
	var headBtn			: UIButton!
	var nameTextF		: UITextField!
	var emailTextF	: UITextField!
	var passwdTextF	: UITextField!
	
	convenience init(rootVC: homeVC) {
		self.init();
		
		self.rootVC = rootVC;
		
		headerLbl = UILabel(15, 0, vw - 40, 100)
			.attr(txt: "帳戶", clr: _black, align: .left)
			.attr(minH: 90)
			.font(weight: .medium, size: 40)
			.bg(color: _white);
		
		bodyStackV = UIStackView(axis: .vert, align: .left, gap: 30)
			.padding(T: 130)
			.padding(L: 15);
		
		headBtn = UIButton()
			.bg(image: nil, mode: .scaleAspectFill)
			.bg(color: _gray)
			.Weq(160)
			.Heq(160)
			.radius(80)
			.clip(view: true)
			.touch(down: self, #selector(presentHeadSelectVC));
		
		nameTextF = UITextField()
			.view(left:  UIView(0, 0, 15, 30), mode: .always)
			.bg(color: _gray)
			.Weq(vw - 70)
			.Heq(30)
			.radius(5);
		
		emailTextF = UITextField()
			.view(left:  UIView(0, 0, 15, 30), mode: .always)
			.bg(color: _gray)
			.Weq(vw - 70)
			.Heq(30)
			.radius(5);
		
		passwdTextF = UITextField()
			.view(left:  UIView(0, 0, 15, 30), mode: .always)
			.bg(color: _gray)
			.Weq(vw - 70)
			.Heq(30)
			.radius(5);
		
		_=child([
			bodyStackV
				.child([
					headBtn,
					UIStackView(axis: .vert, align: .left, gap: 10)
						.child([
							UILabel()
								.text("名稱", color: _black, align: .left, row: 1, wrap: .byClipping)
								.font(weight: .medium, size: 18)
								.Weq(vw - 70)
								.Heq(20),
							nameTextF
						]),
					UIStackView(axis: .vert, align: .left, gap: 10)
						.child([
							UILabel()
								.text("信箱", color: _black, align: .left, row: 1, wrap: .byClipping)
								.font(weight: .medium, size: 18),
							emailTextF
						]),
					UIStackView(axis: .vert, align: .left, gap: 10)
						.child([
							UILabel()
								.text("密碼", color: _black, align: .left, row: 1, wrap: .byClipping)
								.font(weight: .medium, size: 18),
							passwdTextF
						])
				]),
			headerLbl
		])
		
		_=bodyStackV
			.Teq(T: self)
			.Leq(L: self)
			.Beq(B: self)
			.Req(R: self)
	};
	
	@objc func presentHeadSelectVC() {
		let vc = headSelectVC();
		guard let _ = rootVC.presentedViewController else {
			rootVC.present(vc, animated: true);
			return;
		};
	};
}
