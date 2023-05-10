//
//  qrcodeViewController.swift
//  firebase-messager-ios
//
//  Created by Pardn on 2023/5/8.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseAuth

class qrcodeVC: UIViewController {

	var qrcodeView: UIImageView!
	var hintLabel:  UILabel!
	var buttonStackView: UIStackView!
	var shareButton: UIButton!
	var downloadButton: UIButton!
	var scannerButton: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad();

		let isDark = traitCollection.userInterfaceStyle == .dark;

		let uid = Auth.auth().currentUser?.uid ?? ""

		qrcodeView = UIImageView(0, 0, vw - 120, vw - 120)
			.img(generateBarCode128(barCodeStr: uid, barCodeSize: CGSize(vw - 120, vw - 120)), mode: .scaleAspectFill)
			.radius(20)
			.clip(view: true)

		hintLabel = UILabel(0, 0, vw, 30)
			.text(uid, color: _darkGray, align: .center, row: 1, wrap: .byClipping)

		buttonStackView = UIStackView(axis: .horz, align: .left, gap: 30);

		shareButton = UIButton()
			.text(color: .black)
			.img(UIImage(sys: "square.and.arrow.up.on.square"))
			.bg(color: .white)
			.radius(20)
			.Weq(40)
			.Heq(40);

		downloadButton = UIButton()
			.text(color: .black)
			.img(UIImage(sys: "tray.and.arrow.down"))
			.bg(color: .white)
			.radius(20)
			.Weq(40)
			.Heq(40);

		scannerButton = UIButton()
			.text("掃描條碼", color: .black)
			.img(UIImage(sys: "qrcode.viewfinder"), align: .left, gap: 10)
			.bg(color: .white)

		_=view
			.child([
				UIVisualEffectView(style: isDark ? .dark : .extraLight)
					.frame(0, 0, vw, vh),
				qrcodeView,
				hintLabel,
				buttonStackView
					.child([
						shareButton,
						downloadButton
					]),
				scannerButton
			])

		_=qrcodeView
			.Xeq(X: view)
			.Teq(T: view, 80)
			.Weq(vw - 120)
			.Heq(vw - 120);

		_=hintLabel
			.Xeq(X: view)
			.Teq(B: qrcodeView, 10)
			.Weq(vw);

		_=buttonStackView
			.Xeq(X: view)
			.Teq(B: hintLabel, 40);

		_=scannerButton
			.Xeq(X: view)
			.Beq(B: view, -60)
			.Weq(vw - 120)
			.Heq(40)

	};

	func generateBarCode128(barCodeStr:String, barCodeSize:CGSize) -> UIImage? {
		//将传入的string转成nsstring，再编码
		let stringData = barCodeStr.data(using: .utf8)


		//系统自带能生成的码
		//        CIAztecCodeGenerator 二维码
		//        CICode128BarcodeGenerator 条形码
		//        CIPDF417BarcodeGenerator
		//        CIQRCodeGenerator     二维码
		let qrFilter = CIFilter(name: "CIQRCodeGenerator")
		qrFilter?.setDefaults()
		qrFilter?.setValue(stringData, forKey: "inputMessage")

		let outputImage:CIImage? = qrFilter?.outputImage

		/*
		 生成的条形码需要对其进行消除模糊处理，本文提供两种方法消除模糊，其原理都是放大条码，但项目中需要在条码底部加上条码内容文字，使用其方法一会模糊并变小文字，所以使用方法二，需要各位去研究下原因哈。。。

		 */


		// 消除模糊方法一
		//        let context = CIContext()
		//        let cgImage = context.createCGImage(outputImage!, fromRect: outputImage!.extent)

		//        let image = UIImage(CGImage: cgImage, scale: 1.0, orientation: UIImageOrientation.Up)
		//
		//        // Resize without interpolating
		//        let scaleRate:CGFloat = 20.0
		//        let resized = resizeImage(addText(image), quality: CGInterpolationQuality.None, rate: scaleRate)

		// 消除模糊方法二
		let scaleX:CGFloat = barCodeSize.width/outputImage!.extent.size.width; // extent 返回图片的frame
		let scaleY:CGFloat = barCodeSize.height/outputImage!.extent.size.height;
		let resultImage = outputImage?.transformed(by: CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY))
		let image = UIImage(ciImage: resultImage!)

		return image //addText(image,textName: barCodeStr);
	}

//	private func getQRCode(id: String) -> UIImage? {
//		let filter1 = CIFilter.qrCodeGenerator();
//		filter1.setDefaults();
//		filter1.setValue(id.data(using: String.Encoding.ascii), forKey: "inputMessage");
//		filter1.setValue("H", forKey: "inputCorrectionLevel");
//
//		guard let image = filter1.outputImage else { return nil }
//		//, let filter2 = CIFilter(name: "CISourceOverCompositing");
////		guard let logoImage = UIImage(named: "logo")?.cgImage else { return nil; };
////		let logo = CIImage(cgImage: logoImage)
////		let centerTransform = CGAffineTransform(translationX: image.extent.midX - (logo.extent.size.width / 2), y: image.extent.midY - (logo.extent.size.height / 2));
////		filter2.setValue(logo.transformed(by: centerTransform), forKey: "inputImage");
////		filter2.setValue(image, forKey: "inputBackgroundImage");
////
////		guard let result = filter2.outputImage else { return nil };
//		return UIImage(ciImage: image);
////		guard let retultImage  else { return nil };
////		return resultImage
//	};
};
