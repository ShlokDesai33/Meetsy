//
//  profilePageController.swift
//  LINK
//
//  Created by APPLE on 02/06/22.
//Controller for profile page which displays QRCode

import Foundation

import UIKit

import CoreImage.CIFilterBuiltins

class ProfilePageController: UIViewController {
    
    //Connection to all outlets
    @IBOutlet weak var scanButton: UIButton!
    
    @IBOutlet weak var qrCode: UIImageView!
    
    @IBOutlet weak var userProfileLabel: UILabel!
    
    var qrcodeImage: CIImage!
    
    //Back button to dismiss the presented viewcontroller
    @IBAction func backButton(_ sender: Any) {
        
        dismiss(animated: false)
    }
    //Present the scanCode page
    @IBAction func presentCamera(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ScanCodeController") as! ScanCodeController

        vc.modalPresentationStyle = .fullScreen

        present(vc, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let userId = UDM.shared.getUserId()
        let url = "https://meetsy-alpha.vercel.app/yaj456"
        
        // url to be transmitted using qr code
       // let url = "https://owlapp.in"
        // convert text to data
        let data = url.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
        // get QR Code generating filter
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        // set up filter
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("Q", forKey: "inputCorrectionLevel")
        
        // generate the QR Code
        qrcodeImage = filter?.outputImage
        // convert CIImage to UIImageView
        displayQRCodeImage()
        
    }
    
    func displayQRCodeImage() {
        
        let scaleX = qrCode.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = qrCode.frame.size.height / qrcodeImage.extent.size.height
     
        let transformedImage = qrcodeImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
     
        qrCode.image = UIImage(ciImage: transformedImage)

     
    }
    

    
}
