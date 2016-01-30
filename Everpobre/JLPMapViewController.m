//
//  JLPMapViewController.m
//  EverpobrePro
//
//  Created by Jorge Miguel Lucena Pino on 27/01/16.
//  Copyright © 2016 Jorge Miguel Lucena Pino. All rights reserved.
//

#import "JLPMapViewController.h"
#import "KCGLocation.h"


@interface JLPMapViewController ()
@property (nonatomic, strong) NSArray<KCGLocation *>*model;
@end

@implementation JLPMapViewController

//- (id)initWithLocation:(KCGLocation *)location{
//    if (self = [super initWithNibName:nil
//                               bundle:nil]) {
//        _model = location;
//    }
//    return self;
//}

- (id)initWithLocations:(NSArray<KCGLocation *>*)locations{
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        _model = locations;
    }
    return self;
    }

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Pass to mapView
    for (KCGLocation *location in self.model) {
        [self.mapView addAnnotation:location];

    }

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Asig region and animate
}

#pragma mark - Actions

- (IBAction)standardMap:(id)sender {
}

- (IBAction)satelliteMap:(id)sender {
}

- (IBAction)hybridMap:(id)sender {
}

#pragma mark - MKMapDelegate

@end
