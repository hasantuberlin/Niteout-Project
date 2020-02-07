//
//  ActivityIndicatorWrapper.swift
//  Niteout
//
//  Created by hamza Ahmed on 14.11.19.
//  Copyright © 2019 Hamza. All rights reserved.
//

import UIKit
import Foundation
import NVActivityIndicatorView

class ActivityIndicator{
   //   private static var activityFrame : CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
   //   private static var activityIndicatorView : NVActivityIndicatorView!
   //   static func show(){
   //      activityIndicatorView = NVActivityIndicatorView(frame: activityFrame,
   //                                                      type: .ballRotateChase)
   //      activityIndicatorView.startAnimating()
   //
   //   }
   //   static func hide(){
   //      activityIndicatorView.stopAnimating()
   //   }
   static var shared = ActivityIndicator()
   private init(){}
   public func showSpinner(_ customView: UIView?, title : String?) {
      
      var window = customView
      
      if (window == nil) {
         window = returnTopWindow()
      }
      if ((window?.viewWithTag(spinnerViewConfig.tag)) != nil) {
         return
      }
//      let progressHUD = MBProgressHUD(view: window!)
//      progressHUD.label.text = title ?? ""
//      progressHUD.label.textColor = UIColor.white
//      progressHUD.mode = .annularDeterminate
//      progressHUD.show(animated: true)
      
      
      //background view
      let backgroundView = UIView(frame: CGRect.zero)
      backgroundView.tag = spinnerViewConfig.tag
      backgroundView.translatesAutoresizingMaskIntoConstraints = false
      backgroundView.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
      window?.addSubview(backgroundView)
      window?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[backgroundView]|", options: [], metrics: nil, views: ["backgroundView" : backgroundView]))
      window?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[backgroundView]|", options: [], metrics: nil, views: ["backgroundView" : backgroundView]))

      //spinner
      let activityIndicator = UIActivityIndicatorView(style: .large)
      activityIndicator.color = spinnerViewConfig.color
      activityIndicator.translatesAutoresizingMaskIntoConstraints = false
      activityIndicator.startAnimating()

      let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
      titleLabel.text = title ?? "Hello"
      titleLabel.textColor = UIColor.white

      backgroundView.addSubview(activityIndicator)
      backgroundView.addConstraint(NSLayoutConstraint(item: backgroundView, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1.0, constant: 0.0))
      backgroundView.addConstraint(NSLayoutConstraint(item: backgroundView, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1.0, constant: 0.0))
//
//      backgroundView.addConstraint(NSLayoutConstraint(item: backgroundView, attribute: .centerX, relatedBy: .equal, toItem: titleLabel, attribute: .centerX, multiplier: 1.0, constant: 0.0))
//      backgroundView.addConstraint(NSLayoutConstraint(item: backgroundView, attribute: .centerY, relatedBy: .equal, toItem: titleLabel, attribute: .centerY, multiplier: 1.0, constant: 30.0))
   }
   
   //hide spinner
   public func hideSpinner() {
      if let window: UIWindow = returnTopWindow(){
//      MBProgressHUD.hide(for: window, animated: true)//hideAllHUDs(for: window!, animated: true)

      window.viewWithTag(spinnerViewConfig.tag)?.removeFromSuperview()
      }
   }
   //spinner
   struct spinnerViewConfig {
      static let tag: Int = 98272
      static let color = UIColor.white
   }
   
   //return top window
   func returnTopWindow() -> UIWindow {
      
      let windows: [UIWindow] = UIApplication.shared.windows
      
      for topWindow: UIWindow in windows {
         if topWindow.windowLevel == UIWindow.Level.normal {
            return topWindow
         }
      }
      return UIApplication.shared.windows.first { $0.isKeyWindow }!
      
      
   }
}

protocol Bluring {
    func addBlur(_ alpha: CGFloat)
}

extension Bluring where Self: UIView {
    func addBlur(_ alpha: CGFloat = 0.5) {
        // create effect
        let effect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: effect)

        // set boundry and alpha
        effectView.frame = self.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = alpha

        self.addSubview(effectView)
    }
}
extension UIView: Bluring {}
