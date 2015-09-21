//
//  MapViewController.swift
//  TryCycle-Swift2
//
//  Created by tho dang on 2015-09-20.
//  Copyright © 2015 Tho Dang. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
     var locationManager = CLLocationManager()

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
                // JSON Parsing from BikeShareToronto
        let url = NSURL(string: "http://www.bikesharetoronto.com/stations/json")
        let data = NSData(contentsOfURL: url!)
        
        if let contentData = data {
        if let json = (try? NSJSONSerialization.JSONObjectWithData(contentData, options: NSJSONReadingOptions.MutableContainers)) as? NSDictionary {
            let station = Station(json: json)
            for pins in station.mapPins{
                mapView.addAnnotation((pins as? MapPin)!)
                
                }
            
            }
        }
        mapSetUp()
    }
    
    func mapSetUp() {
    
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        self.locationManager.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            mapView.showsUserLocation = true
            
        }
        // Zoom in Locations
        let centre: CLLocationCoordinate2D = CLLocationCoordinate2DMake(43.6466,-79.3864)
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        let regionToDisplay = MKCoordinateRegionMake(centre, span)
        self.mapView.setRegion(regionToDisplay, animated: true)
    
    }
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        // Step 1
        let identifier = "MapPin"
        
        // Step 2
        if annotation.isKindOfClass(MapPin.self) {
            // Step 3
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
            
            if annotationView == nil {
                // Step 4
                annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:identifier)
                annotationView!.canShowCallout = true
                
                // Step 5
                let btn = UIButton(type: .DetailDisclosure)
                
                annotationView!.rightCalloutAccessoryView = btn
                let leftIconView = UIImageView(frame: CGRectMake(0, 0, 40, 40))
                leftIconView.image = UIImage(named: "bike")
                annotationView!.leftCalloutAccessoryView = leftIconView
            } else {
                // Step 6
                annotationView!.annotation = annotation
            }
            
            return annotationView
        }
        
        // Step 7
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView,
        calloutAccessoryControlTapped control: UIControl) {
            let location = view.annotation as! MapPin
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            location.mapItem().openInMapsWithLaunchOptions(launchOptions)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
