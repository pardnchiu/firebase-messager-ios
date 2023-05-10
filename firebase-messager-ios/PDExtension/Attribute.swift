/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation;
import UIKit;

public extension UIButton {

	var attrTxt: NSAttributedString { get { return self.currentAttributedTitle ?? NSAttributedString(string: self.currentTitle ?? "") } set { self.setAttributedTitle(newValue, for: .normal); } };

	func attr(txt: String, clr: UIColor) 													-> UIButton { self.attr(txt: txt).attr(clr: clr); };
	func attr(txt: String, hex: String) 													-> UIButton { self.attr(txt: txt).attr(hex: hex); };
	func attr(txt: String, rgb: String) 													-> UIButton { self.attr(txt: txt).attr(rgb: rgb); };
	func attr(txt: String, clr: UIColor, align: NSTextAlignment) 	-> UIButton { self.attr(txt: txt).attr(clr: clr).attr(align: align); };
	func attr(txt: String, hex: String, align: NSTextAlignment) 	-> UIButton { self.attr(txt: txt).attr(hex: hex).attr(align: align); };
	func attr(txt: String, rgb: String, align: NSTextAlignment) 	-> UIButton { self.attr(txt: txt).attr(rgb: rgb).attr(align: align); };
	
	func attr(txt: String) 																-> UIButton { self.attrTxt = addValue(nil, txt); return self; };
	func attr(ligature: Bool)															-> UIButton { self.attrTxt = addValue(.ligature, ligature); return self; };
	func attr(font: UIFont) 															-> UIButton { self.attrTxt = addValue(.font, font); return self; };
	func attr(name: String, size: CGFloat) 								-> UIButton { self.attrTxt = addValue(.font, UIFont(name: name, size: size) ?? _font); return self; };
	func attr(name: String) 															-> UIButton { self.attrTxt = addValue(.font, UIFont(name: name, size: self.titleLabel?.fontSize ?? _fontSize) ?? _font); return self; };
	func attr(size: CGFloat) 															-> UIButton { self.attrTxt = addValue(.font, UIFont(name: self.titleLabel?.fontName ?? _fontName, size: size) ?? _font); return self; };
	func attr(size: CGFloat, weight: UIFont.Weight) 			-> UIButton { self.attrTxt = addValue(.font, UIFont.systemFont(ofSize: size, weight: weight)); return self; };
	func attr(weight: UIFont.Weight) 											-> UIButton { self.attrTxt = addValue(.font, UIFont.systemFont(ofSize: self.titleLabel?.fontSize ?? _fontSize, weight: weight)); return self; };
	func attr(italic size: CGFloat) 											-> UIButton { self.attrTxt = addValue(.font, UIFont.italicSystemFont(ofSize: size)); return self; };
	func attr(clr: UIColor) 															-> UIButton { self.attrTxt = addValue(.foregroundColor, clr); return self; };
	func attr(hex: String) 																-> UIButton { self.attrTxt = addValue(.foregroundColor, UIColor(hex: hex)); return self; };
	func attr(rgb: String) 																-> UIButton { self.attrTxt = addValue(.foregroundColor, UIColor(rgb: rgb)); return self; };
	func attr(bgClr: UIColor) 														-> UIButton { self.attrTxt = addValue(.backgroundColor, bgClr); return self; };
	func attr(bgHex: String) 															-> UIButton { self.attrTxt = addValue(.backgroundColor, UIColor(hex: bgHex)); return self; };
	func attr(bgRgb: String) 															-> UIButton { self.attrTxt = addValue(.backgroundColor, UIColor(rgb: bgRgb)); return self; };
	func attr(charSpacing: Float) 												-> UIButton { self.attrTxt = addValue(.kern, charSpacing); return self; };
	func attr(strike: NSUnderlineStyle)										-> UIButton { self.attrTxt = addValue(.strikethroughStyle, NSNumber(value: strike.rawValue)); return self; }
	func attr(strikeClr: UIColor)													-> UIButton { self.attrTxt = addValue(.strikethroughColor, strikeClr); return self; }
	func attr(under: NSUnderlineStyle)										-> UIButton { self.attrTxt = addValue(.underlineStyle, NSNumber(value: under.rawValue)); return self; }
	func attr(underClr: UIColor)													-> UIButton { self.attrTxt = addValue(.underlineColor, underClr); return self; }
	func attr(stokeW: CGFloat)														-> UIButton { self.attrTxt = addValue(.strokeWidth, stokeW); return self; }
	func attr(stokeClr: UIColor)													-> UIButton { self.attrTxt = addValue(.strokeColor, stokeClr); return self; }
	func attr(offset: CGFloat)														-> UIButton { self.attrTxt = addValue(.baselineOffset, offset); return self; }
	func attr(url: String)																-> UIButton { self.attrTxt = addValue(.link, url); return self; }
	func attr(url: URL)																		-> UIButton { self.attrTxt = addValue(.link, url); return self; }
	func attr(oblique: CGFloat)														-> UIButton { self.attrTxt = addValue(.obliqueness, oblique > 1 ? 1 : oblique); return self; }
	func attr(expand: CGFloat)														-> UIButton { self.attrTxt = addValue(.expansion, expand); return self; }
	func attr(effect: NSAttributedString.TextEffectStyle) -> UIButton { self.attrTxt = addValue(.textEffect, effect); return self; }
	func attr(vert: Bool)																	-> UIButton { self.attrTxt = addValue(.verticalGlyphForm, vert); return self; }

