//
//  WriteMessageView.swift
//  project2
//
//  Created by Youbin on 4/16/25.
//

import SwiftUI

struct WriteMessageView: View {
    @StateObject private var viewModel = MessageViewModel()
    @Environment(\.dismiss) private var dismiss
    @AppStorage("nickname") private var nickname: String = ""
    @AppStorage("profileImageURL") private var profileImageURL: String = ""
    @State private var detailMessage: String = ""
    @State private var selectedTopic: String = ""
    
    let mode: WriteMode
    let mentorName: String
    let category: TopicCategory
    let initialTopic: String
    
    var body: some View {
        VStack(alignment : .center, spacing: 18,content: {
            CustomNavigation(title: mode.navigationTitle, showBackBtn: true, action: {dismiss()})
            
            contentField
            
            Spacer()
            
            MainButton(
                btnText: mode.buttonText,
                action: {
                    Task {
                        switch mode {
                        case .create:
                            await viewModel.saveMessage(
                                nickname: nickname,
                                imageURL: profileImageURL,
                                category: category,
                                topic: selectedTopic,
                                content: detailMessage,
                                mentor: mentorName
                            )
                        case .edit(let message):
                                viewModel.updateMessage(id: message.id, newTopic: selectedTopic, newContent: detailMessage
                            )
                        }
                    }
                },
                color: .main,
                textColor: .white)
        })
        .onAppear {
            if case .edit(let message) = mode {
                detailMessage = message.content
                selectedTopic = message.topic
            } else {
                selectedTopic = initialTopic
            }
        }
        .navigationBarBackButtonHidden(true)
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
            Text("\(mentorName) > \(category.rawValue)")
                .font(.pretendardMedium14)
                .foregroundStyle(.gray01)
            
            Text("대화 주제")
                .font(.pretendardSemiBold18)
                .foregroundStyle(.mainText)
            
            TopicPicker(
                options: category.dummyTopics,
                selectedOption: $selectedTopic,
                height: 31,
                fontStyle: .pretendardMedium17,
                arrowSize: 24, 
                text: "Topic을 선택해주세요"
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

