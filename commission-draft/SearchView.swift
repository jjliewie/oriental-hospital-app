//
//  SearchView.swift
//  commission-draft
//
//  Created by Julie Rhee on 1/4/22.
//

import SwiftUI

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

extension Array where Element: Equatable {

 // Remove first collection element that is equal to the given `object`:
 mutating func remove(object: Element) {
     guard let index = firstIndex(of: object) else {return}
     remove(at: index)
 }

}

extension Color {
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
    static let gradColor_pink = LinearGradient(Color("peach"), Color("salmon"))
    
    static let gradColor_blue = LinearGradient(Color("grey"), Color("seaFoam"))
    
    static let gradColor_lightPink = LinearGradient(Color("lighterPink"), Color("pink"))
    
    static let gradColor_bluePink = LinearGradient(Color("pink"), Color("powderBlue"))
    
    static let gradColor_rainbow = LinearGradient(Color("coral"), Color("mango"), Color("redOrange"), Color("turquoise"), Color("lightBlue"), Color("pink"))
}

struct product: Codable, Hashable {
    var name: String
    var location: String
    var keywords: Array<String>
}

struct SearchView: View {
    
    @Binding var isPresented: Bool
    
    @State private var searchText = ""
    @State private var symptoms_chosen: [String] = []
    let symptoms = ["Cold", "Coughing", "Diarrhea", "Leg Pain", "Back Pain", "Heart Pain", "Nausea", "Fever", "Chest Pain"]
    
    func getJson() -> [product]{
        let url = Bundle.main.url(forResource: "data", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let products = try? decoder.decode([product].self, from: data)
        return products!
    }
    
    var body: some View {
                
        NavigationView {
            
            ZStack{
                
                Color.offWhite
                    .ignoresSafeArea()
                
                
                VStack{
                    
                    HStack{
                        Text("Testing")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }.padding([.leading, .top])
                    
                    SearchBar(text: $searchText)
                        .padding()
                    
                    
                    if(!symptoms_chosen.isEmpty){
            
                        ScrollView(.horizontal){
                            
                            HStack{
                                ForEach(symptoms_chosen, id: \.self){ symptom in
                                    ChosenSymptom(text: symptom, symptoms: $symptoms_chosen)
                                }
                            }
                            .padding(.bottom, 10)
                        }.padding(.horizontal)

                    }
                    
                    ScrollView {
                        
                        if(symptoms_chosen.isEmpty || !searchText.isEmpty){
                            ForEach(symptoms.filter({"\($0)".contains(searchText) || searchText.isEmpty}), id: \.self) { s in
                                Button(action: {
                                    if(!(symptoms_chosen.contains(s))){
                                        symptoms_chosen.append(s)
                                    }
                                    searchText = ""
                                }, label: {
                                    Text(s)
                                })

                            }
                        }
                        
                        else{
                            
                            LazyVGrid(columns: [
                                GridItem(.flexible(minimum: 50, maximum: 200), spacing: 25, alignment: .top),
                                GridItem(.flexible(minimum: 50, maximum: 200), spacing: 25),
                            ], alignment: .leading, spacing: 25, content: {
                                ForEach(getJson().filter({Set(symptoms_chosen).isSubset(of: Set($0.keywords))}), id: \.self) { item in
                                    
                                    NavigationLink(destination: HospitalView(hospital: item)) {
                                        
                                        HospitalInfo(hospital: item)
                                    }
//                                    Button(action: {}, label: {
//                                        HospitalInfo(hospital: item)
//                                    })
                                    
                                }
                            }).padding()
                            
                        }
                        
                        
                    } // Scroll
                } // VStack
                .padding(.horizontal)
                
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
            
            // ZStack
        } // Nav View
    } // Body
} // View

struct HospitalInfo: View {

    let hospital: product

    var body: some View {
        
        VStack(alignment: .leading, spacing: 4) {

            Image(systemName: "star")
                .resizable()
                .scaledToFit()
                .cornerRadius(22)

            Text(hospital.name)
                .font(.system(size: 10, weight: .semibold))
                .padding(.top, 4)
            
            Text(hospital.location)
                .font(.system(size: 10, weight: .regular))


        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.gradColor_blue)
//                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
//                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
        )
    }
}


struct ChosenSymptom: View {
    var text: String
    @Binding var symptoms : Array<String>

    var body: some View {
        
        HStack{
            Text(text)
                .lineLimit(1)
            
            Button(action: {
                symptoms.remove(object: text)
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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(isPresented: .constant(true))
    }
}