	func attr(align: NSTextAlignment) 	-> UIButton { self.attrTxt = addStyle({ style in style.alignment = align; }); return self; };
	func attr(wrap: NSLineBreakMode) 		-> UIButton { self.attrTxt = addStyle({ style in style.lineBreakMode = wrap; }); return self; };
	func attr(lineSpacing: CGFloat) 		-> UIButton { self.attrTxt = addStyle({ style in style.lineSpacing = lineSpacing; }); return self; };
	func attr(paraSpacing: CGFloat) 		-> UIButton { self.attrTxt = addStyle({ style in style.paragraphSpacing = paraSpacing; }); return self; };
	func attr(firstIndent: CGFloat) 		-> UIButton { self.attrTxt = addStyle({ style in style.firstLineHeadIndent = firstIndent; }); return self; };
	func attr(headIndent: CGFloat) 			-> UIButton { self.attrTxt = addStyle({ style in style.headIndent = headIndent; }); return self; };
	func attr(tailIndent: CGFloat) 			-> UIButton { self.attrTxt = addStyle({ style in style.tailIndent = tailIndent; }); return self; };
	func attr(minH: CGFloat) 						-> UIButton { self.attrTxt = addStyle({ style in style.minimumLineHeight = minH; }); return self; };
	func attr(maxH: CGFloat) 						-> UIButton { self.attrTxt = addStyle({ style in style.maximumLineHeight = maxH; }); return self; };
	func attr(dir: NSWritingDirection) 	-> UIButton { self.attrTxt = addStyle({ style in style.baseWritingDirection = dir; }); return self; };

	private func addValue(_ key: NSAttributedString.Key?,_ value: Any) -> NSAttributedString {
		let oldtxt = self.attrTxt;
		let attr = oldtxt.attributes(at: 0, effectiveRange: nil);
		let newTxt = (key == nil) ? NSAttributedString(string: value as? String ?? "") : oldtxt;
		let new = NSMutableAttributedString(attributedString: newTxt);
		if (attr.count != 0) {
			attr.forEach { (key: NSAttributedString.Key, value: Any) in
				if (key != .paragraphStyle) {
					new.addAttribute(key, value: value, range: NSRange(location: 0, length: new.length));
				};
			};
		};
		if let key = key {
			new.addAttribute(key, value: value, range: NSRange(location: 0, length: new.length));
		};
		return new;
	};
	private func addStyle(_ void: (NSMutableParagraphStyle) -> Void) -> NSAttributedString {
		let txt = self.attrTxt;
		let attr = txt.attributes(at: 0, effectiveRange: nil);
		let new = NSMutableAttributedString(attributedString: txt);
		if (attr.count != 0) {
			attr.forEach { (key: NSAttributedString.Key, value: Any) in
				if (key != .paragraphStyle) {
					new.addAttribute(key, value: value, range: NSRange(location: 0, length: new.length));
				};
			};
		};
		if let style = attr[NSAttributedString.Key.paragraphStyle] as? NSMutableParagraphStyle {
			void(style);
			new.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: new.length))
		}
		else {
			let style = NSMutableParagraphStyle();
			void(style);
			new.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: new.length));
		};
		return new;
	};
};

public extension UILabel {

	var attrTxt: NSAttributedString { get { return self.attributedText ?? NSAttributedString(string: self.text ?? "") } set { self.attributedText = newValue } };

	func attr(txt: String, clr: UIColor) 													-> UILabel { self.attr(txt: txt).attr(clr: clr); };
	func attr(txt: String, hex: String) 													-> UILabel { self.attr(txt: txt).attr(hex: hex); };
	func attr(txt: String, rgb: String) 													-> UILabel { self.attr(txt: txt).attr(rgb: rgb); };
	func attr(txt: String, clr: UIColor, align: NSTextAlignment) 	-> UILabel { self.attr(txt: txt).attr(clr: clr).attr(align: align); };
	func attr(txt: String, hex: String, align: NSTextAlignment) 	-> UILabel { self.attr(txt: txt).attr(hex: hex).attr(align: align); };
	func attr(txt: String, rgb: String, align: NSTextAlignment) 	-> UILabel { self.attr(txt: txt).attr(rgb: rgb).attr(align: align); };

