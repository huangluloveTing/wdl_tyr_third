//
//  WDLMapView.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/18.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class WDLMapView: UIView  {
    
    private var locations:[CLLocationCoordinate2D]?
    private var polyLines:MAPolyline?
    
    private lazy var mapView:MAMapView = {
       let mapView = MAMapView(frame: self.bounds)
        mapView.delegate = self
        return mapView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(self.mapView)
        self.mapView.frame = self.bounds
        self.showMapViewArea()
        self.addPolylines()
    }
}

extension WDLMapView : MAMapViewDelegate {
    
    func addLineCoordinates(coordinates:[CLLocationCoordinate2D]?) -> Void {
        self.locations = coordinates
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    func addPolylines() {
        self.mapView.remove(self.polyLines)
        if let coordinates = self.locations {
            if coordinates.count == 0 {return}
            var locations = coordinates
            let lines : MAPolyline = MAPolyline(coordinates: &locations, count: UInt(coordinates.count))
            self.polyLines = lines
            self.mapView.add(self.polyLines)
        }
    }
    func showMapViewArea() -> Void {
        if let locations = self.locations {
            
            let annotations = locations.map({ (location) -> MAPointAnnotation in
                let point = MAPointAnnotation()
                point.coordinate = location
                return point
            })
            self.mapView.showAnnotations(annotations, edgePadding: UIEdgeInsetsMake(10, 10, 10, 10), animated: true)
        }
    }
    
    func mapView(_ mapView: MAMapView!, rendererFor overlay: MAOverlay!) -> MAOverlayRenderer! {
        if overlay.isKind(of: MAPolyline.self) {
            let renderer: MAPolylineRenderer = MAPolylineRenderer(overlay: overlay)
            renderer.lineWidth = 10.0
            renderer.lineCap = .round
            renderer.lineJoin = .round
            renderer.strokeColor = UIColor(hex: "7876CF")
            
            return renderer
        }
        return nil
    }
}
