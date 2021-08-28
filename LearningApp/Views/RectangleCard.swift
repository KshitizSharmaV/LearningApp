//
//  RectangleCard.swift
//  LearningApp
//
//  Created by Kshitiz Sharma on 8/26/21.
//

import SwiftUI

struct RectangleCard: View {
    
    var color = Color.white
    var body: some View {
        Rectangle()
            .foregroundColor(color)
            .cornerRadius(10)
            .shadow(radius: 10)
    }
}

struct RectangleCard_Previews: PreviewProvider {
    static var previews: some View {
        RectangleCard()
    }
}