	func attr(txt: String) 																-> UILabel { self.attrTxt = setAttrKeyValue(nil, txt); return self; };
	func attr(ligature: Bool)															-> UILabel { self.attrTxt = setAttrKeyValue(.ligature, ligature); return self; };
	func attr(font: UIFont) 															-> UILabel { self.attrTxt = setAttrKeyValue(.font, font); return self; };
	func attr(name: String, size: CGFloat) 								-> UILabel { self.attrTxt = setAttrKeyValue(.font, UIFont(name: name, size: size) ?? _font); return self; };
	func attr(name: String) 															-> UILabel { self.attrTxt = setAttrKeyValue(.font, UIFont(name: name, size: self.fontSize) ?? _font); return self; };
	func attr(size: CGFloat) 															-> UILabel { self.attrTxt = setAttrKeyValue(.font, UIFont(name: self.fontName, size: size) ?? _font); return self; };
	func attr(size: CGFloat, weight: UIFont.Weight) 			-> UILabel { self.attrTxt = setAttrKeyValue(.font, UIFont.systemFont(ofSize: size, weight: weight)); return self; };
	func attr(weight: UIFont.Weight) 											-> UILabel { self.attrTxt = setAttrKeyValue(.font, UIFont.systemFont(ofSize: self.fontSize, weight: weight)); return self; };
	func attr(italic size: CGFloat) 											-> UILabel { self.attrTxt = setAttrKeyValue(.font, UIFont.italicSystemFont(ofSize: size)); return self; };
	func attr(clr: UIColor) 															-> UILabel { self.attrTxt = setAttrKeyValue(.foregroundColor, clr); return self; };
	func attr(hex: String) 																-> UILabel { self.attrTxt = setAttrKeyValue(.foregroundColor, UIColor(hex: hex)); return self; };
	func attr(rgb: String) 																-> UILabel { self.attrTxt = setAttrKeyValue(.foregroundColor, UIColor(rgb: rgb)); return self; };
	func attr(bgClr: UIColor) 														-> UILabel { self.attrTxt = setAttrKeyValue(.backgroundColor, bgClr); return self; };
	func attr(bgHex: String) 															-> UILabel { self.attrTxt = setAttrKeyValue(.backgroundColor, UIColor(hex: bgHex)); return self; };
	func attr(bgRgb: String) 															-> UILabel { self.attrTxt = setAttrKeyValue(.backgroundColor, UIColor(rgb: bgRgb)); return self; };
	func attr(charSpacing: Float) 												-> UILabel { self.attrTxt = setAttrKeyValue(.kern, charSpacing); return self; };
	func attr(strike: NSUnderlineStyle)										-> UILabel { self.attrTxt = setAttrKeyValue(.strikethroughStyle, NSNumber(value: strike.rawValue)); return self; }
	func attr(strikeClr: UIColor)													-> UILabel { self.attrTxt = setAttrKeyValue(.strikethroughColor, strikeClr); return self; }
	func attr(under: NSUnderlineStyle)										-> UILabel { self.attrTxt = setAttrKeyValue(.underlineStyle, NSNumber(value: under.rawValue)); return self; }
	func attr(underClr: UIColor)													-> UILabel { self.attrTxt = setAttrKeyValue(.underlineColor, underClr); return self; }
	func attr(stokeW: CGFloat)														-> UILabel { self.attrTxt = setAttrKeyValue(.strokeWidth, stokeW); return self; }
	func attr(stokeClr: UIColor)													-> UILabel { self.attrTxt = setAttrKeyValue(.strokeColor, stokeClr); return self; }
	func attr(offset: CGFloat)														-> UILabel { self.attrTxt = setAttrKeyValue(.baselineOffset, offset); return self; }
	func attr(url: String)																-> UILabel { self.attrTxt = setAttrKeyValue(.link, url); return self; }
	func attr(url: URL)																		-> UILabel { self.attrTxt = setAttrKeyValue(.link, url); return self; }
	func attr(oblique: CGFloat)														-> UILabel { self.attrTxt = setAttrKeyValue(.obliqueness, oblique > 1 ? 1 : oblique); return self; }
	func attr(expand: CGFloat)														-> UILabel { self.attrTxt = setAttrKeyValue(.expansion, expand); return self; }
	func attr(effect: NSAttributedString.TextEffectStyle) -> UILabel { self.attrTxt = setAttrKeyValue(.textEffect, effect); return self; }
	func attr(vert: Bool)																	-> UILabel { self.attrTxt = setAttrKeyValue(.verticalGlyphForm, vert); return self; }

	func attr(align: NSTextAlignment) 	-> UILabel { self.attrTxt = setAttrParaStyle({ style in style.alignment = align; }); return self; };
	func attr(wrap: NSLineBreakMode) 		-> UILabel { self.attrTxt = setAttrParaStyle({ style in style.lineBreakMode = wrap; }); return self; };
	func attr(lineSpacing: CGFloat) 		-> UILabel { self.attrTxt = setAttrParaStyle({ style in style.lineSpacing = lineSpacing; }); return self; };
	func attr(paraSpacing: CGFloat) 		-> UILabel { self.attrTxt = setAttrParaStyle({ style in style.paragraphSpacing = paraSpacing; }); return self; };
	func attr(firstIndent: CGFloat) 		-> UILabel { self.attrTxt = setAttrParaStyle({ style in style.firstLineHeadIndent = firstIndent; }); return self; };
	func attr(headIndent: CGFloat) 			-> UILabel { self.attrTxt = setAttrParaStyle({ style in style.headIndent = headIndent; }); return self; };
	func attr(tailIndent: CGFloat) 			-> UILabel { self.attrTxt = setAttrParaStyle({ style in style.tailIndent = tailIndent; }); return self; };
	func attr(minH: CGFloat) 						-> UILabel { self.attrTxt = setAttrParaStyle({ style in style.minimumLineHeight = minH; }); return self; };
	func attr(maxH: CGFloat) 						-> UILabel { self.attrTxt = setAttrParaStyle({ style in style.maximumLineHeight = maxH; }); return self; };
	func attr(dir: NSWritingDirection) 	-> UILabel { self.attrTxt = setAttrParaStyle({ style in style.baseWritingDirection = dir; }); return self; };

