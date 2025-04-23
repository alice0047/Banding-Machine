//
//  HomeViewModel.swift
//  project2
//
//  Created by Youbin on 4/24/25.
//

import Foundation
import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    @Published var selectedCategoryRaw: String = ""
    @Published var selectedMentor: Mentor? = nil
    @Published var currentPage: Int = 0

    let mentorsPerPage: Int = 9
    let mentors: [Mentor] = Mentor.sampleList

    // 멘토 목록을 페이지(9명씩)로 분리
    var pages: [[Mentor]] {
        stride(from: 0, to: mentors.count, by: mentorsPerPage).map {
            Array(mentors[$0..<min($0 + mentorsPerPage, mentors.count)])
        }
    }

    var selectedCategory: TopicCategory? {
        TopicCategory(rawValue: selectedCategoryRaw)
    }

    // TopicSheet나 다음 뷰로 넘길 구조체
    struct SelectionInfo: Hashable {
        let category: TopicCategory
        let mentorName: String
    }

    // 선택이 완료되면 SelectionInfo로 캡슐화
    func getSelectionInfo() -> SelectionInfo? {
        guard let mentor = selectedMentor,
              let category = selectedCategory else { return nil }

        return SelectionInfo(category: category, mentorName: mentor.name)
    }
}
