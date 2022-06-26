//
//  Constant.swift
//  KillTeamApplication
//
//  Created by Apple on 27.03.2022.
//

import Foundation
import UIKit

class Constant {
    
    class Color {
        
       
      //  static let cellBackground = #colorLiteral(red: 0.9058823529, green: 0.8980392157, blue: 0.8784313725, alpha: 1)
      //  static let cellBorder = #colorLiteral(red: 0.9607843137, green: 0.7960784314, blue: 0.6549019608, alpha: 1)
      //  static let cellHeader = #colorLiteral(red: 0.9607843137, green: 0.7960784314, blue: 0.6549019608, alpha: 1)
      //
      //  static let stackViewBackground  = #colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
      //  static let stackView = #colorLiteral(red: 0.8352941176, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
      //
      //  static let viewControllerBackground = #colorLiteral(red: 0.5215686275, green: 0.5725490196, blue: 0.6196078431, alpha: 1)
      //  static let buttonBackground = #colorLiteral(red: 0.9960784314, green: 0.9764705882, blue: 0.9058823529, alpha: 1)
      //  static let swipeInfoAction = #colorLiteral(red: 0.1803921569, green: 0.5254901961, blue: 0.7568627451, alpha: 1)
      //  static let selectedView = #colorLiteral(red: 0.9019607843, green: 0.4941176471, blue: 0.1333333333, alpha: 1)
    }
    
    class Font {
        
       // static let normalColor = #colorLiteral(red: 0.1803921569, green: 0.2509803922, blue: 0.3254901961, alpha: 1)
       // static let headerColor = #colorLiteral(red: 0.1294117647, green: 0.1843137255, blue: 0.2392156863, alpha: 1)
       // static let hyperlinkColor = #colorLiteral(red: 0.1294117647, green: 0.3803921569, blue: 0.5490196078, alpha: 1)
       // static let buttonText = #colorLiteral(red: 0.1803921569, green: 0.2509803922, blue: 0.3254901961, alpha: 1)
      
        static let sanFrancisco = UIFont.init(name: "San Francisco", size: sizeHeaderFont)
        static let proximaNova = UIFont.init(name: "Proxima Nova", size: sizeNormalFont)
        static let openSans = UIFont.init(name: "Open Sans", size: sizeNormalFont)
        static let sizeNormalFont: CGFloat = 16
        static let sizeBigFont: CGFloat = 18
        static let sizeHeaderFont: CGFloat = 20
        static let normal: UIFont = UIFont.systemFont(ofSize: sizeNormalFont)
        static let italic: UIFont = UIFont.italicSystemFont(ofSize: sizeNormalFont)
        static let bold = UIFont.boldSystemFont(ofSize: sizeNormalFont)
        static let bigBold = UIFont.boldSystemFont(ofSize: sizeBigFont)
        static let header = UIFont.boldSystemFont(ofSize: sizeBigFont)
        
    }
    
    class Size {

        static let notEnaibleAlpha: CGFloat = 0.4
        static let screenHeight = UIScreen.main.bounds.size.height
        static let screenWidth = UIScreen.main.bounds.size.width

        static let borderWidht: CGFloat = 2
        static let cornerRadius: CGFloat = 10
        
        static let headerHeight: CGFloat = 40
        static let cellHeight: CGFloat = 40
        
        static let killTeamCellHeight: CGFloat = 60
        
        static let imagePointSize: CGFloat = 8
        
        class NormalButton {
            static let width: CGFloat = 100
            static let height: CGFloat = 30
        }
        
        class Otstup {
        
            static let small: CGFloat = 5
            static let normal: CGFloat = 10
            static let large: CGFloat = 20
            
            static let subTextLeading: CGFloat = 20
        }
        
        class PortraitUnit {
            static let width: CGFloat = 160
            static let height: CGFloat = 180
        }
        
        class LogoImage {
            static let width: CGFloat = 40
            static let height: CGFloat = 40
        }
    }
}

protocol ColorTheme {
    
