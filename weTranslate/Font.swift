//
//  Font.swift
//  weTranslate
//
//  Created by Lionel on 2/21/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit

final class Font {

    // MARK: Types

    enum Weight {
        case ultraLight
        case thin
        case light
        case regular
        case medium
        case semibold
        case bold
        case heavy
        case black

        fileprivate var fontWeight: CGFloat {
            switch self {
            case .ultraLight:
                return UIFontWeightUltraLight
            case .thin:
                return UIFontWeightThin
            case .light:
                return UIFontWeightLight
            case .regular:
                return UIFontWeightRegular
            case .medium:
                return UIFontWeightMedium
            case .semibold:
                return UIFontWeightSemibold
            case .bold:
                return UIFontWeightBold
            case .heavy:
                return UIFontWeightHeavy
            case .black:
                return UIFontWeightBlack
            }
        }
    }

    //  Default system text style fonts
    //
    //  Title1:   .SFUIDisplay-Light      @ 28.0
    //  Title2:   .SFUIDisplay-Regular    @ 22.0
    //  Title3:   .SFUIDisplay-Regular    @ 20.0
    //  Headline: .SFUIText-Semibold      @ 17.0
    //  Subhead:  .SFUIText-Regular       @ 15.0
    //  Body:     .SFUIText-Regular       @ 17.0
    //  Callout:  .SFUIText-Regular       @ 16.0
    //  Footnote: .SFUIText-Regular       @ 13.0
    //  Caption1: .SFUIText-Regular       @ 12.0
    //  Caption2: .SFUIText-Regular       @ 11.0

    enum Style {
        case title1
        case title2
        case title3
        case headline
        case subheadline
        case body
        case callout
        case footnote
        case caption1
        case caption2

        fileprivate var textStyle: String {
            switch self {
            case .title1:
                return UIFontTextStyle.title1.rawValue
            case .title2:
                return UIFontTextStyle.title2.rawValue
            case .title3:
                return UIFontTextStyle.title3.rawValue
            case .headline:
                return UIFontTextStyle.headline.rawValue
            case .subheadline:
                return UIFontTextStyle.subheadline.rawValue
            case .body:
                return UIFontTextStyle.body.rawValue
            case .callout:
                return UIFontTextStyle.callout.rawValue
            case .footnote:
                return UIFontTextStyle.footnote.rawValue
            case .caption1:
                return UIFontTextStyle.caption1.rawValue
            case .caption2:
                return UIFontTextStyle.caption2.rawValue
            }
        }

        fileprivate var defaultWeight: Weight {
            switch self {
            case .title1:
                return .light
            default:
                return .regular
            }
        }
    }


    // MARK: - Properties

    fileprivate static let fontSizeAjustment: CGFloat = 1.0


    // MARK: - Methods

    static func font(_ style: Style = .body, weight: Weight? = nil) -> UIFont {
        let preferredFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle(rawValue: style.textStyle))
        let fontSize: CGFloat = preferredFont.pointSize + fontSizeAjustment
        let fontWeight = weight?.fontWeight ?? style.defaultWeight.fontWeight
        return UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
    }

    static func hugeEmojiFont() -> UIFont {
        return UIFont.systemFont(ofSize: 120)
    }
}
