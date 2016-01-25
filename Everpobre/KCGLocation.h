#import "_KCGLocation.h"

@import CoreLocation;

@interface KCGLocation : _KCGLocation {}

+ (instancetype)locationWithCLLocation:(CLLocation *)location
                       forNote:(KCGNote *)note;

@end
