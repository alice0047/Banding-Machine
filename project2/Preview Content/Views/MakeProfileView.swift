//
//  MakeProfileView.swift
//  project2
//
//  Created by Youbin on 4/15/25.
//

import SwiftUI

struct MakeProfileView: View {
    @State var nickname: String = ""
    
    @State private var currentPage: Int = 1
    
    var body: some View {
        ZStack(alignment: .top, content: {
            Color(.main)
                .ignoresSafeArea()
            
            CustomNavigation(action: navigationAction, title: "프로필 생성", showBackBtn: currentPage == 2)
            
            VStack(alignment: .center, content: {
                Spacer().frame(height: 270)
                
                switch currentPage {
                case 1:
                    nicknameInput
                case 2:
                    imageInput
                default:
                    EmptyView()
                }
            })
            .onAppear (perform : UIApplication.shared.hideKeyboard)
        })
    }
    
    //MARK: - 1. 닉네임 입력 페이지
    private var nicknameInput: some View {
        VStack(alignment: .center,content: {
            nicknameField
            
            Spacer()
            
            nextBtn
        })
    }
    
    //MARK: - 닉네임 입력 필드
    private var nicknameField: some View {
        VStack(alignment: .center, spacing: 35,content: {
            Text("닉네임을 입력하세요")
                .font(.pixel25)
                .foregroundStyle(.sub)
            
            TextField(text: $nickname) {
                Text("닉네임을 입력해주세요")
                    .foregroundStyle(Color.white)
                    .font(.pixel19)
            }
            .padding()
            .frame(width:354, height: 59)
            .foregroundStyle(Color.white)
            .background(.sub)
            .font(.pixel19)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .autocorrectionDisabled() //텍스트 필드 시뮬 입력 빨라짐
        })
        .frame(width:354, height: 114)
    }
    
    //MARK: - 다음 버튼
    private var nextBtn: some View {
        HStack(content: {
            Spacer()
            
            Button(action: {
                withAnimation {
                    currentPage = 2
                }
            }, label: {
                Image("nextBtn")
                    .resizable()
                    .frame(width:50, height: 50)
            })
            .padding(.bottom,8)
            
            Spacer().frame(width: 22)
        })
    }
               
               
    //MARK: - 2. 사진 입력 페이지
    private var imageInput: some View {
        VStack(alignment: .center, spacing: 35,content: {
            Text("프로필 사진을 선택해주세요")
                .font(.pixel25)
                .foregroundStyle(.sub)
            
            profileImage
        })
    }
    
    //MARK: 프로필 사진 선택
    private var profileImage: some View {
            VStack {
                Button(action: {
                    
                }, label: {
                    
                })
            }
        }
    
    //MARK: - Functions
    private var navigationAction: () -> Void {
        switch currentPage {
        case 2:
            return {
                withAnimation {
                    currentPage = 1
                }
            }
        default:
            return {}
        }
    }
    

}


#Preview {
    MakeProfileView()
}

