//
//  MessageCard.swift
//  project2
//
//  Created by Youbin on 4/16/25.
//

import SwiftUI

struct MessageCard: View {
    var body: some View {
        VStack(content: {
            
        })
        .frame(width: 368, height: 190)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.red, lineWidth: 2)
        )
    }
}

#Preview {
    MessageCard()
}
