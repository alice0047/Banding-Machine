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
                    Text(selectedOption.isEmpty ? "주제를 선택해주세요" : selectedOption)
                        .font(.pretendardRegular17)
                        .foregroundColor(.mainText)

                    Spacer()

                    Image("pickerBtn")
                        .resizable()
                        .frame(width:15, height: 8)
                }
            }

            // 아래 구분선
            Rectangle()
                .frame( width: 360, height: 1)
            
                .foregroundColor(.gray00)
        }
    }
}
