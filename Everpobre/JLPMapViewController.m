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

#pragma mark - Init

- (id)initWithFetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController{
    if (self = [super init]) {
        _fetchedResultsController = aFetchedResultsController;
    }
    return self;
}


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
    [self syncView];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Asig region and animate
    self.mapView.centerCoordinate = self.model.firstObject.coordinate;
    
}

- (void)syncView{
    [self.mapView removeAnnotations:self.model];
    NSError *error;
    [self.fetchedResultsController performFetch:&error];
    if (error) NSLog(@"[%@ %@] %@ (%@)", NSStringFromClass([self class]), NSStringFromSelector(_cmd), [error localizedDescription], [error localizedFailureReason]);

    self.model = self.fetchedResultsController.fetchedObjects;
    [self.mapView addAnnotations:self.model];
}


#pragma mark - Actions

- (IBAction)standardMap:(id)sender {
    self.mapView.mapType = MKMapTypeStandard;
}

- (IBAction)satelliteMap:(id)sender {
    self.mapView.mapType = MKMapTypeSatellite;
}

- (IBAction)hybridMap:(id)sender {
    self.mapView.mapType = MKMapTypeHybrid;
}


@end
