//
//  HomeView.swift
//  project2
//
//  Created by Youbin on 4/24/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @AppStorage("profileImageURL") private var profileImage: String = ""
    @State private var selectedInfo: HomeViewModel.SelectionInfo? = nil
    @State private var navTriggerInfo: HomeViewModel.SelectionInfo? = nil // navigation trigger 용
    @State private var showTopicSheet: Bool = false
    @State private var selectedTopic: String = "" //뽑힌 토픽
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .center, spacing: 25, content: {
                    VStack(content: {
                        HStack(alignment: .center, content: {
                            Spacer().frame(width: 86)
                            
                            Text("TOPIC 자판기")
                                .font(.pixel34)
                                .foregroundStyle(.mainText)
                            
                            Spacer()
                            
                            Button(action: {
                                //TODO: 마이페이지 뷰로 이동
                            }, label: {
                                AsyncImage(url: URL(string: profileImage)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 42, height: 42)
                                .clipShape(Circle())
                            })
                        })
                        .frame(width: 370, height: 38)
                        
                        contents
                    })
                    
                    Button(action: {
                        if let info = viewModel.getSelectionInfo() {
                            selectedInfo = info
                            showTopicSheet = true
                        }
                    }, label: {
                        Text("뽑기")
                            .frame(width: 368, height: 99)
                            .font(.pixel50)
                            .foregroundStyle(Color.white)
                            .background(.main)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    })
                    .disabled(viewModel.selectedCategory == nil || viewModel.selectedMentor == nil)
                })
                
                // ✅ TopicSheet 오버레이
                if showTopicSheet, let info = selectedInfo {
                    TopicSheet(
                        isPresented: $showTopicSheet,
                        selectedCategory: info.category,
                        selectedMentor: info.mentorName,
                        onSend: { topic in
                            selectedTopic = topic
                            showTopicSheet = false

                            // 시트가 닫힌 후에 트리거
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                navTriggerInfo = selectedInfo
                            }
                        }
                    )
                }
                
            }
            // ✅ 선택된 info가 있을 때만 navigation
            .navigationDestination(item: $navTriggerInfo) { info in
                WriteMessageView(
                    mode: .create,
                    mentorName: info.mentorName,
                    category: info.category,
                    initialTopic: selectedTopic
                )
            }
        }
    }
    
    private var contents: some View {
        VStack(spacing: 25, content: {
            
            Spacer().frame(height: 2)
            
            categoryField
            
            mentorField
        })
        .frame(height: 609)
    }
    
    private var categoryField: some View {
        VStack(alignment: .leading, spacing: 9, content: {
            Text("대화 카테고리를 골라주세요")
                .font(.pretendardMedium21)
                .foregroundStyle(.mainText)

            TopicPicker(
                options: TopicCategory.displayNames,
                selectedOption: $viewModel.selectedCategoryRaw,
                height: 41,
                fontStyle: .pixel22,
                arrowSize: 33,
                text: "카테고리를 선택해주세요"
            )
        })
    }
    
    private var mentorField: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            Text("대화하고 싶은 멘토를 선택해주세요")
                .font(.pretendardMedium21)
                .foregroundStyle(.mainText)
            
            TabView(selection: $viewModel.currentPage) {
                ForEach(viewModel.pages.indices, id: \.self) { index in
                    MentorGridView(
                        mentors: viewModel.pages[index],
                        selectedMentor: $viewModel.selectedMentor
                    )
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(width: 370, height: 437)
            
            // ✅ 커스텀 indicator
            HStack(spacing: 8) {
                ForEach(0..<viewModel.pages.count, id: \.self) { index in
                    Circle()
                        .fill(index == viewModel.currentPage ? Color.main : Color.gray.opacity(0.3))
                        .frame(width: 8, height: 8)
                }
            }
            .frame(width: 370, height: 8)
            .padding(.top, -5)
        })
    }
    
}

#Preview {
    HomeView()
}
