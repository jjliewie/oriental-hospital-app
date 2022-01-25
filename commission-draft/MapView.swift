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
    
//    @State var region =  MKCoordinateRegion(
//                center: CLLocationCoordinate2D(latitude: 37.4847597769363, longitude: 126.97234422654503),
//              span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    var body: some View {
        
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: hospital){ item in
            MapMarker(coordinate: item.coordinate, tint: .red)
        }
            .edgesIgnoringSafeArea(.all)
            .accentColor(Color(.systemPink))
            .onAppear{
                viewModel.checkLocationEnabled()
            } // onAppear
        
    } // body
} // View


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(isPresented: .constant(true), coordinates: [37.4847597769363, 126.97234422654503], name: "경희어울림한의원")
    }
}
