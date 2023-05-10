//
//  chatVC.swift
//  firebase-messager-ios
//
//  Created by Pardn on 2023/5/8.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseDatabase
import FirebaseAuth

class chatVC: UIViewController {

	var bodyStackV	: UIStackView!
	var userStackV	: UIStackView!
	var headBtn			: UIButton!
	var nameBtn			: UIButton!
	var chatTableV	: UITableView!
	var inputStackV	: UIStackView!
	var inputTextV	: UITextView!
	var sendBtn			: UIButton!

	var uid	: String?;
	var head: String?;
	var name: String?;
	
	var ref: DatabaseReference!

	var chats: [[String:Any]] = [];
	var keyH: CGFloat = 0;

	override func viewDidLoad() {
		super.viewDidLoad();

		ref = Database.database().reference();

		getChat();

		let isDark = traitCollection.userInterfaceStyle == .dark;

		bodyStackV = UIStackView(axis: .vert, align: .left, fill: .fill);

		userStackV = UIStackView(axis: .horz, align: .left, fill: .eqSpace)
			.Weq(vw)
			.Heq(70)
			.layer([
				CALayer()._ { e in
					e.frame = CGRect(0, 69, vw, 1);
					e.backgroundColor = _gray.cgColor;
				}
			]);

		headBtn = UIButton()
			.bg(color: _gray)
			.bg(image: UIImage(name: head ?? ""), mode: .scaleAspectFit)
			.radius(20)
			.Weq(40)
			.Heq(40)
			.clip(view: true);

		nameBtn = UIButton()
			.text(name ?? "", color: _black)
			.font(weight: .medium, size: 20)
			.Heq(40);

		chatTableV = UITableView()
			.padding(B: 50)
			.proto(self, self)
			.bg(color: .clear)
			.separator(color: .clear)
			.rowH(auto: 50)
			.Weq(vw);

		inputStackV = UIStackView(axis: .horz, align: .left)
			.Weq(vw)
			.Heq(50 + safeB)
			.layer([
				CALayer()._ { e in
					e.frame = CGRect(-15, 0, vw + 15, 1);
					e.backgroundColor = _gray.cgColor;
				}
			]);

		inputTextV = UITextView()
			.proto(self)
			.padding(T: 6)
			.padding(horz: 15)
			.text("請輸入訊息內容", color: _gray, align: .left)
			.font(weight: .bold, size: 18)
			.bg(color: .clear)
			.Weq(vw - 40)
			.Heq(50);

		sendBtn = UIButton()
			.bg(image: UIImage(sys: "paperplane.fill"), color: _black, mode: .scaleAspectFit)
			.Weq(30)
			.Heq(50)
			.touch(down: self, #selector(sendMessage));

		_=view
			.child([
				UIVisualEffectView(style: isDark ? .dark : .extraLight)
					.frame(0, 0, vw, vh),
				bodyStackV
					.child([
						userStackV
							.child([
								UIView(),
								UIStackView(axis: .horz, align: .left)
									.padding(T: 15)
									.child([
										headBtn,
										nameBtn
									]),
								UIView()
							]),
						chatTableV
					])
					.child(unsort: [
						inputStackV
							.child(unsort: [
								UIVisualEffectView(style: isDark ? .dark : .regular)
									.frame(0, 0, vw, 50 + safeB),
							])
							.child([
								inputTextV,
								sendBtn,
								UIView()
							])
					])
			]);

		_=bodyStackV
			.Teq(T: view)
			.Leq(L: view)
			.Beq(B: view, -safeB)
			.Req(R: view);

		_=inputStackV
			.Leq(L: view)
			.Beq(B: view)
			.Req(R: view);

		let notify = NotificationCenter.default
		notify.addObserver(self, selector: #selector(showkeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
	};

	@objc func showkeyboard(aNotification: NSNotification) {

		let info: NSDictionary = aNotification.userInfo! as NSDictionary
		let value = info.object(forKey: UIResponder.keyboardFrameEndUserInfoKey)
		let keyboard = (value as AnyObject).cgRectValue

		keyH = (keyboard?.size.height)!

		view.constraints.filter { e in
			return e.firstAnchor == inputStackV.bottomAnchor || e.secondAnchor == inputStackV.bottomAnchor
		}.forEach { e in
			view.removeConstraint(e)
		};
		inputStackV.constraints.filter { e in
			return e.firstAnchor == inputStackV.heightAnchor || e.secondAnchor == inputStackV.heightAnchor
		}.forEach { e in
			inputStackV.removeConstraint(e)
		};
		_=inputStackV
			.Beq(B: view, -keyH)
			.Heq(50);

		view.constraints.filter { e in
			return e.firstAnchor == bodyStackV.bottomAnchor || e.secondAnchor == bodyStackV.bottomAnchor
		}.forEach { e in
			view.removeConstraint(e)
		};
		_=bodyStackV
			.Beq(B: view, -keyH);
	};

	func getChat() {
		guard let auth = Auth.auth().currentUser, let uid = uid else { return; };

		ref.child("chats").child(auth.uid).child(uid).observe(.childAdded, with: { snap in
			guard let value = snap.value as? NSDictionary else { return; };

			guard let data = value as? [String:Any] else { return; };
			guard
				let content = data["content"] as? String,
				let from = data["from"] as? String,
				let upload = data["upload"] as? String
			else { return; };

			let isOwner = from == auth.uid;

			self.chats.append([
				"isOwner": isOwner,
				"uid": from,
				"message": content,
				"upload": upload
			]);
			self.chatTableV.insertRows(at: [IndexPath(item: self.chats.count-1, section: 0)], with: .automatic)
			self.chatTableV.setNeedsLayout();
			self.chatTableV.layoutIfNeeded();
			self.chatTableV.setContentOffset(CGPoint(0, self.chatTableV.contentSize.height -  self.chatTableV.bounds.height + 50), animated: false);
		});
	};

	@objc func sendMessage() {
		guard
			let authUid = Auth.auth().currentUser?.uid,
			let authHead = fauth["head"],
			let authName = fauth["name"],
			let uid = uid,
			let head = head,
			let name = name,
			let content = inputTextV.text else { return; };

		inputTextV.text = nil;
		
		let now = Date();
		let timestamp = "\(Int(now.timeIntervalSince1970))";
		ref.child("chats").child(authUid).child(uid).child(timestamp).setValue([
			"content"	: content,
			"from"		: authUid,
			"to"			: uid,
			"read"		: "1",
			"upload"	: timestamp
		]);
		ref.child("chats").child(uid).child(authUid).child(timestamp).setValue([
			"content"	: content,
			"from"		: authUid,
			"to"			: uid,
			"read"		: "0",
			"upload"	: timestamp
		]);
		ref.child("chatbox").child(authUid).child(uid).updateChildValues([
			"uid"			: uid,
			"head"		: head,
			"name"		: name,
			"last"		: content,
			"updated"	: timestamp,
			"read"		: "1"
		]);
		ref.child("chatbox").child(uid).child(authUid).updateChildValues([
			"uid"			: authUid,
			"head"		: authHead,
			"name"		: authName,
			"last"		: content,
			"updated"	: timestamp,
			"read"		: "0"
		]);
	};
};

extension chatVC: UITextViewDelegate {

	func textViewDidBeginEditing(_ textView: UITextView) {
		if textView.textColor == _gray {
			textView.text = nil
			textView.textColor = _black
		}
	};

	func textViewDidEndEditing(_ textView: UITextView) {
		if textView.text.isEmpty {
			textView.text = "請輸入訊息內容"
			textView.textColor = _gray
		}
	};
};

extension chatVC: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return chats.count;
	};

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let data = chats[indexPath.row];
		guard let isOwner = data["isOwner"] as? Bool, let message = data["message"] as? String, let upload = data["upload"] as? String else { return UITableViewCell() };

