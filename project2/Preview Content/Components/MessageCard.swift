//
//  MessageCard.swift
//  project2
//
//  Created by Youbin on 4/16/25.
//

import SwiftUI

struct MessageCard: View {
    let info: MessageInfo
    
    /// - Parameters
    ///   - messageInfo: 메시지 카드 정보 - 작성자, 내용, 댓글 개수, 카테고리, 날짜
    init(
        info: MessageInfo
    ) {
        self.info = info
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10, content: {
            categoryAndBtn

            contentField
        })
        .padding(.vertical, 17)
        .padding(.horizontal, 20)
        .frame(maxWidth: 368, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: 0)
        )
    }
    
    //MARK: - 카테고리와 ...버튼
    private var categoryAndBtn: some View {
        HStack(alignment: .center, content: {
            Text(info.category.rawValue)
                .font(.pretendardSemiBold12)
                .foregroundStyle(.gray02)
                .padding(.vertical, 4)
                .padding(.horizontal,8)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.grayWhite)
                )
            
            Spacer()
            
            Button(action: {
                //TODO: 수정 삭제 만들어야 함
            }, label: {
                Image(systemName: "ellipsis")
                    .resizable()
                    .frame(width: 20, height: 4)
                    .foregroundStyle(.gray02)
            })
                
        })
    }
    
    //MARK: - 내용 필드 : 프로필 + 작성 내용 + 댓글
    private var contentField: some View {
        VStack(alignment: .leading, spacing: 17, content: {
            profile
            
            Text("\(info.mentorID), \(info.topic)")
                .font(.pretendardRegular17)
                .foregroundStyle(.mainText)
                .multilineTextAlignment(.leading)
                .lineSpacing(1.5)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            
            HStack(alignment: . center, spacing: 5, content: {
                Image("comment")
                    .resizable()
                    .frame(width: 21, height: 20)
                    .foregroundStyle(.gray02)
                
                Text("\(info.replyCount)")
                    .font(.pretendardMedium14)
                    .foregroundColor(.gray02)
            })
        })
        .frame(maxWidth: .infinity)
    }
    
    
    
    //MARK: 프로필 필드
    private var profile: some View {
        HStack(alignment: .center, content: {
            //TODO: 프로필 사진, 닉네임, 날짜 실제 받아와야 함
            Image("profileImage")
                .resizable()
                .frame(width: 42, height: 42)
                .clipShape(Circle())
            
            VStack(alignment: .leading, content: {
                Text(info.runnerID)
                    .font(.pretendardSemiBold18)
                    .foregroundStyle(.mainText)
                
                Text(DateUtils.formatDate(info.createdAt))
                    .font(.pretendardMedium14)
                    .foregroundStyle(.gray01)
            })
            
            Spacer()
        })
    }
    
}
