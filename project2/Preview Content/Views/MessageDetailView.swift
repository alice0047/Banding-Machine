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
            
            Divider()
                .frame(height: 1)
                .background(.grayWhite)
            
            AnswerField
        })
        .navigationBarBackButtonHidden(true)
    }
    
    //MARK: - 메시지 필드 : 프로필 + 토픽 + 내용 + 날짜
    private var messageField: some View {
        VStack(alignment: .leading, spacing: 12, content: {
            profile(
                name: message.runner,
                imageURL: message.runnerImageURL,
                date: message.createdAt
            )
            
            Text("\(message.mentor), \(message.topic)")
                .font(.pretendardSemiBold18)
                .foregroundStyle(.mainText)
            
            Text(message.content)
                .font(.pretendardMedium16)
                .foregroundStyle(.gray02)
            
            Spacer().frame(height: 15)
        })
        .frame(maxWidth: 350)
    }
    
    //MARK: - 답변 필드
    private var AnswerField: some View {
        VStack(alignment: .leading, spacing: 10, content: {
            //TODO: 댓글 입력창 서버 저장 및 출력 필요
            Text("답변")
                .font(.pretendardSemiBold18)
                .foregroundStyle(.mainText)
            
            profile(
                name: "ISAAC",
                imageURL: "https://randomuser.me/api/portraits/men/1.jpg",
                date: Date()
            )
            
            Text("답변답변답변답변답변답변답변답변답변답변답변답변답변답변답변")
                .font(.pretendardMedium16)
                .foregroundStyle(.gray02)
                .padding(.leading, 48)
        })
        .frame(maxWidth: 350)
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

