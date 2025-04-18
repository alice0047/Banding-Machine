//
//  MessageDetailView.swift
//  project2
//
//  Created by Youbin on 4/17/25.
//

import SwiftUI

struct MessageDetailView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 15, content: {
            CustomNavigation(title: "메시지 보기", showBackBtn: true, action: {print("뒤로가기 버튼 눌림")})
            
            messageField
            
            AnswerField
        })
    }
    
    private var messageField: some View {
        VStack(alignment: .leading, spacing: 10, content: {
            
        })
    }
    
    private var AnswerField: some View {
        VStack(alignment: .leading, spacing: 10, content: {
            
        })
    }
}

#Preview {
    MessageDetailView()
}
