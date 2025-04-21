//
//  MessageDetailView.swift
//  project2
//
//  Created by Youbin on 4/17/25.
//

import SwiftUI

struct MessageDetailView: View {
    @StateObject private var viewModel = ReadMessageViewModel()
    @AppStorage("nickname") private var nickname: String = ""

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

private func profile(user: UserInfo, dateText: String) -> some View {
    HStack(alignment: .center) {
        AsyncImage(url: URL(string: user.image)) { image in
            image.resizable()
        } placeholder: {
            Circle()
                .fill(Color.gray.opacity(0.3))
        }
        .frame(width: 42, height: 42)
        .clipShape(Circle())

        VStack(alignment: .leading, spacing: 2) {
            Text(user.name)
                .font(.pretendardSemiBold18)
                .foregroundStyle(.mainText)

            Text(dateText)
                .font(.pretendardMedium14)
                .foregroundStyle(.gray01)
        }

        Spacer()
    }
}


#Preview {
    MessageDetailView()
}
