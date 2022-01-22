//
//  LocationView.swift
//  commission-draft
//
//  Created by Julie Rhee on 1/21/22.
//

import SwiftUI

struct info: Codable, Hashable {
    var name: String
    var location: String
    var medicines: Array<String>
}

struct LocationView: View {
    
    func getJson() -> [info]{
        let url = Bundle.main.url(forResource: "hospital", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let infos = try? decoder.decode([info].self, from: data)
        return infos!
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var searchText = "";

    var body: some View {
        
        ZStack{
            
            VStack{
                
                Text("hello")
                
                SearchBar(text: $searchText, initialText: "한의학을 입력해주세요...")
                    .padding()
                
                if !searchText.isEmpty{
                    Text("hello world")
                }
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }){
                    
                    HStack{
                        Image(systemName: "arrow.down")
                        Text("Back")
                    }
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                    )
                }
                
            }// VStack
            
            
        } // ZStack
        
    } // body
} // view

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
