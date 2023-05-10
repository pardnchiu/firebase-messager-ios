/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation;
import UIKit;

public let vw = UIScreen.main.bounds.size.width;
public let vh = UIScreen.main.bounds.size.height;

public var safeArea: UIEdgeInsets? {
	get {
		let window = UIApplication.shared.connectedScenes
			.map({
				$0 as? UIWindowScene
			})
			.compactMap({$0})
			.first?.windows.first
		return window?.safeAreaInsets;
	}
};
public var safeT: CGFloat { get { return safeArea?.top ?? 0; } };
public var safeL: CGFloat { get { return safeArea?.right ?? 0; } };
public var safeB: CGFloat { get { return safeArea?.bottom ?? 0; } };
public var safeR: CGFloat { get { return safeArea?.left ?? 0; } };

public var _font		: UIFont 	{ get { return UILabel().font } };
public var _fontSize: CGFloat { get { return UILabel().font.pointSize } };
public var _fontName: String 	{ get { return UILabel().font.fontName == ".SFUI-Regular" ? "Helvetica" : UILabel().font.fontName } };
public var _image		: UIImage { get { return UIImage(systemName: "folder.badge.questionmark") ?? UIImage(); } };

public protocol PDExtension {}
public extension PDExtension where Self: AnyObject {
		
		func `_`(_ _self: (Self) throws -> Void) rethrows -> Self {
				try _self(self);
				return self;
		};
};
extension NSObject: PDExtension {};

extension UITableView {

	public func proto(_ delegate: UITableViewDelegate,_ dataSource: UITableViewDataSource) -> Self { self.delegate = delegate; self.dataSource = dataSource; return self; };

	public func cell(_ cell: AnyClass?,_ id: String) -> Self { self.register(cell, forCellReuseIdentifier: id); return self; };

	public func separator(color: UIColor) -> Self { self.separatorColor = color; return self; };

	public func padding(_ top: CGFloat,_ left: CGFloat,_ bottom: CGFloat,_ right: CGFloat) -> Self { self.contentInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right); return self; };

	public func padding(val: CGFloat) -> Self { self.contentInset = UIEdgeInsets(top: val, left: val, bottom: val, right: val); return self; };

	public func padding(vert: CGFloat, horz: CGFloat) -> Self { self.contentInset = UIEdgeInsets(top: vert, left: horz, bottom: vert, right: horz); return self; };

	public func padding(vert: CGFloat) -> Self { self.contentInset = UIEdgeInsets(top: vert, left: self.contentInset.left, bottom: vert, right: self.contentInset.right); return self; };

	public func padding(horz: CGFloat) -> Self { self.contentInset = UIEdgeInsets(top: self.contentInset.top, left: horz, bottom: self.contentInset.bottom, right: horz); return self; };

	public func padding(T: CGFloat) -> Self { contentInset = UIEdgeInsets(top: T, left: contentInset.left, bottom: contentInset.bottom, right: contentInset.right); return self; };

	public func padding(L: CGFloat) -> Self { contentInset = UIEdgeInsets(top: contentInset.top, left: L, bottom: contentInset.bottom, right: contentInset.right); return self; };

	public func padding(B: CGFloat) -> Self { contentInset = UIEdgeInsets(top: contentInset.top, left: contentInset.left, bottom: B, right: contentInset.right); return self; };

	public func padding(R: CGFloat) -> Self {contentInset = UIEdgeInsets(top: contentInset.top, left: contentInset.left, bottom: contentInset.bottom, right: R); return self; };

	public func indicator(val: Bool) -> Self { showsVerticalScrollIndicator = val; showsHorizontalScrollIndicator = val; return self; };

	public func indicator(vert: Bool, horz: Bool) -> Self { showsVerticalScrollIndicator = vert; showsHorizontalScrollIndicator = horz; return self; };

	public func rowH(_ value: CGFloat) -> Self { rowHeight = value; return self; };

	public func rowH(auto: CGFloat) -> Self { estimatedRowHeight = auto; rowHeight = UITableView.automaticDimension; return self; };
};

extension UITextField {
	
