// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to KCGLocation.h instead.

@import CoreData;

extern const struct KCGLocationAttributes {
	__unsafe_unretained NSString *address;
	__unsafe_unretained NSString *latitud;
	__unsafe_unretained NSString *longitud;
} KCGLocationAttributes;

extern const struct KCGLocationRelationships {
	__unsafe_unretained NSString *notes;
} KCGLocationRelationships;

@class KCGNote;

@interface KCGLocationID : NSManagedObjectID {}
@end

@interface _KCGLocation : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) KCGLocationID* objectID;

@property (nonatomic, strong) NSString* address;

//- (BOOL)validateAddress:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* latitud;

@property (atomic) double latitudValue;
- (double)latitudValue;
- (void)setLatitudValue:(double)value_;

//- (BOOL)validateLatitud:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* longitud;

@property (atomic) double longitudValue;
- (double)longitudValue;
- (void)setLongitudValue:(double)value_;

//- (BOOL)validateLongitud:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *notes;

- (NSMutableSet*)notesSet;

@end

@interface _KCGLocation (NotesCoreDataGeneratedAccessors)
- (void)addNotes:(NSSet*)value_;
- (void)removeNotes:(NSSet*)value_;
- (void)addNotesObject:(KCGNote*)value_;
- (void)removeNotesObject:(KCGNote*)value_;

@end

@interface _KCGLocation (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAddress;
- (void)setPrimitiveAddress:(NSString*)value;

- (NSNumber*)primitiveLatitud;
- (void)setPrimitiveLatitud:(NSNumber*)value;

- (double)primitiveLatitudValue;
- (void)setPrimitiveLatitudValue:(double)value_;

- (NSNumber*)primitiveLongitud;
- (void)setPrimitiveLongitud:(NSNumber*)value;

- (double)primitiveLongitudValue;
- (void)setPrimitiveLongitudValue:(double)value_;

- (NSMutableSet*)primitiveNotes;
- (void)setPrimitiveNotes:(NSMutableSet*)value;

@end
