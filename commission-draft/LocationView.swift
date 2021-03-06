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
    var coordinates: Array<Double>
}

struct LocationView: View {
    
    @Binding var isPresented: Bool

    func getJson() -> [info]{
        let url = Bundle.main.url(forResource: "hospital", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let infos = try? decoder.decode([info].self, from: data)
        return infos!
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var searchText = "";
    
    @State private var medicines_chosen: Array<String> = [];
    
    @State private var showMap = false;
    
    func make_list(items: [info]) -> Array<String>{
        var list: Array<String> = []
        
        for item in items{
            for i in item.medicines.filter({!list.contains($0)}){
                list.append(i)
            }
        }
        
        return list
    }

    var body: some View {
        
        NavigationView{
            
            ZStack{
                
                let medicine_list = make_list(items: getJson())
                
                VStack{
                    
                    Text("한의원 찾기")
                        .font(.title)
                        .padding()
                        .padding(.top)
                    
                    SearchBar(text: $searchText, initialText: "한의학을 입력해주세요...")
                        .padding(.horizontal)
                    
                    if(!medicines_chosen.isEmpty){

                        ScrollView(.horizontal){

                            HStack{

                                ForEach(medicines_chosen, id: \.self){ medicine in
                                    ChosenItem(text: medicine, items: $medicines_chosen)
                                }

                            }
                            .padding(.bottom, 10)

                        }.padding(.horizontal, 40)

                    }
                    
                    if !searchText.isEmpty{
                        
                        ForEach(medicine_list.filter({"\($0)".contains(searchText) && !medicines_chosen.contains("\($0)")}), id: \.self){ item in
                            
                            Button(action:{
                                medicines_chosen.append(item)
                            }){
                                Text(item)
                            }
                            
                        }// foreach
                    }

                    
                    location_scroll(items: getJson(), chosen: medicines_chosen, showMap: $showMap)

                    
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
            
        } // NavView
    } // body
} // view

struct location_scroll: View{
    
    var items: [info]
    var chosen: Array<String>
    @Binding var showMap: Bool
    
    var body: some View{
        ScrollView{
            LazyVGrid(columns: [
                GridItem(.flexible(minimum: 50, maximum: 200), spacing: 25, alignment: .top),
                GridItem(.flexible(minimum: 50, maximum: 200), spacing: 25),
            ], alignment: .leading, spacing: 25, content: {
                
                ForEach(items.filter({Set(chosen).isSubset(of: Set($0.medicines))}), id: \.self){ type in
                    
                    NavigationLink(destination: MapView(isPresented: $showMap, coordinates: type.coordinates, name: type.name)){
                        
                        Text(type.name)
                        
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                    .navigationViewStyle(StackNavigationViewStyle())
                    
                }
            }) // lazyvgrid
            .padding(25)
            .padding(.horizontal)
        } // scroll
    } // body
} // view

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(isPresented: .constant(true))
    }
}
