//
//  gradientButton.swift
//  Meetsy
//
//  Created by APPLE on 18/08/22.
//


import Foundation
import UIKit


class gradientButton: UIButton{
   
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: self.frame.size)
        gradient.colors = [hexStringToUIColor(hex: "#14B8A6"),hexStringToUIColor(hex: "#3B82F6")]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        let shape = CAShapeLayer()
        shape.lineWidth = 12
        
        //shape.path = UIBezierPath(rect: self.bounds).cgPath
        shape.path = UIBezierPath(roundedRect: self.layer.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        
        gradient.mask = shape
        self.layer.addSublayer(gradient)
        
        
        
        
        //self.layer.borderColor = UIColor.black.cgColor
//        self.addBorderGradient(to: self, startColor: hexStringToUIColor(hex: "#14B8A6"), endColor: hexStringToUIColor(hex: "#3B82F6"), lineWidth: 2.0, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1))
//
    }
    
    func addBorderGradient(to view: UIView, startColor:UIColor, endColor: UIColor, lineWidth: CGFloat, startPoint: CGPoint, endPoint: CGPoint) {
    
    //This will hide the part outside of border, so that it would look like circle
    view.clipsToBounds = true
    //Create object of CAGradientLayer
    let gradient = CAGradientLayer()
    //Assign origin and size of gradient so that it will fit exactly over circular view
    gradient.frame = view.bounds
    //Pass the gredient colors list to gradient object
    gradient.colors = [startColor.cgColor, endColor.cgColor]
    //Point from where gradient should start
    gradient.startPoint = startPoint
    //Point where gradient should end
    gradient.endPoint = endPoint
    //Now we have to create a circular shape so that it can be added to view’s layer
    let shape = CAShapeLayer()
    //Width of circular line
    shape.lineWidth = lineWidth
    //Create circle with center same as of center of view, with radius equal to half height of view, startAngle is the angle from where circle should start, endAngle is the angle where circular path should end
    shape.path = UIBezierPath(
    arcCenter: CGPoint(x: view.bounds.height/2,
    y: view.bounds.height/2),
    radius: view.bounds.height/2,
    startAngle: CGFloat(0),
    endAngle:CGFloat(CGFloat.pi * 2),
    clockwise: true).cgPath
    //the color to fill the path’s stroked outline
    shape.strokeColor = UIColor.black.cgColor
    //The color to fill the path
    shape.fillColor = UIColor.clear.cgColor
    //Apply shape to gradient layer, this will create gradient with circular border
    gradient.mask = shape
    //Finally add the gradient layer to out View
    view.layer.addSublayer(gradient)
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}
