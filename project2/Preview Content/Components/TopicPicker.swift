//
//  TopicPicker.swift
//  project2
//
//  Created by Youbin on 4/16/25.
//

import SwiftUI

struct TopicPicker: View {
    let options: [String]
    @Binding var selectedOption: String
    
    // 스타일 관련 파라미터 추가
    let height: CGFloat
    let fontStyle: Font
    let arrowSize: CGFloat
    let text: String
    

    var body: some View {
        VStack(alignment: .center, spacing: 5) {

            // 실제 드롭다운 메뉴
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selectedOption = option
                    }) {
                        Text(option)
                    }
                }
            } label: {
                HStack {
                    Text(selectedOption.isEmpty ? text : selectedOption)
                        .font(fontStyle)
                        .foregroundColor(.mainText)

                    Spacer()

                    Image("pickerBtn")
                        .resizable()
                        .frame(width:arrowSize, height: arrowSize)
                }
                .frame(width: 345, height: height)
            }

            // 아래 구분선
            Rectangle()
                .frame(width: 345, height: 1)
            
                .foregroundColor(.gray00)
        }
    }
}
