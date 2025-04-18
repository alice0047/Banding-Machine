//
//  MyPageView.swift
//  project2
//
//  Created by Youbin on 4/16/25.
//

import SwiftUI

struct MyPageView: View {
    @StateObject private var profileVM = ProfileViewModel()
    @AppStorage("nickname") private var nickname: String = ""
    
    var body: some View {
        ZStack(alignment: .top, content: {
            
            Color(.main)
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 25, content: {
                CustomNavigation(title: "마이페이지", showBackBtn: true, action: {print("뒤로가기 버튼 눌림")})
                
                profileField
                
                myMessageField
                
            })
        })
        .task {
            await profileVM.fetchUserInfo(nickname: nickname)
        }
    }
    
    //MARK: - 프로필 필드
    private var profileField: some View {
        HStack(alignment: .center, spacing: 17, content: {

            if let user = profileVM.userInfo {
                AsyncImage(url: URL(string: user.image)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 53, height: 53)
                .clipShape(Circle())

                Text(user.name)
                    .foregroundStyle(.mainText)
                    .font(.pixel39)
            } else {
                ProgressView()
            }
            
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
                VStack(alignment: .center, spacing:13, content: {
                    
                    MessageCard()
                    
                    MessageCard()
                    
                    
                })
                .padding(.horizontal, 2)
                .padding(.vertical, 3)
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
