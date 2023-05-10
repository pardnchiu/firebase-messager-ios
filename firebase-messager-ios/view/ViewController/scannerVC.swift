//
//  scannerVC.swift
//  firebase-messager-ios
//
//  Created by Pardn on 2023/5/10.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase
import AVFoundation

class scannerVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

	var captureSession = AVCaptureSession()
	var videoPreviewLayer: AVCaptureVideoPreviewLayer?
	var qrCodeFrameView: UIView?
	var pause: Bool = false;
	var ref: DatabaseReference!

	override func viewDidLoad() {
		super.viewDidLoad()

		ref = Database.database().reference();

		// 取得後置鏡頭來擷取影片
		guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
			print("Failed to get the camera device")
			return
		}

		do {
			// 使用前一個裝置物件來取得 AVCaptureDeviceInput 類別的實例
			let input = try AVCaptureDeviceInput(device: captureDevice)

			// 在擷取 session 設定輸入裝置
			captureSession.addInput(input)

		} catch {
			// 假如有錯誤產生、單純輸出其狀況不再繼續執行
			print(error)
			return
		}

		// 初始化一個 AVCaptureMetadataOutput 物件並將其設定做為擷取 session 的輸出裝置
		let captureMetadataOutput = AVCaptureMetadataOutput()
		captureSession.addOutput(captureMetadataOutput)

		// 設定委派並使用預設的調度佇列來執行回呼（call back）
		captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
		captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]

		// 初始化影片預覽層，並將其作為子層加入 viewPreview 視圖的圖層中
		videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
		videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
		videoPreviewLayer?.frame = view.layer.bounds
		view.layer.addSublayer(videoPreviewLayer!)

		// 開始影片的擷取
		captureSession.startRunning()

//		//移動訊息標籤與頂部列至上層
//		view.bringSubviewToFront(messageLabel)
//		view.bringSubviewToFront(topbar)

		qrCodeFrameView = UIView()

		if let qrCodeFrameView = qrCodeFrameView {
			qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
			qrCodeFrameView.layer.borderWidth = 2
			view.addSubview(qrCodeFrameView)
			view.bringSubviewToFront(qrCodeFrameView)
		}
	}

	func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
		// 檢查  metadataObjects 陣列為非空值，它至少需包含一個物件
		if metadataObjects.count == 0 {
			qrCodeFrameView?.frame = CGRect.zero
//			messageLabel.text = "No QR code is detected"
			return
		}

		// 取得元資料（metadata）物件
		let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject

		if metadataObj.type == AVMetadataObject.ObjectType.qr {
			// 倘若發現的元資料與 QR code 元資料相同，便更新狀態標籤的文字並設定邊界
			let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
			qrCodeFrameView?.frame = barCodeObject!.bounds

			if metadataObj.stringValue != nil && !pause {
				pause = true;
				var uid = metadataObj.stringValue ?? ""
				ref.child("users").child(uid).observeSingleEvent(of: .value, with: { snap in
					let data = snap.value as? [String:Any] ?? [:];
					let head = data["head"] as? String ?? "";
					let name = data["name"] as? String ?? "";

					print([
						"uid"		: uid,
						"head"	: head,
						"name"	: name,
					]);

				});
//				messageLabel.text = metadataObj.stringValue
			}
		}
	}
}
