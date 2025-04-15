//
//  CustomNavigation.swift
//  project2
//
//  Created by Youbin on 4/15/25.
//

import SwiftUI

struct CustomNavigation: View {
    
    let action: () -> Void
    let title: String
    let showBackBtn:Bool
    
    /// - Parameters
    ///   - action: 버튼 액션
    ///   - title: 네비게이션 내부 타이틀
    ///   - showBackBtn: 뒤로가기 버튼 여부
    init(
        action: @escaping () -> Void,
        title: String,
        showBackBtn: Bool = true
    ) {
        self.action = action
        self.title = title
        self.showBackBtn = showBackBtn
    }
    
    var body: some View {
        HStack(alignment: .center, content: {
            Group {
                if showBackBtn {
                    Button(action: {
                        action()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 11, height: 21)
                            .foregroundStyle(.mainText)
                    })
                } else {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 11, height: 21)
                }
            }
            
            Spacer().frame(width: 123)
            
            Text(title)
                .font(.pretendardSemiBold20)
                .foregroundStyle(Color.black)
                .frame(maxWidth: 92, maxHeight: 20, alignment: .center)
            
            Spacer()
            
        })
        .frame(width: 360, height: 35)
    }
}

struct CustomNavigation_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomNavigation(action: {print("뒤로가기 버튼 눌림")}, title: "프로필 생성", showBackBtn: false)
            
            Spacer()
        }
    }
}
