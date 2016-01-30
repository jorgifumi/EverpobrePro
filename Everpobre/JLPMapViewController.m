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
        self.fetchedResultsController = aFetchedResultsController;
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
    for (KCGLocation *location in self.model) {
        [self.mapView addAnnotation:location];

    }

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Asig region and animate
}

#pragma mark - Fetching

- (void)performFetch
{
    if (self.fetchedResultsController) {
        NSError *error;
        [self.fetchedResultsController performFetch:&error];
        if (error) NSLog(@"[%@ %@] %@ (%@)", NSStringFromClass([self class]), NSStringFromSelector(_cmd), [error localizedDescription], [error localizedFailureReason]);
    }
    
}

- (void)setFetchedResultsController:(NSFetchedResultsController *)newfrc
{
    NSFetchedResultsController *oldfrc = _fetchedResultsController;
    if (newfrc != oldfrc) {
        _fetchedResultsController = newfrc;
        //newfrc.delegate = self;
        if ((!self.title || [self.title isEqualToString:oldfrc.fetchRequest.entity.name]) && (!self.navigationController || !self.navigationItem.title)) {
            self.title = newfrc.fetchRequest.entity.name;
        }
        if (newfrc) {
            [self performFetch];
        } else {
            //[self.tableView reloadData];
        }
    }
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

#pragma mark - MKMapDelegate



#pragma mark - NSFetchedResultsControllerDelegate

@end
