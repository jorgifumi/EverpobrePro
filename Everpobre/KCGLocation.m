#import "KCGLocation.h"
#import "KCGNote.h"

@import AddressBookUI;

@interface KCGLocation ()

// Private interface goes here.

@end

@implementation KCGLocation

+ (instancetype)locationWithCLLocation:(CLLocation *)location
                       forNote:(KCGNote *)note{
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[KCGLocation entityName]];
    NSPredicate *latitude = [NSPredicate predicateWithFormat:@"abs(latitude) - abs(%lf) < 0.001", location.coordinate.latitude];
    NSPredicate *longitude = [NSPredicate predicateWithFormat:@"abs(longitude) - abs(%lf) < 0.001", location.coordinate.longitude];
    req.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[latitude, longitude]];
    
    NSError *error = nil;
    NSArray *results = [note.managedObjectContext executeFetchRequest:req
                                                                error:&error];
    
    NSAssert(results, @"Error al buscar!");
    
    if ([results count]) {
        
        KCGLocation *found = [results lastObject];
        [found addNotesObject:note];
        
        return found;
    }else{
        KCGLocation *loc = [self insertInManagedObjectContext:note.managedObjectContext];
        
        loc.latitudeValue = location.coordinate.latitude;
        loc.longitudeValue = location.coordinate.longitude;
        
        [loc addNotesObject:note];
        
        // Address
        CLGeocoder *coder = [CLGeocoder new];
        [coder reverseGeocodeLocation:location
                    completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                        
                        if (error) {
                            NSLog(@"Error while obtaining address \n%@", error);
                            
                        }else{
                            loc.address = ABCreateStringWithAddressDictionary([[placemarks lastObject] addressDictionary], YES);
                        }
                    }];
        return loc;

    }
    
}
@end