	private func setAttrKeyValue(_ key: NSAttributedString.Key?,_ value: Any) -> NSAttributedString {
		let oldtxt = self.attrTxt;
		let attr = oldtxt.attributes(at: 0, effectiveRange: nil);
		let newTxt = (key == nil) ? NSAttributedString(string: value as? String ?? "") : oldtxt;
		let new = NSMutableAttributedString(attributedString: newTxt);
		if (attr.count != 0) {
			attr.forEach { (key: NSAttributedString.Key, value: Any) in
				if (key != .paragraphStyle) {
					new.addAttribute(key, value: value, range: NSRange(location: 0, length: new.length));
				};
			};
		};
		if let key = key {
			new.addAttribute(key, value: value, range: NSRange(location: 0, length: new.length));
		};
		return new;
	};
	private func setAttrParaStyle(_ void: (NSMutableParagraphStyle) -> Void) -> NSAttributedString {
		let txt = self.attrTxt;
		let attr = txt.attributes(at: 0, effectiveRange: nil);
		let new = NSMutableAttributedString(attributedString: txt);
		if (attr.count != 0) {
			attr.forEach { (key: NSAttributedString.Key, value: Any) in
				if (key != .paragraphStyle) {
					new.addAttribute(key, value: value, range: NSRange(location: 0, length: new.length));
				};
			};
		};
		if let style = attr[NSAttributedString.Key.paragraphStyle] as? NSMutableParagraphStyle {
			void(style);
			new.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: new.length))
		}
		else {
			let style = NSMutableParagraphStyle();
			void(style);
			new.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: new.length));
		};
		return new;
	};
};

public extension UITextField {
	
	var fontName	: String 	{ get { return self.font?.fontName == ".SFUI-Regular" ? "Helvetica" : self.font?.fontName ?? "Helvetica" } };
	var fontSize	: CGFloat { get { return self.font?.pointSize ?? UILabel().fontSize } };
	var fontWeight: UIFont.Weight {
		get {
			let descriptor 	= self.font?.fontDescriptor;
			let attributes 	= descriptor?.fontAttributes;
			let fontWeight 	= attributes?[.traits] as? [UIFontDescriptor.TraitKey: Any];
			let weight 			= fontWeight?[.weight] as? CGFloat ?? UIFont.Weight.regular.rawValue;
			return UIFont.Weight(rawValue: weight);
		}
	};
	var attrTxt		: NSAttributedString { get { return self.attributedText ?? NSAttributedString(string: self.text ?? "") } set { self.attributedText = newValue } };
	var attrPlh		: NSAttributedString { get { return self.attributedPlaceholder ?? NSAttributedString(string: self.placeholder ?? "") } set { self.attributedPlaceholder = newValue } };

	enum __attr_target {
		case text;
		case placeholder;
	};

	func attr(txt: String, clr: UIColor,_ target: __attr_target) 													-> UITextField { self.attr(txt: txt, target).attr(clr: clr, target); };
	func attr(txt: String, hex: String,_ target: __attr_target) 													-> UITextField { self.attr(txt: txt, target).attr(hex: hex, target); };
	func attr(txt: String, rgb: String,_ target: __attr_target) 													-> UITextField { self.attr(txt: txt, target).attr(rgb: rgb, target); };
	func attr(txt: String, clr: UIColor, align: NSTextAlignment,_ target: __attr_target) 	-> UITextField { self.attr(txt: txt, target).attr(clr: clr, target).attr(align: align, target); };
	func attr(txt: String, hex: String, align: NSTextAlignment,_ target: __attr_target) 	-> UITextField { self.attr(txt: txt, target).attr(hex: hex, target).attr(align: align, target); };
	func attr(txt: String, rgb: String, align: NSTextAlignment,_ target: __attr_target) 	-> UITextField { self.attr(txt: txt, target).attr(rgb: rgb, target).attr(align: align, target); };

