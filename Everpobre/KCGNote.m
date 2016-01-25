#import "KCGNote.h"
#import "KCGNotebook.h"
#import "KCGPhoto.h"
#import "KCGLocation.h"

@import CoreLocation;

@interface KCGNote () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation KCGNote
@synthesize locationManager=_locationManager;

- (BOOL)hasLocation{
    return (nil != self.location);
}

+ (NSArray *)observableKeys{
    return @[@"name", @"text", @"notebook", @"photo.imageData", @"location"];
}
+ (instancetype)noteWithName:(NSString*) name
                    notebook:(KCGNotebook *)notebook
                     context:(NSManagedObjectContext *)context{
    
    KCGNote *note = [self insertInManagedObjectContext:context];
    note.name = name;
    note.notebook = notebook;
    note.creationDate = [NSDate date];
    note.modificationDate = [NSDate date];
    note.photo = [KCGPhoto insertInManagedObjectContext:context];
    
    return note;
}

#pragma mark - Life cycle
- (void)awakeFromInsert{
    [super awakeFromInsert];
    // Se llama solo una vez
    
    //[self.locationManager requestWhenInUseAuthorization];
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if ((status == kCLAuthorizationStatusAuthorizedWhenInUse) || (status == kCLAuthorizationStatusNotDetermined)) {
        
        
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager startUpdatingLocation];
        
        // Time limit
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self zapLocationManager];
        });
    }
}

- (void)awakeFromFetch{
    [super awakeFromFetch];
    // Se llama un huevo de veces
    [self setupKVO];
}

- (void)willTurnIntoFault{
    [super willTurnIntoFault];
    [self tearDownKVO];
}

#pragma mark - KVO

- (void)setupKVO{
    // Alta notificaciones
    
    for (NSString *key in [self.class observableKeys]) {
        [self addObserver:self
               forKeyPath:key
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:NULL];
    }
    
    
}

- (void)tearDownKVO{
    // Baja notificaciones
    
    for (NSString *key in [self.class observableKeys]) {
        [self removeObserver:self
                  forKeyPath:key];
    }
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context{
    
    self.modificationDate = [NSDate date];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    // Stop (for battery life optimization)
    [self zapLocationManager];
    
    if (![self hasLocation]) {
        // Get the lastest location
        CLLocation *loc = [locations lastObject];
        
        // KCGLocation
        self.location = [KCGLocation locationWithCLLocation:loc
                                                    forNote:self];
    }
    
}

- (void)zapLocationManager{
    
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;
    self.locationManager = nil;
}

@end
