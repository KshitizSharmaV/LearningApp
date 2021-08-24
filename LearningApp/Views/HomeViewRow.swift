//
//  HomeViewRow.swift
//  LearningApp
//
//  Created by Kshitiz Sharma on 8/23/21.
//

import SwiftUI

struct HomeViewRow: View {
    
    var image : String
    var title : String
    var description: String
    var count: String
    var time: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(5.0)
                .shadow(radius: 5)
                .aspectRatio(CGSize(width: 1000, height: 500),
                         contentMode: .fill)
            
            HStack {
                Image(image)
                    .resizable()
                    .frame(width:116, height:116)
                    .clipShape(Circle())
                
                Spacer()
                
                VStack(alignment:.leading, spacing:10) {
                    Text(title)
                        .font(.title3)
                        .bold()
                    Text(description)
                        .font(.caption)
                    
                    HStack {
                        Image(systemName: "book")
                        Text(count)
                            .font(Font.system(size:8))
                        
                        Image(systemName: "clock")
                        Text(time)
                            .font(Font.system(size:8))
                    }
                    .foregroundColor(.gray)
                }
                .padding(.leading,20)
            }.padding()
        }
    }
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRow(image: "swift", title: "Learn Swift", description: "Learn how to code in Swift UI", count: "3 Lessons", time: "2 Hours")
    }
}
