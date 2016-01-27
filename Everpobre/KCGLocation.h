#import "_KCGLocation.h"

@import CoreLocation;
#import <MapKit/MapKit.h>

@interface KCGLocation : _KCGLocation <MKAnnotation> {}

+ (instancetype)locationWithCLLocation:(CLLocation *)location
                       forNote:(KCGNote *)note;

@end
