//
//  KCGNotesViewController.h
//  Everpobre
//
//  Created by Jorge Miguel Lucena Pino on 21/01/16.
//  Copyright © 2016 Jorge Miguel Lucena Pino. All rights reserved.
//

@import UIKit;
@import CoreData;

#import "AGTCoreDataTableViewController.h"
@class KCGNotebook;

@interface KCGNotesTableViewController : AGTCoreDataTableViewController

-(id) initWithFetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController style:(UITableViewStyle)aStyle notebook:(KCGNotebook *) notebook;

@end
