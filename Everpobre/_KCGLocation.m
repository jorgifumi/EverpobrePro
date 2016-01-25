// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to KCGLocation.m instead.

#import "_KCGLocation.h"

const struct KCGLocationAttributes KCGLocationAttributes = {
	.address = @"address",
	.latitud = @"latitud",
	.longitud = @"longitud",
};

const struct KCGLocationRelationships KCGLocationRelationships = {
	.notes = @"notes",
};

@implementation KCGLocationID
@end

@implementation _KCGLocation

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Location";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Location" inManagedObjectContext:moc_];
}

- (KCGLocationID*)objectID {
	return (KCGLocationID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"latitudValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"latitud"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"longitudValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"longitud"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic address;

@dynamic latitud;

- (double)latitudValue {
	NSNumber *result = [self latitud];
	return [result doubleValue];
}

- (void)setLatitudValue:(double)value_ {
	[self setLatitud:@(value_)];
}

- (double)primitiveLatitudValue {
	NSNumber *result = [self primitiveLatitud];
	return [result doubleValue];
}

- (void)setPrimitiveLatitudValue:(double)value_ {
	[self setPrimitiveLatitud:@(value_)];
}

@dynamic longitud;

- (double)longitudValue {
	NSNumber *result = [self longitud];
	return [result doubleValue];
}

- (void)setLongitudValue:(double)value_ {
	[self setLongitud:@(value_)];
}

- (double)primitiveLongitudValue {
	NSNumber *result = [self primitiveLongitud];
	return [result doubleValue];
}

- (void)setPrimitiveLongitudValue:(double)value_ {
	[self setPrimitiveLongitud:@(value_)];
}

@dynamic notes;

- (NSMutableSet*)notesSet {
	[self willAccessValueForKey:@"notes"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"notes"];

	[self didAccessValueForKey:@"notes"];
	return result;
}

@end