	func attr(txt: String,_ target: __attr_target) 																-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(nil, txt);
		}
		else {
			self.attrPlh = setPlhValue(nil, txt);
		};
		return self;
	};
	func attr(ligature: Bool,_ target: __attr_target) 														-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.ligature, ligature);
		} else {
			self.attrPlh = setPlhValue(.ligature, ligature);
		};
		return self;
	};
	func attr(font: UIFont,_ target: __attr_target) 															-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.font, font);
		} else {
			self.attrPlh = setPlhValue(.font, font);
		};
		return self;
	};
	func attr(name: String, size: CGFloat,_ target: __attr_target) 								-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.font, UIFont(name: name, size: size) ?? _font);
		} else {
			self.attrPlh = setPlhValue(.font, UIFont(name: name, size: size) ?? _font);
		};
		return self;
	};
	func attr(name: String,_ target: __attr_target) 															-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.font, UIFont(name: name, size: self.fontSize) ?? _font);
		} else {
			self.attrPlh = setPlhValue(.font, UIFont(name: name, size: self.fontSize) ?? _font);
		};
		return self;
	};
	func attr(size: CGFloat,_ target: __attr_target) 															-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.font, UIFont(name: self.fontName, size: size) ?? _font);
		} else {
			self.attrPlh = setPlhValue(.font, UIFont(name: self.fontName, size: size) ?? _font);
		};
		return self;
	};
	func attr(size: CGFloat, weight: UIFont.Weight,_ target: __attr_target) 			-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.font, UIFont.systemFont(ofSize: size, weight: weight));
		} else {
			self.attrPlh = setPlhValue(.font, UIFont.systemFont(ofSize: size, weight: weight));
		};
		return self;
	};
	func attr(weight: UIFont.Weight,_ target: __attr_target) 											-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.font, UIFont.systemFont(ofSize: self.fontSize, weight: weight));
		} else {
			self.attrPlh = setPlhValue(.font, UIFont.systemFont(ofSize: self.fontSize, weight: weight));
		};
		return self;
	};
	func attr(italic size: CGFloat,_ target: __attr_target) 											-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.font, UIFont.italicSystemFont(ofSize: size));
		} else {
			self.attrPlh = setPlhValue(.font, UIFont.italicSystemFont(ofSize: size));
		};
		return self;
	};
	func attr(clr: UIColor,_ target: __attr_target) 															-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.foregroundColor, clr);
		} else {
			self.attrPlh = setPlhValue(.foregroundColor, clr);
		};
		return self;
	};
	func attr(hex: String,_ target: __attr_target) 																-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.foregroundColor, UIColor(hex: hex));
		} else {
			self.attrPlh = setPlhValue(.foregroundColor, UIColor(hex: hex));
		};
		return self;
	};
	func attr(rgb: String,_ target: __attr_target) 																-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.foregroundColor, UIColor(rgb: rgb));
		} else {
			self.attrPlh = setPlhValue(.foregroundColor, UIColor(rgb: rgb));
		};
		return self;
	};
	func attr(bgClr: UIColor,_ target: __attr_target) 														-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.backgroundColor, bgClr);
		} else {
			self.attrPlh = setPlhValue(.backgroundColor, bgClr);
		};
		return self;
	};
	func attr(bgHex: String,_ target: __attr_target) 															-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.backgroundColor, UIColor(hex: bgHex));
		} else {
			self.attrPlh = setPlhValue(.backgroundColor, UIColor(hex: bgHex));
		};
		return self;
	};
	func attr(bgRgb: String,_ target: __attr_target) 															-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.backgroundColor, UIColor(rgb: bgRgb));
		} else {
			self.attrPlh = setPlhValue(.backgroundColor, UIColor(rgb: bgRgb));
		};
		return self;
	};
	func attr(charSpacing: Float,_ target: __attr_target) 												-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.kern, charSpacing);
		} else {
			self.attrPlh = setPlhValue(.kern, charSpacing);
		};
		return self;
	};
	func attr(strike: NSUnderlineStyle,_ target: __attr_target) 									-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.strikethroughStyle, NSNumber(value: strike.rawValue));
		} else {
			self.attrPlh = setPlhValue(.strikethroughStyle, NSNumber(value: strike.rawValue));
		};
		return self;
	};
	func attr(strikeClr: UIColor,_ target: __attr_target) 												-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.strikethroughColor, strikeClr);
		} else {
			self.attrPlh = setPlhValue(.strikethroughColor, strikeClr);
		};
		return self;
	};
	func attr(under: NSUnderlineStyle,_ target: __attr_target) 										-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.underlineStyle, NSNumber(value: under.rawValue));
		} else {
			self.attrPlh = setPlhValue(.underlineStyle, NSNumber(value: under.rawValue));
		};
		return self;
	};
	func attr(underClr: UIColor,_ target: __attr_target) 													-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.underlineColor, underClr);
		} else {
			self.attrPlh = setPlhValue(.underlineColor, underClr);
		};
		return self;
	};
	func attr(stokeW: CGFloat,_ target: __attr_target) 														-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.strokeWidth, stokeW);
		} else {
			self.attrPlh = setPlhValue(.strokeWidth, stokeW);
		};
		return self;
	};
	func attr(stokeClr: UIColor,_ target: __attr_target) 													-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.strokeColor, stokeClr);
		} else {
			self.attrPlh = setPlhValue(.strokeColor, stokeClr);
		};
		return self;
	};
	func attr(offset: CGFloat,_ target: __attr_target) 														-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.baselineOffset, offset);
		} else {
			self.attrPlh = setPlhValue(.baselineOffset, offset);
		};
		return self;
	};
	func attr(url: String,_ target: __attr_target) 																-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.link, url);
		} else {
			self.attrPlh = setPlhValue(.link, url);
		};
		return self;
	};
	func attr(url: URL,_ target: __attr_target) 																	-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.link, url);
		} else {
			self.attrPlh = setPlhValue(.link, url);
		};
		return self;
	};
	func attr(oblique: CGFloat,_ target: __attr_target) 													-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.obliqueness, oblique > 1 ? 1 : oblique);
		} else {
			self.attrPlh = setPlhValue(.obliqueness, oblique > 1 ? 1 : oblique);
		};
		return self;
	};
	func attr(expand: CGFloat,_ target: __attr_target) 														-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.expansion, expand);
		} else {
			self.attrPlh = setPlhValue(.expansion, expand);
		};
		return self;
	};
	func attr(effect: NSAttributedString.TextEffectStyle,_ target: __attr_target) -> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.textEffect, effect);
		} else {
			self.attrPlh = setPlhValue(.textEffect, effect);
		};
		return self;
	};
	func attr(vert: Bool,_ target: __attr_target) 																-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrKeyValue(.verticalGlyphForm, vert);
		} else {
			self.attrPlh = setPlhValue(.verticalGlyphForm, vert);
		};
		return self;
	};
	
	func attr(align: NSTextAlignment,_ target: __attr_target) 	-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrParaStyle({ style in style.alignment = align; });
		} else {
			self.attrPlh = setPlhStyle({ style in style.alignment = align; });
		};
		return self;
	};
	func attr(wrap: NSLineBreakMode,_ target: __attr_target) 		-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrParaStyle({ style in style.lineBreakMode = wrap; });
		} else {
			self.attrPlh = setPlhStyle({ style in style.lineBreakMode = wrap; });
		};
		return self;
	};
	func attr(lineSpacing: CGFloat,_ target: __attr_target) 		-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrParaStyle({ style in style.lineSpacing = lineSpacing; });
		} else {
			self.attrPlh = setPlhStyle({ style in style.lineSpacing = lineSpacing; });
		};
		return self;
	};
	func attr(paraSpacing: CGFloat,_ target: __attr_target) 		-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrParaStyle({ style in style.paragraphSpacing = paraSpacing; });
		} else {
			self.attrPlh = setPlhStyle({ style in style.paragraphSpacing = paraSpacing; });
		};
		return self;
	};
	func attr(firstIndent: CGFloat,_ target: __attr_target) 		-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrParaStyle({ style in style.firstLineHeadIndent = firstIndent; });
		} else {
			self.attrPlh = setPlhStyle({ style in style.firstLineHeadIndent = firstIndent; });
		};
		return self;
	};
	func attr(headIndent: CGFloat,_ target: __attr_target) 			-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrParaStyle({ style in style.headIndent = headIndent; });
		} else {
			self.attrPlh = setPlhStyle({ style in style.headIndent = headIndent; });
		};
		return self;
	};
	func attr(tailIndent: CGFloat,_ target: __attr_target) 			-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrParaStyle({ style in style.tailIndent = tailIndent; });
		} else {
			self.attrPlh = setPlhStyle({ style in style.tailIndent = tailIndent; });
		};
		return self;
	};
	func attr(minH: CGFloat,_ target: __attr_target) 						-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrParaStyle({ style in style.minimumLineHeight = minH; });
		} else {
			self.attrPlh = setPlhStyle({ style in style.minimumLineHeight = minH; });
		};
		return self;
	};
	func attr(maxH: CGFloat,_ target: __attr_target) 						-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrParaStyle({ style in style.maximumLineHeight = maxH; });
		} else {
			self.attrPlh = setPlhStyle({ style in style.maximumLineHeight = maxH; });
		};
		return self;
	};
	func attr(dir: NSWritingDirection,_ target: __attr_target) 	-> UITextField {
		if (target == .text) {
			self.attrTxt = setAttrParaStyle({ style in style.baseWritingDirection = dir; });
		} else {
			self.attrPlh = setPlhStyle({ style in style.baseWritingDirection = dir; });
		};
		return self;
	};

	private func setAttrKeyValue(_ key: NSAttributedString.Key?,_ value: Any) -> NSAttributedString {
		let oldtxt = self.attrTxt;
		if (oldtxt.length > 0) {
			let attr = oldtxt.attributes(at: 0, effectiveRange: nil);
			let newTxt = (key == nil) ? NSAttributedString(string: value as? String ?? "") : oldtxt;
			let new = NSMutableAttributedString(attributedString: newTxt);
			if (attr.count != 0) {
				attr.forEach { (key: NSAttributedString.Key, value: Any) in
					if (key != .paragraphStyle) {
						new.addAttribute(key, value: value, range: NSRange(location: 0, length: new.length));
					};
				};
			};
			if let key = key {
				new.addAttribute(key, value: value, range: NSRange(location: 0, length: new.length));
			};
			return new;
		} else {
			let newTxt = NSMutableAttributedString(string: key == nil ? value as? String ?? "" : "");
			let new = NSMutableAttributedString(attributedString: newTxt);
			if let key = key {
				new.addAttribute(key, value: value, range: NSRange(location: 0, length: new.length));
			};
			return new;
		};
	};
	private func setAttrParaStyle(_ void: (NSMutableParagraphStyle) -> Void) -> NSAttributedString {
		let txt = self.attrTxt;
		if (txt.length > 0) {
			let attr = txt.attributes(at: 0, effectiveRange: nil);
			let new = NSMutableAttributedString(attributedString: txt);
			if (attr.count != 0) {
				attr.forEach { (key: NSAttributedString.Key, value: Any) in
					if (key != .paragraphStyle) {
						new.addAttribute(key, value: value, range: NSRange(location: 0, length: new.length));
					};
				};
			};
			if let style = attr[NSAttributedString.Key.paragraphStyle] as? NSMutableParagraphStyle {
				void(style);
				new.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: new.length))
			}
			else {
				let style = NSMutableParagraphStyle();
				void(style);
				new.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: new.length));
			};
			return new;
		} else {
			let newTxt = NSMutableAttributedString(string: "");
			let new = NSMutableAttributedString(attributedString: newTxt);
			let style = NSMutableParagraphStyle();
			void(style);
			new.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: new.length));
			return new;
		};
	};

	private func setPlhValue(_ key: NSAttributedString.Key?,_ value: Any) -> NSAttributedString {
		let oldtxt = self.attrPlh;
		let attr = oldtxt.attributes(at: 0, effectiveRange: nil);
		let newTxt = (key == nil) ? NSAttributedString(string: value as? String ?? "") : oldtxt;
		let new = NSMutableAttributedString(attributedString: newTxt);
		if (attr.count != 0) {
			attr.forEach { (key: NSAttributedString.Key, value: Any) in
				if (key != .paragraphStyle) {
					new.addAttribute(key, value: value, range: NSRange(location: 0, length: new.length));
				};
			};
		};
		if let key = key {
			new.addAttribute(key, value: value, range: NSRange(location: 0, length: new.length));
		};
		return new;
	};
	private func setPlhStyle(_ void: (NSMutableParagraphStyle) -> Void) -> NSAttributedString {
		let txt = self.attrPlh;
		let attr = txt.attributes(at: 0, effectiveRange: nil);
		let new = NSMutableAttributedString(attributedString: txt);
		if (attr.count != 0) {
			attr.forEach { (key: NSAttributedString.Key, value: Any) in
				if (key != .paragraphStyle) {
					new.addAttribute(key, value: value, range: NSRange(location: 0, length: new.length));
				};
			};
		};
		if let style = attr[NSAttributedString.Key.paragraphStyle] as? NSMutableParagraphStyle {
			void(style);
			new.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: new.length))
		}
		else {
			let style = NSMutableParagraphStyle();
			void(style);
			new.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: new.length));
		};
		return new;
	};
};

