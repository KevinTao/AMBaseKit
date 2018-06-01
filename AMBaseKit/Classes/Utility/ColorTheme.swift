//
//  ColorTheme.swift
//  AFNetworking
//
//  Created by tom on 2018/5/30.
//

import UIKit

public class ColorTheme: NSObject {
    public var background:UIColor?
    public var tint:UIColor?
    public var main:UIColor?
    public var seperator:UIColor?
    public var textLight:UIColor?
    public var textDark:UIColor?
    
    public override init() {
        super.init()
    }
    
    public convenience init(from theme:Dictionary<String,String>){
        self.init()
        self.background = UIColor.init(hex:theme["background"]!)
        self.seperator = UIColor.init(hex: theme["seperator"]!)
        self.textDark = UIColor.init(hex: theme["textDark"]!)
        self.tint = UIColor.init(hex: theme["tint"]!)
        self.main = UIColor.init(hex: theme["main"]!)
    }
}
