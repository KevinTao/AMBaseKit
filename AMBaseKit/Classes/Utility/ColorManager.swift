//
//  ColorManager.swift
//  AFNetworking
//
//  Created by tom on 2018/5/29.
//

import UIKit

extension UIColor {
    
    var toHexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return String(
            format: "%02X%02X%02X",
            Int(r * 0xff),
            Int(g * 0xff),
            Int(b * 0xff)
        )
    }
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
}

public class ColorConfiguration: NSObject {
    var themeChange:((String)->Void)?
    var sourcePath:String?
    public var theme:String = "default"{
        didSet{
            if let change = themeChange{
                change(theme)
            }
        }
    }
    var cachePath:String
    let bundlePath = Bundle.init(for: ColorConfiguration.self).path(forResource: "AMColorKit.bundle/Colors", ofType: "plist")!
    
    public override init() {
        let manager = FileManager.default
        let documentURL = manager.urls(for: .documentDirectory, in: .userDomainMask).last
        self.cachePath = documentURL!.appendingPathComponent("Colors.cache").path
        super.init()
    }
    
    public convenience init(cacheName:String,customPath:String?) {
        self.init()
        let manager = FileManager.default
        let documentURL = manager.urls(for: .documentDirectory, in: .userDomainMask).last
        self.cachePath = documentURL!.appendingPathComponent(cacheName).path
        self.sourcePath = customPath
    }
}


public class ColorManager: NSObject {
    
    var palette:Dictionary<String,[String:String]>?
    public var theme:ColorTheme?
    public var configuration:ColorConfiguration = ColorConfiguration.init(){
        didSet{
                self.update()
                configuration.themeChange = { (name:String) in
                self.theme = ColorTheme.init(from: self.palette![name]!)
                //TODO: Notificate all views
            }
        }
    }
    public static let `default` = ColorManager()
    
    public override init() {
        super.init()
        self.update()
        self.configuration.themeChange = { (name:String) in
            self.theme = ColorTheme.init(from: self.palette![name]!)
            //TODO: Notificate all views
        }
    }
    
    func update(){
        let manager = FileManager.default
        if !manager.fileExists(atPath: self.configuration.cachePath){
            do{
                if let path = self.configuration.sourcePath{
                    try manager.moveItem(atPath: path, toPath: self.configuration.cachePath)
                }else{
                    try manager.moveItem(atPath: self.configuration.bundlePath, toPath: self.configuration.cachePath)
                }
            }catch{
                print(error)
            }
            //                if colors!.write(to: URL.init(fileURLWithPath:fpath), atomically: true){
            //                    print("SUCCESS")
            //                }else{
            //                    print("FAILD")
            //                }
        }
        self.palette = NSDictionary.init(contentsOfFile: self.configuration.cachePath) as? Dictionary
        self.theme = ColorTheme.init(from: self.palette![self.configuration.theme]!)
    }
}