    var psychicPowerViewHeader: UIColor { get }
    var cellBackground: UIColor { get }
    var cellBorder: UIColor { get }
    var cellHeader: UIColor { get }
    var selectedCell: UIColor { get }
    var viewHeader: UIColor { get }
    var viewBackground: UIColor { get }
    var subViewBackground: UIColor { get }
    var viewControllerBackground: UIColor { get }
    var viewControllerBackgroundLight: UIColor { get }
    var buttonBackground: UIColor { get }
    var swipeRemoveAction: UIColor { get }
    var swipeInfoAction: UIColor { get }
    var selectedView: UIColor { get }
    var textNormal: UIColor { get }
    var textHeader: UIColor { get }
    var textHyperlink: UIColor { get }
    var textButton: UIColor { get }
    var textWhite: UIColor { get }
    var shadow: UIColor { get }
    var textDark: UIColor { get }
    var navigationBar: UIColor { get }
}

struct ClassicTheme: ColorTheme {
    
    var textWhite = #colorLiteral(red: 0.9959705472, green: 0.9961406589, blue: 0.9959598184, alpha: 1)
    var psychicPowerViewHeader = #colorLiteral(red: 0.09526111931, green: 0.289956063, blue: 0.5891153812, alpha: 1)
    var navigationBar = #colorLiteral(red: 0.6480363777, green: 0.706360088, blue: 0.7908885807, alpha: 1)
    var shadow = #colorLiteral(red: 0.1607843137, green: 0.1058823529, blue: 0.2352941176, alpha: 1)
    let cellBackground = #colorLiteral(red: 0.9058823529, green: 0.8980392157, blue: 0.8784313725, alpha: 1)
    let cellBorder = #colorLiteral(red: 0.9607843137, green: 0.7960784314, blue: 0.6549019608, alpha: 1)
    let cellHeader = #colorLiteral(red: 0.9607843137, green: 0.7960784314, blue: 0.6549019608, alpha: 1)
    let selectedCell = #colorLiteral(red: 0.9607843137, green: 0.7960784314, blue: 0.6549019608, alpha: 1)
    
    let viewHeader = #colorLiteral(red: 0.9019607843, green: 0.4941176471, blue: 0.1333333333, alpha: 1)
    let viewBackground  = #colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
    let subViewBackground = #colorLiteral(red: 0.8900747299, green: 0.8901053071, blue: 0.898252666, alpha: 1)
    
    let viewControllerBackground = #colorLiteral(red: 0.6480363777, green: 0.6613160389, blue: 0.7908885807, alpha: 1)
    var viewControllerBackgroundLight = #colorLiteral(red: 0.8352941176, green: 0.8470588235, blue: 0.862745098, alpha: 1)
    
    let buttonBackground = #colorLiteral(red: 0.9960784314, green: 0.9764705882, blue: 0.9058823529, alpha: 1)
    
    let swipeRemoveAction = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    let swipeInfoAction = #colorLiteral(red: 0.1803921569, green: 0.5254901961, blue: 0.7568627451, alpha: 1)
    
    let selectedView = #colorLiteral(red: 0.9019607843, green: 0.4941176471, blue: 0.1333333333, alpha: 1)
    
    let textNormal = #colorLiteral(red: 0.1803921569, green: 0.2509803922, blue: 0.3254901961, alpha: 1)
    let textHeader = #colorLiteral(red: 0.1294117647, green: 0.1843137255, blue: 0.2392156863, alpha: 1)
    let textHyperlink = #colorLiteral(red: 0.1294117647, green: 0.3803921569, blue: 0.5490196078, alpha: 1)
    let textButton = #colorLiteral(red: 0.1803921569, green: 0.2509803922, blue: 0.3254901961, alpha: 1)
    let textDark = #colorLiteral(red: 0.148689013, green: 0.1065989482, blue: 0.1273573443, alpha: 1)
}

struct DarkTheme: ColorTheme {
    
    var textWhite = #colorLiteral(red: 0.9959705472, green: 0.9961406589, blue: 0.9959598184, alpha: 1)
    var psychicPowerViewHeader = #colorLiteral(red: 0.09526111931, green: 0.289956063, blue: 0.5891153812, alpha: 1)
    var navigationBar = #colorLiteral(red: 0.2549019754, green: 0.3274728666, blue: 0.3019607961, alpha: 1)
    
    var shadow = #colorLiteral(red: 0.1607843137, green: 0.1058823529, blue: 0.2352941176, alpha: 1)
    
    let cellBackground = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
    let cellBorder = #colorLiteral(red: 0.4012935758, green: 0.4812894464, blue: 0.5522467494, alpha: 1)
    let cellHeader = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    let selectedCell = #colorLiteral(red: 0.9607843137, green: 0.7960784314, blue: 0.6549019608, alpha: 1)
    
