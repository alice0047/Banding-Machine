//
//  UserInfo.swift
//  project2
//
//  Created by Youbin on 4/17/25.
//

enum UserType: String, Codable {
    case mentor
    case runner
}

struct UserInfo: Identifiable, Codable {
    var id: String             // Firebase UID
    var name: String
    var image: String
    var userType: UserType
}

