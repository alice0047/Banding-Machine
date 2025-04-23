//
//  Mentor.swift
//  project2
//
//  Created by Youbin on 4/24/25.
//

import Foundation

struct Mentor: Identifiable {
    let id: UUID = UUID()
    let name: String
    let profileImageURL: String? // 이미지가 있을 수도 없을 수도
}

// 샘플 멘토 배열
extension Mentor {
    static let sampleList: [Mentor] = [
        Mentor(name: "Lingo", profileImageURL: nil),
        Mentor(name: "Gommin", profileImageURL: nil),
        Mentor(name: "Isaac", profileImageURL: nil),
        Mentor(name: "Dora", profileImageURL: nil),
        Mentor(name: "MK", profileImageURL: nil),
        Mentor(name: "Jiku", profileImageURL: nil),
        Mentor(name: "Leeo", profileImageURL: nil),
        Mentor(name: "Jason", profileImageURL: nil),
        Mentor(name: "Saya", profileImageURL: nil),
        Mentor(name: "Judy", profileImageURL: nil),
        Mentor(name: "Sup", profileImageURL: nil),
        Mentor(name: "Daisy", profileImageURL: nil),
        Mentor(name: "Nathan", profileImageURL: nil),
        Mentor(name: "Lumi", profileImageURL: nil),
        Mentor(name: "Friday", profileImageURL: nil),
        Mentor(name: "Howard", profileImageURL: nil),
        Mentor(name: "Sunny", profileImageURL: nil),
        Mentor(name: "Mano", profileImageURL: nil)
    ]
}
