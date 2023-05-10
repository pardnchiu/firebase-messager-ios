/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import UIKit;
import FirebaseCore
import FirebaseDatabase
import FirebaseAuth

var fauth: [String:String] = [:]

class homeVC: UIViewController {

	var offset: CGPoint = CGPoint(0, 0);
	
	var bodyScrollV	: UIScrollView!
	var bodyStackV	: UIStackView!
	var accountV		: accountV!
	var friendsV		: friendsV!
	var chatsV			: chatsV!
	var readmeV			: readmeV!
	var bottomV			: bottomV!

	var ref: DatabaseReference!

	var users: [[String:Any]] = [];
	var chats: [[String:Any]] = [];

	override func viewDidLoad() {
		super.viewDidLoad();

		ref = Database.database().reference();

		getAuth();
		getFriends();
		getChats();

		bodyScrollV = UIScrollView()._ { e in
			e.delegate = self;
			e.bounces = false;
			e.contentSize = CGSize((vw - 40) * 3 + vw, vh);
			e.contentOffset = CGPoint(vw - 40, 0)
			_=e.bg(color: _white);
		};

		bodyStackV = UIStackView(axis: .horz, align: .left);

		accountV = firebase_messager_ios.accountV(rootVC: self)
			.Weq(vw - 40);

		friendsV = firebase_messager_ios.friendsV(self, self)
			.Weq(vw - 40);

		chatsV = firebase_messager_ios.chatsV(self, self)
			.Weq(vw - 40);

		readmeV = firebase_messager_ios.readmeV(isShow: false)
			.Weq(vw);

		bottomV = firebase_messager_ios.bottomV(target: self, show: .friends)
			.Heq(60);

		_=view
			.child([
				bodyScrollV
					.child([
						bodyStackV
							.child([
								accountV,
								friendsV,
								chatsV,
								readmeV
							])
					]),
				bottomV
			]);

		_=bodyScrollV
			.Teq(T: view)
			.Leq(L: view)
			.Beq(B: view)
			.Req(R: view);
		
		_=bodyStackV
			.Teq(T: bodyScrollV, safeT)
			.Leq(L: bodyScrollV)
			.Beq(T: bottomV)
			.Req(R: bodyScrollV);

		_=bottomV
			.Leq(L: view)
			.Beq(B: view, -safeB)
			.Req(R: view);

		_=accountV
			.Teq(T: bodyStackV)
			.Beq(B: bodyStackV);

		_=friendsV
			.Teq(T: bodyStackV)
			.Beq(B: bodyStackV);

		_=chatsV
			.Teq(T: bodyStackV)
			.Beq(B: bodyStackV);

		_=readmeV
			.Teq(T: bodyStackV)
			.Beq(B: bodyStackV);
	};

	func getAuth() {
		guard let auth = Auth.auth().currentUser else { return self.dismiss(animated: true); };
		let uid 	= auth.uid;
		let email = auth.email ?? "";

		ref.child("users").child(uid).observeSingleEvent(of: .value, with: { snap in
			let data = snap.value as? [String:Any] ?? [:];
			let head = data["head"] as? String ?? "";
			let name = data["name"] as? String ?? "";

			fauth = [
				"uid"		: uid,
				"head"	: head,
				"name"	: name,
				"email"	: email
			];

			_=self.accountV._ { e in
				_=e.headBtn.img(UIImage(name: head));
				_=e.nameTextF.text(name);
				_=e.emailTextF.text(email);
			};
		});
	};

	func getFriends() {
		/*

		 firebase 資料格式

		 friends
		 - uid (個人)
		 		- uid (好友)
		 			- head: String
		 			- name: String

		 */
		guard let userid = Auth.auth().currentUser?.uid else { return; };

		ref.child("friends").child(userid).observeSingleEvent(of: .value, with: { snap in
			guard let value = snap.value as? NSDictionary else { return; };

			value.allKeys.forEach { e in
				guard let user = value[e] as? [String:Any] else { return; };
				guard let head = user["head"] as? String, let name = user["name"] as? String else { return; };

				self.users.append([
					"uid": e,
					"head": head,
					"name": name
				]);
			};

			self.friendsV.bodyTableV.reloadData();
		}) { err in print(err.localizedDescription) };
	};

