//
//  TopicSheet.swift
//  project2
//
//  Created by Youbin on 4/18/25.
//

import SwiftUI

struct TopicSheet: View {
    @Binding var isPresented: Bool // 모달의 표시 여부 바인딩
    let selectedCategory: TopicCategory
    let selectedMentor: String
    let onSend: (String) -> Void
    
    @State private var selectedTopic: String = ""

    var body: some View {
        ZStack {
            Color.gray01.opacity(0.7)
                .ignoresSafeArea(.all)
            
            customAlertWindow
        }
        .animation(.easeInOut(duration: 0.5), value: isPresented)
        .onAppear {
            // ✅ 카테고리에 해당하는 토픽 중 랜덤 선택
            selectedTopic = selectedCategory.dummyTopics.randomElement() ?? "토픽이 없습니다"
        }
    }
    
    private var customAlertWindow: some View {
        ZStack(alignment: .top, content: {
                
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: 362, height: 288)
                
            VStack(alignment: .center, spacing: 34, content: {
                HStack(alignment: .center, spacing: 80, content: {
                            
                    Spacer().frame(width: 10)
                            
                    Text("오늘의 주제")
                        .font(.pixel25)
                            
                    Button(action: {
                        isPresented = false // 모달 닫기
                    }, label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(.mainText)
                    })
                })
                        
                choosedTopic
                        
                btns
            })
            .padding(.top, 16)
        })
    }
        
    //MARK: - 선택된 토픽 내용 필드
    private var choosedTopic: some View {
        //TODO: 들어갈 내용들 이전 메인에서 선택한 값들로 초기화해야함
        VStack(alignment: .center, spacing: 12, content: {
            Text(selectedMentor) // 멘토 이름
                .font(.pretendardMedium21)
                .foregroundStyle(.mainText)
            
            Spacer().frame(height: 1)
            
            Text(selectedTopic) // 선정된 토픽
                .font(.pretendardSemiBold24)
                .foregroundStyle(.mainText)
            
            Text("# \(selectedCategory.rawValue)")
                .font(.pretendardRegular17)
                .foregroundStyle(.gray01)
        })
    }

    //MARK: - 버튼 필드
    private var btns: some View {
        HStack(alignment: .center, spacing: 18, content: {
            Button(action: {
                isPresented = false
            }, label: {
                Text("다시 뽑기")
                    .frame(width: 150, height: 52)
                    .font(.pretendardSemiBold18)
                    .foregroundStyle(.main)
                    .background(Color.clear)
                    .clipShape(RoundedRectangle(cornerRadius: 48))
                    .overlay(
                        RoundedRectangle(cornerRadius: 48)
                            .stroke(.gray00, lineWidth: 1)
                    )
            })
            
            Button(action: {
                isPresented = false
                onSend(selectedTopic)
            }, label: {
                Text("메시지 보내기")
                    .frame(width: 150, height: 52)
                    .font(.pretendardSemiBold18)
                    .foregroundStyle(Color.white)
                    .background(.main)
                    .clipShape(RoundedRectangle(cornerRadius: 48))
            })
        })
    }
}
