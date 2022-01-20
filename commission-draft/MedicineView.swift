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
    
    @State private var symptoms_chosen: [String] = []
    
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
    
    func make_list(illness: String) -> Array<String>{
        
        let results = getJson()
        var symptoms_list: Array<String> = []
        
        for item in results.filter({illness == $0.illness}){
            for symptom in item.symptoms {
                symptoms_list.append(symptom)
            }
        }
        
        return symptoms_list
        
    }
    
    
    @State private var searchText = ""
    @State private var illnessChosen = ""
        
    var body: some View {
        
        let isCommon = common.contains(illness)
        let filtered = filtering(illness: illness)

        ZStack{
            VStack{
                
//                Spacer()
//
//                Text(illness)
//                    .font(.title)
                
                Spacer()
                
                SearchBar(text: $searchText)
                    .padding()

                if(!symptoms_chosen.isEmpty || !illnessChosen.isEmpty){

                    ScrollView(.horizontal){

                        HStack{

                            if(!illnessChosen.isEmpty){
                                ChosenText(chosenString: $illnessChosen, ChosenItems: $symptoms_chosen)
                            }

                            ForEach(symptoms_chosen, id: \.self){ symptom in
                                ChosenItem(text: symptom, items: $symptoms_chosen)
                            }

                        }
                        .padding(.bottom, 10)

                    }.padding(.horizontal, 40)

                }
                
                Spacer()
                
                if(!searchText.isEmpty || (!isCommon && illnessChosen.isEmpty)){
                    // show illness list for !isCommon, symptoms list for isCommon

                    if(isCommon){
                        
                        let symptoms_list = make_list(illness: illness)

                        ForEach(symptoms_list.filter({"\($0)".contains(searchText) && !symptoms_chosen.contains("\($0)")}), id: \.self){ item in
                            
                            Button(action:{
                                if(!(symptoms_chosen.contains(item))){
                                    symptoms_chosen.append(item)
                                }
                            }){
                                Text(item)
                            }
                            
                        }// foreach

                    } // if
                    
                    else if (!searchText.isEmpty && !isCommon && !illnessChosen.isEmpty){
                        
                        let symptoms_list = make_list(illness: illnessChosen)
                        
                        ForEach(symptoms_list.filter({"\($0)".contains(searchText) && !symptoms_chosen.contains("\($0)")}), id: \.self){ item in
                            
                            Button(action:{
                                symptoms_chosen.append(item)
                            }){
                                Text(item)
                            }
                            
                        }// foreach
                        
                    }
                    
                    else{
                        
                        if(searchText.isEmpty){
                            
                            ForEach(filtered, id: \.self) { f in
                                Button(action:{
                                    illnessChosen = f.illness
                                }){
                                    Text(f.illness)
                                }
                            }
                            
                        } // if
                        
                        else{
                            
                            ForEach(filtered.filter({$0.illness.contains(searchText)}), id: \.self) { f in
                                Button(action:{
                                    illnessChosen = f.illness
                                }){
                                    Text(f.illness)
                                }
                            }
                            
                        } // else

                    } // else

                } // searchtext empty if
                

                medicine_scroll(filtered: filtered, isCommon: isCommon, symptoms_chosen: symptoms_chosen, illnessChosen: illnessChosen)
                
                Spacer()
                
                Button(action:{
                    isPresented = false
                }){
                    HStack{
                        Text("Close")
                        Image(systemName: "arrow.down")
                    }
                    
                }
                
//                Spacer()
                
            } // VStack
        } // ZStack
        .navigationTitle(illness)
//        .navigationBarTitle("")
//        .navigationBarBackButtonHidden(true)
//        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
       
    }
}

struct medicine_scroll: View{
    
    var filtered: Array<result>
    var isCommon: Bool
    var symptoms_chosen: Array<String>
    var illnessChosen: String
    
    
    var body: some View{
        ScrollView{
            
            LazyVGrid(columns: [
                GridItem(.flexible(minimum: 50, maximum: 200), spacing: 25, alignment: .top),
                GridItem(.flexible(minimum: 50, maximum: 200), spacing: 25),
            ], alignment: .leading, spacing: 25, content: {
                
                if isCommon{
                    
                    ForEach(filtered.filter({Set(symptoms_chosen).isSubset(of: Set($0.symptoms))}), id: \.self){ type in
                        
                        
                        Flashcard(front: {
                            medicine_front(about: type, common: isCommon)
                        }, back: {
                            medicine_back(about: type, common: isCommon)
                        })
                       
                            
                    } // ForEach
                    
                } // if
                
                else if (illnessChosen.isEmpty){
                    
                    ForEach(filtered, id: \.self){ type in
                        
                        Flashcard(front: {
                            medicine_front(about: type, common: isCommon)
                        }, back: {
                            medicine_back(about: type, common: isCommon)
                        })
                       
                            
                    } // ForEach
                    
                } // else if
                
                else if (symptoms_chosen.isEmpty){
                    
                    ForEach(filtered.filter({illnessChosen == $0.illness}), id: \.self){ type in
                        
                        
                        Flashcard(front: {
                            medicine_front(about: type, common: isCommon)
                        }, back: {
                            medicine_back(about: type, common: isCommon)
                        })
                       
                            
                    } // ForEach
                    
                } // else if
                
                else{
                    
                    ForEach(filtered.filter({Set(symptoms_chosen).isSubset(of: Set($0.symptoms)) && illnessChosen == $0.illness}), id: \.self){ type in
                        
                        
                        Flashcard(front: {
                            medicine_front(about: type, common: isCommon)
                        }, back: {
                            medicine_back(about: type, common: isCommon)
                        })
                       
                            
                    } // ForEach
                    
                }
                
            }).padding(25)
            .padding(.horizontal)

            
        } // ScrollView, medicines

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

//struct MedicineView_Previews: PreviewProvider {
//    static var previews: some View {
//        MedicineView(isPresented: .constant(true), illness: .constant("감기"))
//    }
//}

