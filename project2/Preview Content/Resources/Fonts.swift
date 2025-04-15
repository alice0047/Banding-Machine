//
//  Fonts.swift
//  project2
//
//  Created by Youbin on 4/15/25.
//

import Foundation
import SwiftUI

extension Font {
    enum Pretend {
        case bold
        case semibold
        case medium
        case regular
        case light
        case pixel
        
        var value: String {
            switch self {
            case .bold:
                return "Pretendard-Bold"
            case .semibold:
                return "Pretendard-SemiBold"
            case .medium:
                return "Pretendard-Medium"
            case .regular:
                return "Pretendard-Regular"
            case .light:
                return "Pretendard-Light"
            case .pixel:
                return "DungGeunMo"
            }
        }
    }
    
    static func pretend(type: Pretend, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    //MARK: - Pretendard
    static var pretendardSemiBold20: Font {
        return .pretend(type: .semibold, size: 20)
    }
    
    static var pretendardRegular17: Font {
        return .pretend(type: .regular, size: 17)
    }
    
    //MARK: - Stardust
    static var pixel25: Font {
        return .pretend(type: .pixel, size: 25)
    }
    
    static var pixel19: Font {
        return .pretend(type: .pixel, size: 19)
    }
}