	public func text(_ value: String) -> Self { text = value; return self; };

	public func text(placeholder value: String) -> Self { placeholder = value; return self; };

	public func font(_ font: UIFont) -> Self { self.font = font; return self; };

	public func font(name: String?, size: CGFloat?) -> Self {
		if let size = size, let name = name { self.font = UIFont(name: name, size: size) ?? _font; }
		else if let size = size { self.font = UIFont(name: self.fontName, size: size); }
		else if let name = name { self.font = UIFont(name: name, size: self.fontSize) ?? _font; }
		return self;
	};

	public func font(weight: UIFont.Weight?, size: CGFloat?) -> Self {
		if let size = size, let weight = weight { self.font = UIFont.systemFont(ofSize: size, weight: weight); }
		else if let size = size { self.font = UIFont(name: self.fontName, size: size); }
		else if let weight = weight { self.font = UIFont.systemFont(ofSize: self.fontSize, weight: weight); }
		return self;
	};

	public func font(italic size: CGFloat) -> Self { self.font = UIFont.italicSystemFont(ofSize: size); return self; };

	public func font(sizeToFit: Bool) -> Self { self.adjustsFontSizeToFitWidth = sizeToFit; return self; };
};

extension UITextView {

	public func proto(_ del: UITextViewDelegate) -> Self { self.delegate = del; return self; };

	// MARK: Text

	public func text(_ value: String, color: UIColor, align: NSTextAlignment) -> Self { text = value; textColor = color; textAlignment = align; return self; };

	// MARK: Font

	public func font(_ value: UIFont) -> Self { self.font = value; return self; };

	public func font(name: String?, size: CGFloat?) -> Self {
		if let size = size, let name = name { font = UIFont(name: name, size: size) ?? _font; }
		else if let size = size { font = UIFont(name: fontName, size: size); }
		else if let name = name { font = UIFont(name: name, size: fontSize) ?? _font; }
		return self;
	};

	public func font(weight: UIFont.Weight?, size: CGFloat?) -> Self {
		if let size = size, let weight = weight { self.font = UIFont.systemFont(ofSize: size, weight: weight); }
		else if let size = size { self.font = UIFont(name: self.fontName, size: size); }
		else if let weight = weight { self.font = UIFont.systemFont(ofSize: self.fontSize, weight: weight); }
		return self;
	};

	public func font(italic size: CGFloat) -> Self { self.font = UIFont.italicSystemFont(ofSize: size); return self; };

	// MARK: Padding

	public func padding(_ top: CGFloat,_ left: CGFloat,_ bottom: CGFloat,_ right: CGFloat) -> Self { contentInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right); return self; };

	public func padding(val: CGFloat) -> Self { contentInset = UIEdgeInsets(top: val, left: val, bottom: val, right: val); return self; };

	public func padding(vert: CGFloat, horz: CGFloat) -> Self { contentInset = UIEdgeInsets(top: vert, left: horz, bottom: vert, right: horz); return self; };

	public func padding(vert: CGFloat) -> Self { contentInset = UIEdgeInsets(top: vert, left: contentInset.left, bottom: vert, right: contentInset.right); return self; };

	public func padding(horz: CGFloat) -> Self { contentInset = UIEdgeInsets(top: contentInset.top, left: horz, bottom: contentInset.bottom, right: horz); return self; };

	public func padding(T: CGFloat) -> Self { contentInset = UIEdgeInsets(top: T, left: contentInset.left, bottom: contentInset.bottom, right: contentInset.right); return self; };

	public func padding(L: CGFloat) -> Self { contentInset = UIEdgeInsets(top: contentInset.top, left: L, bottom: contentInset.bottom, right: contentInset.right); return self; };

	public func padding(B: CGFloat) -> Self { contentInset = UIEdgeInsets(top: contentInset.top, left: contentInset.left, bottom: B, right: contentInset.right); return self; };

	public func padding(R: CGFloat) -> Self { contentInset = UIEdgeInsets(top: contentInset.top, left: contentInset.left, bottom: contentInset.bottom, right: R); return self; };
};
