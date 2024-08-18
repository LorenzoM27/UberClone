//
//  UberMapViewRepresentable.swift
//  UberClone
//
//  Created by Lorenzo Menino on 31/07/2024.
//

// Create a view using UIKIT andnrepresent it in SwiftUI

import SwiftUI
import MapKit

// Using this protocole, to configure our MapView
struct UberMapViewRepresentable : UIViewRepresentable {
    
    let mapView = MKMapView()
   // let locationManager = LocationManager.shared // on accède à la variable shared qui fonctionne comme un environment // in our Plist, we have to modify to ask permission
    // @StateObject var locationSearchViewModel = LocationSearchViewModel() // Cette instance de la VM ne connait pas les infos de selectedLocation de l'instance de la vue LocationSearchView car ce sont deux instances différentes, on va alors créer un Environment Object
    @Binding var mapState : MapViewState
    @EnvironmentObject var locationViewModel : LocationSearchViewModel
    
    // our view, represented in our app
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("DEBUG: mapState is \(mapState)")
        
        switch mapState {
        case .noInpute:
            context.coordinator.clearMapViewAndRecenterUser()
            break
        case .searchingForLocation:
            break
        case .locationSelected:
            if let coordinate = locationViewModel.selectedLocationCoordinate {
                context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
                context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
            }
            break
        }
        
//        if mapState == .noInpute {
//            context.coordinator.clearMapViewAndRecenterUser()
//        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension UberMapViewRepresentable {
    // a middle af a UIView and UIKit fonctionalities
    class MapCoordinator : NSObject, MKMapViewDelegate {
        
        //MARK: - Properties
        let parent : UberMapViewRepresentable
        var userLocationCoordinate: CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion?
        
        // MARK: - Lifecycle
        
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        // MARK: - MKMapViewDelegate
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: userLocation.coordinate.latitude,
                    longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            self.currentRegion = region // everytime user update his location, it's gonna update the current region and the mapView as well
            
            parent.mapView.setRegion(region, animated: true)
        }
        
        // on utilise cette delegate pethod pour dire à notre mapView de dessiner l'overlay (trait bleu) avec la route sélectionnée, to telle the mapView How to draw the line
        func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 6
            return polyline
        }
        
        // MARK: - Helpers
        
        // va nousb permettre d'ajouter des annotations
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            parent.mapView.addAnnotation(anno) // On utilise self quand on est dans un bloc, comme completion handler
            parent.mapView.selectAnnotation(anno, animated: true)
            // On ne veut plus que la map nous centre sur le lieu sélectionné. Voir let rect dans la fonction configurePolyline
          //  parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        
        // this helper function to configure the polyline using the getdestinationFunction
        func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
            guard let userLocationCoordinate = self.userLocationCoordinate else { return }
            getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
                
                // permet de centrer la map sur le trajet au dessus de a la vue de sélection d'uber
                let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect,
                                                               edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
                
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
        
        // we have this helper function to get the destination route
        func getDestinationRoute(from userLocation: CLLocationCoordinate2D,
                                 to destination: CLLocationCoordinate2D, completion: @escaping(MKRoute) -> Void) {
            let userPlacemark = MKPlacemark(coordinate: userLocation)
            let destPlacemark = MKPlacemark(coordinate: destination)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: userPlacemark)
            request.destination = MKMapItem(placemark: MKPlacemark(placemark: destPlacemark))
            let directions = MKDirections(request: request)
            // la directions request est une API, underground une recherche est faite pour générer la route c'est pourquoi on a une completion bloc dans la fonction configureDestinationRoute
            directions.calculate { response, error in
                if let error = error {
                    print("DEBUG: Failed to get directions with error \(error.localizedDescription)")
                    return
                }
                
                guard let route = response?.routes.first else { return } // Génération de la route, first pour la première car souvent la plus rapide, il y en a 3
                completion(route)
            }
        }
        
        func clearMapViewAndRecenterUser() {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            
            if let currentRegion = currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
    }
}
