//
//  WriteMessageView.swift
//  project2
//
//  Created by Youbin on 4/16/25.
//

import SwiftUI

struct WriteMessageView: View {
    @StateObject private var viewModel = MessageWriteViewModel()
    @AppStorage("nickname") private var nickname: String = ""
    
    @State private var detailMessage: String = ""
    
    //TODO: 홈에서 선택한 옵션 받아서 더미 넣어둠
    @State private var selectedTopic: String = "어떤 직무가 저한테 맞을까요?"
    let currentCategory: TopicCategory = .career // 홈에서 받아온 값

    
    var body: some View {
        VStack(alignment : .center, spacing: 18,content: {
            CustomNavigation(title: "메시지 작성", showBackBtn: true, action: {print("뒤로가기 버튼 눌림")})
            
            contentField
            
            Spacer()
            
            MainButton(
                btnText: "등록하기",
                action: {
                    Task {
                        await viewModel.saveMessage(
                            nickname: nickname,
                            category: currentCategory,
                            topic: selectedTopic,
                            content: detailMessage
                        )
                    }
                },
                color: .main,
                textColor: .white)
        })
    }
    
    //MARK: - 대화 주제, 내용
    private var contentField: some View {
        VStack(alignment: .center, spacing: 24, content: {
            topicField
            
            detailField
            
        })
    }
    
    //MARK: - 대화 주제 + 카테고리
    private var topicField: some View {
        VStack(alignment: .leading, spacing: 9, content: {
            //TODO: - 실제 선택된 멘토, 카테고리로 설정되어야 함
            Text("ISAAC > 진로/커리어")
                .font(.pretendardMedium14)
                .foregroundStyle(.gray01)
            
            Text("대화 주제")
                .font(.pretendardSemiBold18)
                .foregroundStyle(.mainText)
            
            TopicPicker(
                options: currentCategory.dummyTopics,
                selectedOption: $selectedTopic
            )
        })
        .frame(width: 360, height: 85)
    }
    
    //MARK: - 자세한 내용
    private var detailField: some View {
        VStack(alignment: .leading, content: {
            Text("전달하고 싶은 내용")
                .font(.pretendardSemiBold18)
                .foregroundStyle(.mainText)
            
            TextEditor(text: $detailMessage)
                .customStyleEditor(placeholder: "내용을 입력해주세요", userInput: $detailMessage)
                .frame(width: 360, height: 205)
                .font(.pretendardMedium16)
                .foregroundStyle(.mainText)
                .lineSpacing(5)
                
        })
        .frame(width: 360, height: 264)
        
    }
}

#Preview {
    WriteMessageView()
}