extension UITextView {

	var fontName	: String 	{ get { return self.font?.fontName == ".SFUI-Regular" ? "Helvetica" : self.font?.fontName ?? "Helvetica" } };
	var fontSize	: CGFloat { get { return self.font?.pointSize ?? UILabel().fontSize } };
	var fontWeight: UIFont.Weight {
		get {
			let descriptor 	= self.font?.fontDescriptor;
			let attributes 	= descriptor?.fontAttributes;
			let fontWeight 	= attributes?[.traits] as? [UIFontDescriptor.TraitKey: Any];
			let weight 			= fontWeight?[.weight] as? CGFloat ?? UIFont.Weight.regular.rawValue;
			return UIFont.Weight(rawValue: weight);
		}
	};

	var attrTxt: NSAttributedString { get { return self.attributedText ?? NSAttributedString(string: self.text ?? "") } set { self.attributedText = newValue } };

	func attr(txt: String, clr: UIColor) 													-> UITextView { self.attr(txt: txt).attr(clr: clr); };
	func attr(txt: String, hex: String) 													-> UITextView { self.attr(txt: txt).attr(hex: hex); };
	func attr(txt: String, rgb: String) 													-> UITextView { self.attr(txt: txt).attr(rgb: rgb); };
	func attr(txt: String, clr: UIColor, align: NSTextAlignment) 	-> UITextView { self.attr(txt: txt).attr(clr: clr).attr(align: align); };
	func attr(txt: String, hex: String, align: NSTextAlignment) 	-> UITextView { self.attr(txt: txt).attr(hex: hex).attr(align: align); };
	func attr(txt: String, rgb: String, align: NSTextAlignment) 	-> UITextView { self.attr(txt: txt).attr(rgb: rgb).attr(align: align); };

