//
//  MentorGridView.swift
//  project2
//
//  Created by Youbin on 4/24/25.
//

import SwiftUI

struct MentorGridView: View {
    let mentors: [Mentor]
    @Binding var selectedMentor: Mentor?

    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 13) {
            ForEach(mentors) { mentor in
                RoundedRectangle(cornerRadius: 10)
                    .fill(selectedMentor?.id == mentor.id ? .main : .gray00)
                    .frame(width: 110, height: 137)
                    .overlay(
                        Text(mentor.name)
                            .foregroundColor(.white)
                            .font(.headline)
                    )
                    .onTapGesture {
                        selectedMentor = mentor
                    }
            }
        }
    }
}

