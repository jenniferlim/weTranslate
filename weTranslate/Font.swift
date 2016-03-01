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
        case UltraLight
        case Thin
        case Light
        case Regular
        case Medium
        case Semibold
        case Bold
        case Heavy
        case Black

        private var fontWeight: CGFloat {
            switch self {
            case .UltraLight:
                return UIFontWeightUltraLight
            case .Thin:
                return UIFontWeightThin
            case .Light:
                return UIFontWeightLight
            case .Regular:
                return UIFontWeightRegular
            case .Medium:
                return UIFontWeightMedium
            case .Semibold:
                return UIFontWeightSemibold
            case .Bold:
                return UIFontWeightBold
            case .Heavy:
                return UIFontWeightHeavy
            case .Black:
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
        case Title1
        case Title2
        case Title3
        case Headline
        case Subheadline
        case Body
        case Callout
        case Footnote
        case Caption1
        case Caption2

        private var textStyle: String {
            switch self {
            case .Title1:
                return UIFontTextStyleTitle1
            case .Title2:
                return UIFontTextStyleTitle2
            case .Title3:
                return UIFontTextStyleTitle3
            case .Headline:
                return UIFontTextStyleHeadline
            case .Subheadline:
                return UIFontTextStyleSubheadline
            case .Body:
                return UIFontTextStyleBody
            case .Callout:
                return UIFontTextStyleCallout
            case .Footnote:
                return UIFontTextStyleFootnote
            case .Caption1:
                return UIFontTextStyleCaption1
            case .Caption2:
                return UIFontTextStyleCaption2
            }
        }

        private var defaultWeight: Weight {
            switch self {
            case .Title1:
                return .Light
            default:
                return .Regular
            }
        }
    }


    // MARK: - Properties

    private static let fontSizeAjustment: CGFloat = 1.0


    // MARK: - Methods

    static func font(style style: Style = .Body, weight: Weight? = nil) -> UIFont {
        let preferredFont = UIFont.preferredFontForTextStyle(style.textStyle)
        let fontSize: CGFloat = preferredFont.pointSize + fontSizeAjustment
        let fontWeight = weight?.fontWeight ?? style.defaultWeight.fontWeight
        return UIFont.systemFontOfSize(fontSize, weight: fontWeight)
    }

    static func emojiFont() -> UIFont {
        return UIFont.systemFontOfSize(120)
    }
}
