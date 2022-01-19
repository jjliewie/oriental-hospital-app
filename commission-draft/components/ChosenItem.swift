//
//  ChosenItem.swift
//  commission-draft
//
//  Created by Julie Rhee on 1/18/22.
//

import SwiftUI

struct ChosenItem: View {
    var text: String
    @Binding var items : Array<String>

    var body: some View {

        HStack{
            Text(text)
                .lineLimit(1)
            
            Button(action: {
                items.remove(object: text)
                
            }) {
                Image(systemName: "multiply.circle.fill")
                    .foregroundColor(.white)
            }

        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray)
        )
        
    }
}

struct ChosenText: View {
    
    @Binding var chosenString: String

    var body: some View {
        
        HStack{
            Text(chosenString)
                .lineLimit(1)
            
            Button(action: {
                chosenString = ""
                
            }) {
                Image(systemName: "multiply.circle.fill")
                    .foregroundColor(.white)
            }

        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue)
        )
        
    }
}
