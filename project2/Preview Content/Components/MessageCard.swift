//
//  MessageCard.swift
//  project2
//
//  Created by Youbin on 4/16/25.
//

import SwiftUI

struct MessageCard: View {
//TODO: 주석 처리하기
//    let info: MessageInfo
//    let action: () -> Void
//    
//    /// - Parameters
//    ///   - messageInfo: 메시지 카드 정보 - 작성자, 내용, 댓글 개수, 카테고리, 날짜
//    ///   - action: 버튼 액션 - 해당 메시지 디테일뷰로 가야함
//    init(
//        info: MessageInfo,
//        action: @escaping () -> Void = {}
//    ) {
//        self.info = info
//        self.action = action
//    }
    
    var body: some View {
        
        Button(action: {
//           action
            print("메시지카드 클릭됨")
        }, label: {
            VStack(alignment: .center, spacing: 10, content: {
                categoryAndBtn

                contentField
            })
            .padding(.vertical, 17)
            .padding(.horizontal, 20)
            .frame(width: 368, height: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: 0)
            )
        })
    }
    
    //MARK: - 카테고리와 ...버튼
    private var categoryAndBtn: some View {
        HStack(alignment: .center, content: {
            //TODO: 실제 카테고리 정보 넣어야 함
            Text("진로/커리어")
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
            
            //TODO: 내용 서버에서 가져와 넣어야함
            Text("ISAAC, 첫 회사는 어떻게 선택하셨어요?")
                .font(.pretendardRegular17)
                .foregroundStyle(.mainText)
            
            HStack(alignment: . center, spacing: 5, content: {
                Image("comment")
                    .resizable()
                    .frame(width: 21, height: 20)
                    .foregroundStyle(.gray02)
                
                Text("1")
                    .font(.pretendardMedium14)
                    .foregroundColor(.gray02)
            })
        })
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
                Text("Bin")
                    .font(.pretendardSemiBold18)
                    .foregroundStyle(.mainText)
                
                Text("2025.04.24")
                    .font(.pretendardMedium14)
                    .foregroundStyle(.gray01)
            })
            
            Spacer()
        })
    }
    
}

#Preview {
    MessageCard()
}