	func getChats() {
		/*

		 firebase 資料格式

		 chats
		 - uid (個人)
		 		- uid (對方)
		 				- timestamp
							 - content: String
							 - date: Int
							 - from: String
							 - to: String
		 					 - read: Int

		 */
		guard let userid = Auth.auth().currentUser?.uid else { return; };

		ref.child("chatbox").child(userid).observe(.childAdded, with: { snap in
			guard let data = snap.value as? [String:Any] else { return; };

			self.chats.append(data);

			self.chats.sort { a, b -> Bool in
				let A = a["updated"] as? String ?? "";
				let B = b["updated"] as? String ?? "";
				return A.compare(B) == .orderedDescending;
			};

			self.chatsV.bodyTableV.reloadData();
		});

		ref.child("chatbox").child(userid).observe(.childChanged, with: { snap in
			guard let data = snap.value as? [String:Any] else { return; };

			let index = self.chats.firstIndex { e in
				let A = e["uid"] as? String ?? "";
				let B = data["uid"] as? String ?? "";
				return A == B;
			};

			self.chats.remove(at: index ?? -1);
			self.chats.append(data)

			self.chats.sort { a, b -> Bool in
				let A = a["updated"] as? String ?? "";
				let B = b["updated"] as? String ?? "";
				return A.compare(B) == .orderedDescending;
			};

			self.chatsV.bodyTableV.reloadData();
		});
	};
};

extension homeVC: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch tableView {
			case friendsV.bodyTableV	: return users.count;
			case chatsV.bodyTableV		: return chats.count;
			default							: return 0;
		};
	};

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch tableView {
			case friendsV.bodyTableV	: return 90;
			case chatsV.bodyTableV		: return 115;
			default							: return 0;
		};
	};

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch tableView {
			case friendsV.bodyTableV:
				let data: [String:Any] = users[indexPath.row];
				guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendsTableVCell") as? friendsTableVCell, let head = data["head"] as? String, let name 	= data["name"] as? String else { return UITableViewCell(); };
				_=cell.headImageV.img(UIImage(name: head), mode: .scaleAspectFill);
				_=cell.nameLbl.text(name);
				return cell;
			case chatsV.bodyTableV:
				let data: [String:Any] = chats[indexPath.row];
				guard let cell = tableView.dequeueReusableCell(withIdentifier: "chatsTableVCell") as? chatsTableVCell, let head = data["head"] as? String, let name = data["name"] as? String, let last = data["last"] as? String else { return UITableViewCell(); };
				_=cell.headImageV.img(UIImage(name: head), mode: .scaleAspectFill);
				_=cell.nameLbl.text(name);
				_=cell.dateLbl.text("1分鐘前");
				_=cell.contentLbl.text(last);
				return cell;
			default: return UITableViewCell();
		};
	};

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch tableView {
			case friendsV.bodyTableV:
				let user = users[indexPath.row];
				let vc = chatVC();
				vc.uid = user["uid"] as? String ?? "";
				vc.head = user["head"] as? String ?? "";
				vc.name = user["name"] as? String ?? "";
				self.present(vc, animated: true);
			case chatsV.bodyTableV:
				let chat = chats[indexPath.row];
				let vc = chatVC();
				vc.uid = chat["uid"] as? String ?? "";
				vc.head = chat["head"] as? String ?? "";
				vc.name = chat["name"] as? String ?? "";
				self.present(vc, animated: true);
				break;
			default: break;
		};
	};
};

extension homeVC: UIScrollViewDelegate {

	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		offset = scrollView.contentOffset;
	};

	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		offset = scrollView.contentOffset;
	};

	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		if scrollView == self.bodyScrollV {
			var offsetX: CGFloat = scrollView.contentOffset.x;
			switch true {
				case offsetX >= (vw - 40) * 2.5: offsetX = (vw - 40) * 3; bottomV.change(to: .about); break;
				case offsetX >= (vw - 40) * 1.5: offsetX = (vw - 40) * 2; bottomV.change(to: .chats); break;
				case offsetX >= (vw - 40) * 0.5: offsetX = vw - 40; bottomV.change(to: .friends); break;
				default: offsetX = 0; bottomV.change(to: .account); break;
			}
			DispatchQueue.main.async {
				scrollView.setContentOffset(CGPoint(offsetX, 0), animated: true)
			};
		};
	};
};
