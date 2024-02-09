//
//  ViewController.swift
//  HWS-Project-16
//
//  Created by Ade Dwi Prayitno on 09/02/24.
//

import MapKit
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(mapType))
        setupMarker()
    }
    
    @objc func mapType() {
        let ac = UIAlertController(title: "Map Type", message: nil, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: { [weak self] _ in
            guard let self else { return }
            self.mapView.mapType = .standard
        }))
        
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: { [weak self] _ in
            guard let self else { return }
            self.mapView.mapType = .satellite
        }))
        
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: { [weak self] _ in
            guard let self else { return }
            self.mapView.mapType = .hybrid
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        present(ac, animated: true)
    }
    
    func setupMarker() {
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
    }

}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        let identifier  = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            
            annotationView?.tintColor = .blue
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        let placeName = capital.title
        let placeInfo = capital.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Detail", style: .default, handler: { [weak self] _ in
            guard let self, let placeName else { return }
            self.navigateToDetail(cityName: placeName)
        }))
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    func navigateToDetail(cityName: String) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            
            vc.cityName = cityName
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
