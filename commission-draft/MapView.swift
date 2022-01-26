//
//  MapView.swift
//  commission-draft
//
//  Created by Julie Rhee on 1/1/22.
//

import SwiftUI
import MapKit

// not done yet

struct AnnotatedItem: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    
    @StateObject private var viewModel = MapViewModel()
    @Binding var isPresented: Bool
    var coordinates: Array<Double>
    var name: String
    
    private var hospital : Array<AnnotatedItem>{
        get{
            return [AnnotatedItem(name: name, coordinate: .init(latitude: coordinates[0], longitude: coordinates[1]))]
        }
    }
    
    var body: some View {
        
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: hospital){ item in
            MapAnnotation(coordinate: item.coordinate){
                PlaceAnnotationView(title: name)
            }
        }
            .edgesIgnoringSafeArea(.all)
            .accentColor(Color(.systemPink))
            .onAppear{
                viewModel.checkLocationEnabled()
            } // onAppear
        
    } // body
} // View


struct PlaceAnnotationView: View {
  @State private var showTitle = true
  
  let title: String
  
  var body: some View {
    VStack(spacing: 0) {
      Text(title)
        .font(.callout)
        .padding(5)
        .background(Color(.white))
        .cornerRadius(10)
        .opacity(showTitle ? 0 : 1)
      
      Image(systemName: "mappin.circle.fill")
        .font(.title)
        .foregroundColor(.red)
      
      Image(systemName: "arrowtriangle.down.fill")
        .font(.caption)
        .foregroundColor(.red)
        .offset(x: 0, y: -5)
    }
    .onTapGesture {
      withAnimation(.easeInOut) {
        showTitle.toggle()
      }
    }
  }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(isPresented: .constant(true), coordinates: [37.4847597769363, 126.97234422654503], name: "경희어울림한의원")
    }
}
