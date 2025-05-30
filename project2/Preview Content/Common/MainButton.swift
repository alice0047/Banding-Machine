//
//  MainButton.swift
//  project2
//
//  Created by Youbin on 4/15/25.
//

import SwiftUI

struct MainButton: View {
    
    var btnText: String
    var action: () -> Void
    var color: Color
    var textColor: Color
    
    
    //MARK: - Init
    /// - Parameters:
    ///   - btnText: 버튼 텍스트
    ///   - action: 버튼 액션
    ///   - color: 버튼 색상
    init(btnText: String,
         action: @escaping () -> Void,
         color: Color,
         textColor: Color
    ) {
        self.btnText = btnText
        self.action = action
        self.color = color
        self.textColor = textColor
    }
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(btnText)
                .frame(width: 368, height: 60)
                .font(.pretendardSemiBold18)
                .foregroundStyle(textColor)
                .background(color)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        })
    }
}

struct MainButton_Preview: PreviewProvider {
    static var previews: some View {
        MainButton(btnText: "완료", action: {print("메인버튼 눌림")}, color: .main, textColor: .white)
            .previewLayout(.sizeThatFits)
    }
}