	func attr(txt: String) 																-> UITextView { self.attrTxt = setAttrKeyValue(nil, txt); return self; };
	func attr(ligature: Bool) 														-> UITextView { self.attrTxt = setAttrKeyValue(.ligature, ligature); return self; };
	func attr(font: UIFont) 															-> UITextView { self.attrTxt = setAttrKeyValue(.font, font); return self; };
	func attr(name: String, size: CGFloat) 								-> UITextView { self.attrTxt = setAttrKeyValue(.font, UIFont(name: name, size: size) ?? _font); return self; };
	func attr(name: String) 															-> UITextView { self.attrTxt = setAttrKeyValue(.font, UIFont(name: name, size: self.fontSize) ?? _font); return self; };
	func attr(size: CGFloat) 															-> UITextView { self.attrTxt = setAttrKeyValue(.font, UIFont(name: self.fontName, size: size) ?? _font); return self; };
	func attr(size: CGFloat, weight: UIFont.Weight) 			-> UITextView { self.attrTxt = setAttrKeyValue(.font, UIFont.systemFont(ofSize: size, weight: weight)); return self; };
	func attr(weight: UIFont.Weight) 											-> UITextView { self.attrTxt = setAttrKeyValue(.font, UIFont.systemFont(ofSize: self.fontSize, weight: weight)); return self; };
	func attr(italic size: CGFloat) 											-> UITextView { self.attrTxt = setAttrKeyValue(.font, UIFont.italicSystemFont(ofSize: size)); return self; };
	func attr(clr: UIColor) 															-> UITextView { self.attrTxt = setAttrKeyValue(.foregroundColor, clr); return self; };
	func attr(hex: String) 																-> UITextView { self.attrTxt = setAttrKeyValue(.foregroundColor, UIColor(hex: hex)); return self; };
	func attr(rgb: String) 																-> UITextView { self.attrTxt = setAttrKeyValue(.foregroundColor, UIColor(rgb: rgb)); return self; };
	func attr(bgClr: UIColor) 														-> UITextView { self.attrTxt = setAttrKeyValue(.backgroundColor, bgClr); return self; };
	func attr(bgHex: String) 															-> UITextView { self.attrTxt = setAttrKeyValue(.backgroundColor, UIColor(hex: bgHex)); return self; };
	func attr(bgRgb: String) 															-> UITextView { self.attrTxt = setAttrKeyValue(.backgroundColor, UIColor(rgb: bgRgb)); return self; };
	func attr(charSpacing: Float) 												-> UITextView { self.attrTxt = setAttrKeyValue(.kern, charSpacing); return self; };
	func attr(strike: NSUnderlineStyle) 									-> UITextView { self.attrTxt = setAttrKeyValue(.strikethroughStyle, NSNumber(value: strike.rawValue)); return self; };
	func attr(strikeClr: UIColor) 												-> UITextView { self.attrTxt = setAttrKeyValue(.strikethroughColor, strikeClr); return self; };
	func attr(under: NSUnderlineStyle) 										-> UITextView { self.attrTxt = setAttrKeyValue(.underlineStyle, NSNumber(value: under.rawValue)); return self; };
	func attr(underClr: UIColor) 													-> UITextView { self.attrTxt = setAttrKeyValue(.underlineColor, underClr); return self; };
	func attr(stokeW: CGFloat) 														-> UITextView { self.attrTxt = setAttrKeyValue(.strokeWidth, stokeW); return self; };
	func attr(stokeClr: UIColor) 													-> UITextView { self.attrTxt = setAttrKeyValue(.strokeColor, stokeClr); return self; };
	func attr(offset: CGFloat) 														-> UITextView { self.attrTxt = setAttrKeyValue(.baselineOffset, offset); return self; };
	func attr(url: String) 																-> UITextView { self.attrTxt = setAttrKeyValue(.link, url); return self; };
	func attr(url: URL) 																	-> UITextView { self.attrTxt = setAttrKeyValue(.link, url); return self; };
	func attr(oblique: CGFloat) 													-> UITextView { self.attrTxt = setAttrKeyValue(.obliqueness, oblique > 1 ? 1 : oblique); return self; };
	func attr(expand: CGFloat) 														-> UITextView { self.attrTxt = setAttrKeyValue(.expansion, expand); return self; };
	func attr(effect: NSAttributedString.TextEffectStyle) -> UITextView { self.attrTxt = setAttrKeyValue(.textEffect, effect); return self; };
	func attr(vert: Bool) 																-> UITextView { self.attrTxt = setAttrKeyValue(.verticalGlyphForm, vert); return self; };

