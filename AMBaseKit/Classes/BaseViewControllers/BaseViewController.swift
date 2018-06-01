//
//  BaseViewController.swift
//  EGOGym
//
//  Created by tom on 2018/1/26.
//  Copyright © 2018年 ego. All rights reserved.
//

import UIKit
import Jelly

public enum HUDType {
    case none
    case loading
    case text
    case confirm
    case progress
}

open class BaseViewController: UIViewController {
    var jellyAnimator: JellyAnimator?
    var hudViewController:UIViewController?

    override open func viewDidLoad() {
        super.viewDidLoad()
        let backBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "icon_navi_back"), style: .plain, target: self, action: #selector(popBack))
        self.navigationItem.setLeftBarButton(backBarButtonItem, animated: true)
    }

    
    func prepareHUD(size:CGSize?){
        var sizeVC:CGSize = CGSize.init(width: 125, height: 125)
        if size != nil{
            sizeVC = size!
        }
        var customBlurFadeInPresentation = JellyFadeInPresentation(
            backgroundStyle: .dimmed(alpha: 0.6),
            duration:.fast,
            widthForViewController: .custom(value: sizeVC.width),
            heightForViewController: .custom(value: sizeVC.height))
        customBlurFadeInPresentation.isTapBackgroundToDismissEnabled = false
        self.jellyAnimator = JellyAnimator(presentation:customBlurFadeInPresentation)
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setupNavigationBar() {
        if let naviController = self.navigationController{
            naviController.navigationBar.barTintColor = UIColor.clear
            naviController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            naviController.navigationBar.shadowImage = UIImage()
            naviController.navigationBar.isTranslucent = true
            //        naviController.navigationBar.titleTextAttributes = [
            //            NSAttributedStringKey.font: UIFont(name: "GothamPro", size: 20)!,
            //            NSAttributedStringKey.foregroundColor: UIColor.white
            //        ]
        }
    }
    
    @IBAction func popBack(){
        self.navigationController?.popViewController(animated: true)
    }
/*
    func viewController(type:HUDType,message:String?,action:((_ isConfirm:Bool)->Void)?)->UIViewController{
        var viewController:UIViewController? = nil
        switch type {
        case .loading:
            viewController = self.storyboard!.instantiateViewController(withIdentifier: "HUDLoadingController") as? HUDLoadingViewController
            self.prepareHUD(size: nil)
            (viewController as! HUDLoadingViewController).cancelLoading = action
        case .text:
            viewController = self.storyboard!.instantiateViewController(withIdentifier: "HUDTextController") as? HUDAlertViewController
            let size = message!.boundingRect(with: CGSize.init(width: 200, height: 100), font: UIFont.systemFont(ofSize: 16), lines: 2)
            if size.width < 125{
                self.prepareHUD(size: CGSize.init(width: 125, height: 100))
            }else{
                self.prepareHUD(size: CGSize.init(width: size.width+16, height: 100))
            }
            (viewController as! HUDAlertViewController).message = message
        case .confirm:
            viewController = self.storyboard!.instantiateViewController(withIdentifier: "HUDTextController") as? HUDAlertViewController
            let size = message!.boundingRect(with: CGSize.init(width: 200, height: 1250), font: UIFont.systemFont(ofSize: 16), lines: 2)
            if size.width < 200{
                self.prepareHUD(size: CGSize.init(width: 200, height: 125))
            }else{
                self.prepareHUD(size: CGSize.init(width: size.width+16, height: 125))
            }
            (viewController as! HUDAlertViewController).message = message
            (viewController as! HUDAlertViewController).showActions = true
            (viewController as! HUDAlertViewController).confirmAction = action
        default:
            viewController = self.storyboard!.instantiateViewController(withIdentifier: "HUDTextController") as? HUDAlertViewController
        }
        return viewController!
    }
    */
    /*
    func showHUD(type:HUDType,message:String?,hideIn:Double?,action:((_ isConfirm:Bool)->Void)?){
        if self.hudViewController == nil{
            self.hudViewController = self.viewController(type: type, message: message, action: action)
            self.jellyAnimator?.prepare(viewController: self.hudViewController!)
            self.present(self.hudViewController!, animated: true, completion: nil)
            if let delay = hideIn{
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
                    self.hudViewController?.dismiss(animated: true, completion: {
                        self.hudViewController = nil
                    })
                }
            }
        }else{
            self.hideHUD(animate: false) {
                self.hudViewController = self.viewController(type: type, message: message, action: action)
                self.jellyAnimator?.prepare(viewController: self.hudViewController!)
                self.present(self.hudViewController!, animated: true, completion: nil)
                if let delay = hideIn{
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
                        self.hudViewController?.dismiss(animated: true, completion: {
                            self.hudViewController = nil
                        })
                    }
                }
            }
            
        }
    }
    
    func hideHUD(animate:Bool,complete:(()->Void)?){
        self.hudViewController?.dismiss(animated: animate, completion: {
            if let c = complete{
                self.hudViewController = nil
                c()
            }else{
                self.hudViewController = nil
            }
        })
    }
    
    func showLoadingHUD(cancelled:(()->Void)?){
        self.showHUD(type: .loading, message: nil, hideIn: nil, action:{(isFinished:Bool) in
            if !isFinished{
                self.dismiss(animated: true, completion: {
                    self.hudViewController = nil
                    if let c = cancelled{
                        c()
                    }
                })
            }
        })
    }
    
    func showTextHUD(message:String) {
        self.showHUD(type: .text, message: message, hideIn: 2, action: nil)
    }
    
    func showConfirmHUD(message:String,confirmAction: @escaping ((_ isConfirmd:Bool)->Void)){
        self.showHUD(type: .confirm, message: message, hideIn: nil, action: confirmAction)
    }
     */
}
