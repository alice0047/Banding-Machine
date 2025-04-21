//
//  MyPageView.swift
//  project2
//
//  Created by Youbin on 4/16/25.
//

import SwiftUI

struct MyPageView: View {
    @StateObject private var messageVM = ReadMessageViewModel()
    @AppStorage("nickname") private var nickname: String = ""
    @AppStorage("profileImageURL") private var profileImage: String = ""
    
    var body: some View {
        NavigationStack {
            
            ZStack(alignment: .top, content: {
                
                Color(.main)
                    .ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 25) {
                    CustomNavigation(title: "마이페이지", showBackBtn: true, action: {
                        print("뒤로가기 버튼 눌림")
                    })
                    
                    profileField
                    myMessageField
                }
            })
            .task {
                await messageVM.fetchMessages(for: nickname)
            }
        }
    }
    
    //MARK: - 프로필 필드
    private var profileField: some View {
        HStack(alignment: .center, spacing: 17, content: {

            AsyncImage(url: URL(string: profileImage)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 53, height: 53)
            .clipShape(Circle())

            Text(nickname)
                .foregroundStyle(.mainText)
                .font(.pixel39)
            
            Spacer()
            
            Button(action: {
                print("프로필 수정 버튼 클릭함")
            }, label: {
                Text("프로필 수정")
                    .font(.pretendardMedium17)
                    .foregroundStyle(.white)
                    .frame(width: 106, height: 34)
                    .background(content: {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.sub)
                    })
            })
        })
        .frame(width:360, height: 53)
    }
    
    //MARK: - 작성한 메시지 필드
    private var myMessageField: some View {
        VStack(alignment: .leading, spacing: 13, content: {
            
            Text("내가 작성한 메시지")
                .font(.pretendardSemiBold20)
                .padding(.top, 31)
            
            ScrollView() {
                if messageVM.messages.isEmpty {
                    VStack(alignment: .center, spacing: 25, content: {
                        
                        Text("작성한 메시지가 없습니다")
                            .font(.pretendardSemiBold18)
                            .foregroundStyle(.mainText)
                        
                        Text("자판기에서 TOPIC을 뽑아,\n멘토에게 메시지를 작성해보세요")
                            .font(.pretendardRegular16)
                            .foregroundStyle(.gray02)
                            .multilineTextAlignment(.center)
                    })
                    .frame(width: 372, height: 400)
                } else {
                    VStack(alignment: .center, spacing:13, content: {
                        ForEach(messageVM.messages) { message in
                            NavigationLink {
                                MessageDetailView(message: message)
                            } label: {
                                MessageCard(info: message)
                            }
                        }
                    })
                    .padding(.horizontal, 2)
                    .padding(.top, 3)
                    .padding(.bottom, 20)
                }
            }
        })
        .frame(minWidth: 405, maxHeight: .infinity)
        .background(.white)
        .clipShape(UnevenRoundedRectangle(topLeadingRadius: 25, topTrailingRadius: 25))
        .ignoresSafeArea(.all)
    }
}

#Preview {
    MyPageView()
}
