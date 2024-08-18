//
//  LocationSearchViewModel.swift
//  UberClone
//
//  Created by Lorenzo Menino on 15/08/2024.
//

import Foundation
import MapKit

class LocationSearchViewModel : NSObject, ObservableObject {
    
    // MARK: - properties
    
    @Published var results = [ MKLocalSearchCompletion]() // permet de compléter la recherche
    @Published var selectedLocationCoordinate : CLLocationCoordinate2D? // Optionnel car quand on initialise le viewModel, rien n'est sélectionné et donc stocké dans la variable
    
    private let searchCompleter = MKLocalSearchCompleter() // va utilsier pour la recherche
    var queryFragment : String = "" {
        // A chaque fois qu'on change le textField lié, on dit print le, c'est ce que le didset fait
        didSet {
           // print("DEBUG : Query Fragment is \(queryFragment)")
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    // MARK: - Life Cycle
    
    // on doit se conformer au NSObject protocol donc on override pour avoir les fonctionnalités de MKLocalsearchCompletion
    
    override init() {
        super.init() // On se conforme à une classe NSObject donc on doit super init
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment // ce queryFragment est ce qu'utilise le completer pour rechercher les locations
    }
    
    // MARK: - Helpers
    // MKLocalSearchCompletion nous donne pas de coordonnée mais l'adresse en string, on doit la prendre et faire une recherche avec une searchRequest pour nous donner un objet de location
    func selectedLocation(_ localSearch: MKLocalSearchCompletion) {
        // C'est la qu'on a accès à la callback fonction
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            if let error = error {
                print("DEBUG: Location search failed \(error.localizedDescription)")
                return // on met un return car en cas d'erreur on ne veut aps que le code en dessous soit lu
            }
            // Nous permet d'avoir les coordonnées à partir de la recherche
            
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            self.selectedLocationCoordinate = coordinate
            print("DEBUG : Location coordinates \(coordinate)")
        }
    }
    
    func locationSearch(forLocalSearchCompletion localSearch : MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle) // naturalLanguage est l'adresse que nous récupérons de localSearch completion
        let search = MKLocalSearch(request: searchRequest) // c'est la que la requête est exécutée
        
        search.start(completionHandler: completion) // on a une completion car la recherche utilise une sorte d'API pour nous donner des resultats, quand ils reviennent, c'est avec un callback ou completion handler
    }
}


// MARK: - MKLocalSearchCompleterDelegate

extension LocationSearchViewModel : MKLocalSearchCompleterDelegate {
    
    // cette fonction est appelée lorsqu'on éxecute une recherche basée sur queryFragment et que la recherche est terminée. Se fait en background
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
