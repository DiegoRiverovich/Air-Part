//
//  ContactsViewController.swift
//  Air-Part
//
//  Created by Андрей Бабий on 21.08.17.
//  Copyright © 2017 Андрей Бабий. All rights reserved.
//

import UIKit
import MapKit

class ContactsViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var toolButton: UIBarButtonItem!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var map: MKMapView!
    var annotation = MKPointAnnotation()
    /*
    class var GsharedInstance: MKMapView {
        struct Static {
            static let instance: MKMapView = MKMapView()
        }
        return Static.instance
    }
*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showShopLocation()
        
        scrollView.resizeScrollViewContentSize()
        
        sideMenus()
        customizeNavBar()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //super.viewDidDisappear(animated)
        
        switch (self.map.mapType) {
        case MKMapType.hybrid:
            self.map.mapType = MKMapType.standard
            break;
        case MKMapType.standard:
            self.map.mapType = MKMapType.hybrid
            break;
        default:
            break;
        }
        self.map.removeAnnotation(annotation)
        self.map.showsUserLocation = false
        //self.map.delegate = nil
        self.map.removeFromSuperview()
        self.map = nil
    }
    /*
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        switch (self.map.mapType) {
        case MKMapType.hybrid:
            self.map.mapType = MKMapType.standard
            break;
        case MKMapType.standard:
            self.map.mapType = MKMapType.hybrid
            break;
        default:
            break;
        }
        self.map.removeAnnotation(annotation)
        self.map.showsUserLocation = false
        //self.map.delegate = nil
        self.map.removeFromSuperview()
        self.map = nil
        
    }
    */
    // MARK: ++++++++++++++++++++ Customization funcs
    
    func sideMenus() {
        //if revealViewController() != nil {
        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        revealViewController().rearViewRevealWidth = Constants.leftTableWidth
        revealViewController().rightViewRevealWidth = Constants.rightTableWidth
        
        toolButton.target = revealViewController()
        toolButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
        
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        //}
    }
    
    func customizeNavBar() {
        // Icons color
        navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green:
            255/255, blue: 255/255, alpha: 1.0) //UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        // Background navBar color
        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green:
            152/255, blue: 227/255, alpha: 1.0) //UIColor(colorLiteralRed: 0/255, green: 152/255, blue: 227/255, alpha: 1)
        //
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.visibleViewController?.navigationItem.title = "Air-Part"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: .title2), NSAttributedStringKey.foregroundColor:UIColor.white ]
        
        // logo
        let image = UIImage(named: "testPNGAirPart+Logo2ph30")
        navigationController?.visibleViewController?.navigationItem.titleView = UIImageView(image: image)
    }
    
    //MARK: MAP locations IN GOOGLE MAP APP
    /*
    func openMapPlace() {
        let latitude: CLLocationDegrees = 37.2
        let longitude: CLLocationDegrees = 22.9
        
        let regionDistance: CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Place Name"
        mapItem.openInMaps(launchOptions: options)
        
    }
    */
    
    //MARK: MAP location in MAPVIEW
    
    func showShopLocation() {
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.001, 0.001)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(55.768744, 37.639295)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        map.setRegion(region, animated: true)
        
        //let annotation = MKPointAnnotation()
        
        annotation.coordinate = location
        annotation.title = "Air-Part"
        annotation.subtitle = "air-part.ru"
        map.addAnnotation(annotation)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    deinit {
        //print("Contacts deinit")
    }

}