		if (isOwner) {
			let cell = chatOwnerVCell()._ { e in
				_=e.messageLbl.text(message);
				_=e.dateLbl.text(upload);
			};
			return cell;
		}
		else {
			let cell = chatGuestVCell()._ { e in
				_=e.messageLbl.text(message);
				_=e.dateLbl.text(upload);
			};
			return cell;
		}
	}
}

class chatOwnerVCell: UITableViewCell {

	var bodyStackV: UIStackView!
	var messageLbl: UILabel!
	var dateLbl   : UILabel!

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier);

		_=bg(color: .clear);

		selectedBackgroundView = UIView();

		bodyStackV = UIStackView(axis: .vert, align: .right)
			.padding(vert: 15, horz: 10)
			.bg(color: .systemBlue)
			.radius(10);

		messageLbl = UILabel()
			.text("asdfasdfasdfasasdfasdfasdfasasdfasdfasdfasasdfasdfasdfasasdfasdfasdfasasdfasdfasdfas", color: .white, align: .left, row: 0, wrap: .byClipping)

		dateLbl = UILabel()
			.text("""
19:00
2023/10/10
""", color: UIColor(hex: "777"), align: .right, row: 0, wrap: .byClipping)
			.font(italic: 15)
			.alpha(0)

		_=contentView
			.child([
				bodyStackV
					.child([
						messageLbl
					]),
				dateLbl
			])

		_=bodyStackV
			.Teq(T: contentView, 10)
			.Lge(L: contentView, 110)
			.Beq(B: contentView, -10)
			.Req(R: contentView, -15)

		_=dateLbl
			.Beq(B: bodyStackV, -10)
			.Req(L: bodyStackV, -10)
	};

	required init?(coder aDecoder: NSCoder) {
		super.init(coder:aDecoder)
	};
};

class chatGuestVCell: UITableViewCell {

	var bodyStackV: UIStackView!
	var messageLbl: UILabel!
	var dateLbl   : UILabel!

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier);

		_=bg(color: .clear);

		selectedBackgroundView = UIView()

		bodyStackV = UIStackView(axis: .vert, align: .left)
			.padding(vert: 15, horz: 10)
			.bg(color: .blue)
			.radius(10);

		messageLbl = UILabel()
			.text("adfasdfasdf", color: .white, align: .left, row: 0, wrap: .byClipping);

		dateLbl = UILabel()
			.text("""
19:00
2023/10/10
""", color: UIColor(hex: "777"), align: .left, row: 0, wrap: .byClipping)
			.font(italic: 15)
			.alpha(0)

		_=contentView
			.child([
				bodyStackV
					.child([
						messageLbl
					]),
				dateLbl
			])

		_=bodyStackV
			.Teq(T: contentView, 10)
			.Leq(L: contentView, 15)
			.Beq(B: contentView, -10)
			.Rle(R: contentView, -vw / 4)

		_=dateLbl
			.Beq(B: bodyStackV, -10)
			.Leq(R: bodyStackV, 10)
	};

	required init?(coder aDecoder: NSCoder) {
		super.init(coder:aDecoder)
	};
}

