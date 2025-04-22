//
//  MessageActionSheet.swift
//  project2
//
//  Created by Youbin on 4/22/25.
//

import SwiftUI

struct MessageActionSheet: View {
    let message: MessageInfo
    let onEdit: () -> Void
    let onDelete: () -> Void

    var body: some View {
        VStack(alignment: .center, spacing: 15, content: {
            Capsule()
                .frame(width: 40, height: 5)
                .foregroundStyle(.gray00)
                .padding(.top, 8)
            
            Button(action: {
                onEdit()
            }, label: {
                HStack(alignment: .center, spacing: 7, content: {
                    Image("pencil")
                        .resizable()
                        .frame(width: 32, height: 32)
                    
                    Text("수정")
                        .font(.pretendardMedium21)
                        .foregroundStyle(.mainText)
                    
                    Spacer()
                })
            })
            
            Divider()
            
            Button(action: {
                onDelete()
            }, label: {
                HStack(alignment: .center, spacing: 7, content: {
                    Image("trash")
                        .resizable()
                        .frame(width: 32, height: 32)
                    
                    Text("삭제")
                        .font(.pretendardMedium21)
                        .foregroundStyle(.redPop)
                    
                    Spacer()
                })
            })
            
            Spacer()
        })
        .padding(.horizontal, 16)
        .presentationDetents([.height(140)])
    }
}

#Preview {
    MyPageView()
}