	func attr(align: NSTextAlignment) 	-> UITextView { self.attrTxt = setAttrParaStyle({ style in style.alignment = align; }); return self; };
	func attr(wrap: NSLineBreakMode) 		-> UITextView { self.attrTxt = setAttrParaStyle({ style in style.lineBreakMode = wrap; }); return self; };
	func attr(lineSpacing: CGFloat) 		-> UITextView { self.attrTxt = setAttrParaStyle({ style in style.lineSpacing = lineSpacing; }); return self; };
	func attr(paraSpacing: CGFloat) 		-> UITextView { self.attrTxt = setAttrParaStyle({ style in style.paragraphSpacing = paraSpacing; }); return self; };
	func attr(firstIndent: CGFloat) 		-> UITextView { self.attrTxt = setAttrParaStyle({ style in style.firstLineHeadIndent = firstIndent; }); return self; };
	func attr(headIndent: CGFloat) 			-> UITextView { self.attrTxt = setAttrParaStyle({ style in style.headIndent = headIndent; }); return self; };
	func attr(tailIndent: CGFloat) 			-> UITextView { self.attrTxt = setAttrParaStyle({ style in style.tailIndent = tailIndent; }); return self; };
	func attr(minH: CGFloat) 						-> UITextView { self.attrTxt = setAttrParaStyle({ style in style.minimumLineHeight = minH; }); return self; };
	func attr(maxH: CGFloat) 						-> UITextView { self.attrTxt = setAttrParaStyle({ style in style.maximumLineHeight = maxH; }); return self; };
	func attr(dir: NSWritingDirection) 	-> UITextView { self.attrTxt = setAttrParaStyle({ style in style.baseWritingDirection = dir; }); return self; };

	private func setAttrKeyValue(_ key: NSAttributedString.Key?,_ value: Any) -> NSAttributedString {
		let oldtxt = self.attrTxt;
		if (oldtxt.length > 0) {
			let attr = oldtxt.attributes(at: 0, effectiveRange: nil);
			let newTxt = (key == nil) ? NSAttributedString(string: value as? String ?? "") : oldtxt;
			let new = NSMutableAttributedString(attributedString: newTxt);
			if (attr.count != 0) {
				attr.forEach { (key: NSAttributedString.Key, value: Any) in
					if (key != .paragraphStyle) {
						new.addAttribute(key, value: value, range: NSRange(location: 0, length: new.length));
					};
				};
			};
			if let key = key {
				new.addAttribute(key, value: value, range: NSRange(location: 0, length: new.length));
			};
			return new;
		} else {
			let newTxt = NSMutableAttributedString(string: key == nil ? value as? String ?? "" : "");
			let new = NSMutableAttributedString(attributedString: newTxt);
			if let key = key {
				new.addAttribute(key, value: value, range: NSRange(location: 0, length: new.length));
			};
			return new;
		};
	};
	private func setAttrParaStyle(_ void: (NSMutableParagraphStyle) -> Void) -> NSAttributedString {
		let txt = self.attrTxt;
		if (txt.length > 0) {
			let attr = txt.attributes(at: 0, effectiveRange: nil);
			let new = NSMutableAttributedString(attributedString: txt);
			if (attr.count != 0) {
				attr.forEach { (key: NSAttributedString.Key, value: Any) in
					if (key != .paragraphStyle) {
						new.addAttribute(key, value: value, range: NSRange(location: 0, length: new.length));
					};
				};
			};
			if let style = attr[NSAttributedString.Key.paragraphStyle] as? NSMutableParagraphStyle {
				void(style);
				new.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: new.length))
			}
			else {
				let style = NSMutableParagraphStyle();
				void(style);
				new.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: new.length));
			};
			return new;
		} else {
			let newTxt = NSMutableAttributedString(string: "");
			let new = NSMutableAttributedString(attributedString: newTxt);
			let style = NSMutableParagraphStyle();
			void(style);
			new.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: new.length));
			return new;
		};
	};
};

