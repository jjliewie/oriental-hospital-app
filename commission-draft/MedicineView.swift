//
//  MedicineView.swift
//  commission-draft
//
//  Created by Julie Rhee on 1/5/22.
//

import SwiftUI



struct MedicineView: View {
    @Binding var isPresented: Bool
    @Binding var illness: String
    
    let common: Array<String> = ["감기", "보약", "소화기", "치료약", "변비"]
        
    func getJson() -> [result]{
        let url = Bundle.main.url(forResource: "symptoms", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let results = try? decoder.decode([result].self, from: data)
        return results!
    }
    
    func filtering(illness: String) -> Array<result>{
        
        
        let results = getJson()
        
        var filtered_results: Array<result> = []
        
        if !common.contains(illness){
            for item in results.filter({!common.contains($0.illness)}){
                filtered_results.append(item)
            }
        }
        
        else{
            for item in results.filter({illness == $0.illness}){
                filtered_results.append(item)
            }
        }
        
        
        return filtered_results
            
    }
    
    
    @State private var searchText = ""
        
    var body: some View {
        
        let isCommon = common.contains(illness)
        let filtered = filtering(illness: illness)
        
        ZStack{
            VStack{
                
                Spacer()
                
                Text(illness)
                    .font(.title)
                
                Spacer()
                
                SearchBar(text: $searchText)
                    .padding()
                
                Spacer()
                
                if !isCommon{
                    ForEach(filtered, id: \.self) { f in
                        Button(action:{
                            
                        }){
                            Text(f.illness)
                        }
                    }
                }
                
                
                ScrollView{
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible(minimum: 50, maximum: 200), spacing: 25, alignment: .top),
                        GridItem(.flexible(minimum: 50, maximum: 200), spacing: 25),
                    ], alignment: .leading, spacing: 25, content: {
                        
                        ForEach(filtered, id: \.self){ type in
                            
                            
                            Flashcard(front: {
                                medicine_front(about: type, common: isCommon)
                            }, back: {
                                medicine_back(about: type, common: isCommon)
                            })
                           
                                
                        } // ForEach
                        
                        
                    }).padding(20)

                    
                }
                
                Spacer()
                
                Button(action:{
                    isPresented = false
                }){
                    HStack{
                        Text("Close")
                        Image(systemName: "arrow.down")
                    }
                    
                }
                
                Spacer()
            } // VStack
        } // ZStack
        .navigationTitle(illness)
//        .navigationBarTitle("")
//        .navigationBarBackButtonHidden(true)
//        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
       
    }
}

struct medicine_back: View {
    
    var about: result
    var common: Bool
    
    var body: some View {
        VStack{
            
            ScrollView{
                VStack{
                    ForEach(about.symptoms, id: \.self){ item in
                        Text(item)
                    } // ForEach
                }
            }
            
        }
        .padding()
        .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.offWhite)
        )
    }
}

struct medicine_front: View {
    
    var about: result
    var common: Bool
    
    var body: some View {
        VStack{
            
            if common{
                Text(about.medicine)
                    .font(.title)
            }
            
            else{
                
                Text(about.illness)
                Text(about.medicine)

            }
            
        }
        .padding()
        .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.offWhite)
        )
    }
}

struct MedicineView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineView(isPresented: .constant(true), illness: .constant("감기"))
    }
}