    let viewHeader = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    let viewBackground  = #colorLiteral(red: 0.4012935758, green: 0.4812894464, blue: 0.5522467494, alpha: 1)
    let subViewBackground = #colorLiteral(red: 0.496037157, green: 0.5678072005, blue: 0.6553210113, alpha: 1)
    
    let viewControllerBackground = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    var viewControllerBackgroundLight = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    
    let buttonBackground = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
    
    let swipeRemoveAction = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    let swipeInfoAction = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
    
    let selectedView = #colorLiteral(red: 0.9019607843, green: 0.4941176471, blue: 0.1333333333, alpha: 1)
    
    let textNormal = #colorLiteral(red: 0.1803921569, green: 0.2509803922, blue: 0.3254901961, alpha: 1)
    let textHeader = #colorLiteral(red: 0.1294117647, green: 0.1843137255, blue: 0.2392156863, alpha: 1)
    let textHyperlink = #colorLiteral(red: 0.1294117647, green: 0.3803921569, blue: 0.5490196078, alpha: 1)
    let textButton = #colorLiteral(red: 0.1803921569, green: 0.2509803922, blue: 0.3254901961, alpha: 1)
    let textDark = #colorLiteral(red: 0.148689013, green: 0.1065989482, blue: 0.1273573443, alpha: 1)

}

struct New: ColorTheme {
    
    var textWhite = #colorLiteral(red: 0.9959705472, green: 0.9961406589, blue: 0.9959598184, alpha: 1)
    var psychicPowerViewHeader = #colorLiteral(red: 0.09526111931, green: 0.289956063, blue: 0.5891153812, alpha: 1)
    var navigationBar = #colorLiteral(red: 0.6480363777, green: 0.706360088, blue: 0.7908885807, alpha: 1)
    var shadow = #colorLiteral(red: 0.1607843137, green: 0.1058823529, blue: 0.2352941176, alpha: 1)
    let cellBackground = #colorLiteral(red: 0.9058823529, green: 0.8980392157, blue: 0.8784313725, alpha: 1)
    let cellBorder = #colorLiteral(red: 0.9607843137, green: 0.7960784314, blue: 0.6549019608, alpha: 1)
    let cellHeader = #colorLiteral(red: 0.9607843137, green: 0.7960784314, blue: 0.6549019608, alpha: 1)
    let selectedCell = #colorLiteral(red: 0.9607843137, green: 0.7960784314, blue: 0.6549019608, alpha: 1)
    
    let viewHeader = #colorLiteral(red: 0.9019607843, green: 0.4941176471, blue: 0.1333333333, alpha: 1)
    let viewBackground  = #colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
    let subViewBackground = #colorLiteral(red: 0.8900747299, green: 0.8901053071, blue: 0.898252666, alpha: 1)
    
    let viewControllerBackground = #colorLiteral(red: 0.6488893377, green: 0.663974278, blue: 0.7936158966, alpha: 1)
    var viewControllerBackgroundLight = #colorLiteral(red: 0.8352941176, green: 0.8470588235, blue: 0.862745098, alpha: 1)
    
    let buttonBackground = #colorLiteral(red: 0.9960784314, green: 0.9764705882, blue: 0.9058823529, alpha: 1)
    
    let swipeRemoveAction = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    let swipeInfoAction = #colorLiteral(red: 0.1803921569, green: 0.5254901961, blue: 0.7568627451, alpha: 1)
    
    let selectedView = #colorLiteral(red: 0.9019607843, green: 0.4941176471, blue: 0.1333333333, alpha: 1)
    
    let textNormal = #colorLiteral(red: 0.1803921569, green: 0.2509803922, blue: 0.3254901961, alpha: 1)
    let textHeader = #colorLiteral(red: 0.1294117647, green: 0.1843137255, blue: 0.2392156863, alpha: 1)
    let textHyperlink = #colorLiteral(red: 0.1294117647, green: 0.3803921569, blue: 0.5490196078, alpha: 1)
    let textButton = #colorLiteral(red: 0.1803921569, green: 0.2509803922, blue: 0.3254901961, alpha: 1)
    let textDark = #colorLiteral(red: 0.148689013, green: 0.1065989482, blue: 0.1273573443, alpha: 1)

}

final class ColorScheme {
    
    static let shared = ColorScheme()
    var theme: ColorTheme
    
    init() {
        self.theme = New()
    }
}
