//
//  EditProfileView.swift
//  project2
//
//  Created by Youbin on 4/16/25.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @State var nickname: String = ""
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    @State private var currentPage: Int = 1
    
    var body: some View {
        ZStack(alignment: .top, content: {
            
            Color(.main)
                .ignoresSafeArea()
            
            VStack(alignment: .center, content: {
                
                CustomNavigation(title: "프로필 수정", showBackBtn: true, action: {print("뒤로가기 버튼 누름")})
                
                Spacer().frame(height: 56)
                
                profileImage
                
                Spacer().frame(height: 50)
                
                nicknameField
                
                Spacer()
            })
            
            HStack(alignment: .center, content: {
                Spacer()
                
                Button(action: {
                    print("완료 버튼 눌림")
                }, label: {
                    Text("완료")
                        .font(.pretendardRegular17)
                        .foregroundStyle(.white)
                        .frame(width: 64, height: 34)
                        .background(content: {
                            RoundedRectangle(cornerRadius: 40)
                                .fill(.sub)
                            })
                })
                .padding(.trailing, 16)
                
                
            })
        })
        .onAppear (perform : UIApplication.shared.hideKeyboard)

    }
    
    //MARK: 프로필 사진 선택
    private var profileImage: some View {
        VStack {
            PhotosPicker(
                selection: $selectedItem,
                matching: .images,
                photoLibrary: .shared()) {
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                    } else {
                        ZStack {
                            Circle()
                                .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                .foregroundStyle(.sub)
                                .frame(width: 200, height: 200)
                                
                            Image("plusBtn")
                                .foregroundColor(.black)
                                .frame(width: 50, height: 50)
                        }
                    }
                }
                .onChange(of: selectedItem) {
                    Task {
                        if let data = try? await selectedItem?.loadTransferable(type: Data.self),
                           let uiImage = UIImage(data: data) {
                            selectedImage = uiImage
                        }
                    }
                }
            }
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
}

#Preview {
    EditProfileView()
}
