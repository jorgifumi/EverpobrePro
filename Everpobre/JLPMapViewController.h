//
//  JLPMapViewController.h
//  EverpobrePro
//
//  Created by Jorge Miguel Lucena Pino on 27/01/16.
//  Copyright © 2016 Jorge Miguel Lucena Pino. All rights reserved.
//

@import UIKit;
@import MapKit;

@class KCGLocation;

@interface JLPMapViewController : UIViewController
- (IBAction)standardMap:(id)sender;
- (IBAction)satelliteMap:(id)sender;
- (IBAction)hybridMap:(id)sender;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;


- (id)initWithLocation:(KCGLocation *)location;

@end
