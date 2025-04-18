//
//  CustomTextEditor.swift
//  project2
//
//  Created by Youbin on 4/16/25.
//

import SwiftUI

struct CustomTextEditorStyle: ViewModifier {
    
    let placeholder: String
    @Binding var text: String
    
    func body(content: Content) -> some View {
            content
                .padding(10)
                .background(alignment: .topLeading) {
                    if text.isEmpty {
                        Text(placeholder)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 20)
                            .font(.pretendardMedium16)
                            .foregroundStyle(.gray01)
                    }
                }
                .textInputAutocapitalization(.none) // 첫 시작 대문자 막기
                .autocorrectionDisabled()
                .background(.clear)
                .scrollContentBackground(.hidden)
                .font(.pretendardMedium16)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray00, lineWidth: 1)
                )
                .overlay(alignment: .bottomTrailing) {
                    Text("\(text.count) / 500")
                        .font(.pretendardMedium14)
                        .foregroundColor(.gray01)
                        .padding(.trailing, 10)
                        .padding(.bottom, 10)
                        .onChange(of: text) {
                            if text.count > 500 {
                                text = String(text.prefix(500))
                            }
                        }
                }
    }
}

extension TextEditor {
    func customStyleEditor(placeholder: String, userInput: Binding<String>) -> some View {
        self.modifier(CustomTextEditorStyle(placeholder: placeholder, text: userInput))
    }
}
