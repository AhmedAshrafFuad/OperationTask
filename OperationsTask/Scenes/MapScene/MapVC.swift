//
//  MapVC.swift
//  OperationsTask
//
//  Created by AHMED ASHRAF on 27/12/2020.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var location: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        setupNavigationbar()
        zoomOnLocation()
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
  
    func zoomOnLocation(){
        let region = MKCoordinateRegion( center: location.coordinate, latitudinalMeters: CLLocationDistance(exactly: 5000)!, longitudinalMeters: CLLocationDistance(exactly: 5000)!)
        mapView.setRegion(mapView.regionThatFits(region), animated: false)
    }

    func setupNavigationbar(){
        navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
  

}
