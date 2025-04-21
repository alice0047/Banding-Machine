//
//  MessageDetailView.swift
//  project2
//
//  Created by Youbin on 4/17/25.
//

import SwiftUI

struct MessageDetailView: View {
    let message: MessageInfo
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .center, spacing: 15, content: {
            CustomNavigation(title: "메시지 보기", showBackBtn: true, action: {dismiss()})
            
            messageField
            
            
            
            AnswerField
        })
        .navigationBarBackButtonHidden(true)
    }
    
    private var messageField: some View {
        VStack(alignment: .leading, spacing: 10, content: {
            profile(
                name: message.runnerID,
                imageURL: message.runnerImageURL,
                date: message.createdAt
            )
            
            Text(message.topic)
                .font(.pretendardSemiBold18)
                .foregroundStyle(.mainText)
            
            Text(message.content)
                .font(.pretendardMedium16)
                .foregroundStyle(.gray02)
        })
        .frame(maxWidth: 350, maxHeight: .infinity)
    }
    
    private var AnswerField: some View {
        VStack(alignment: .leading, spacing: 10, content: {
            
        })
    }
    
}

private func profile(name: String, imageURL: String, date: Date) -> some View {
        HStack(alignment: .center) {
            AsyncImage(url: URL(string: imageURL)) { image in
                image.resizable()
            } placeholder: {
                Circle().fill(Color.gray.opacity(0.3))
            }
            .frame(width: 42, height: 42)
            .clipShape(Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(.pretendardSemiBold18)
                    .foregroundStyle(.mainText)

                Text(DateUtils.formatDate(date))
                    .font(.pretendardMedium14)
                    .foregroundStyle(.gray01)
            }

            Spacer()
        }
    }


#Preview {
    let dummyMessage = MessageInfo(
        id: "test123",
        runnerID: "Bin",
        runnerImageURL: "https://example.com/image.jpg",
        mentorID: "mentor123",
        topic: "첫 회사는 어떻게 선택하셨어요?",
        content: "저는 요즘 커리어에 대한 고민이 많아서요...",
        category: .career,
        createdAt: Date(),
        replyCount: 2
    )
    
    return MessageDetailView(message: dummyMessage)
}
