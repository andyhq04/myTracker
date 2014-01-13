// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RemoteObject.m instead.

#import "_RemoteObject.h"

const struct RemoteObjectAttributes RemoteObjectAttributes = {
	.createdAt = @"createdAt",
	.id = @"id",
	.updatedAt = @"updatedAt",
};

const struct RemoteObjectRelationships RemoteObjectRelationships = {
};

const struct RemoteObjectFetchedProperties RemoteObjectFetchedProperties = {
};

@implementation RemoteObjectID
@end

@implementation _RemoteObject

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"RemoteObject" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"RemoteObject";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"RemoteObject" inManagedObjectContext:moc_];
}

- (RemoteObjectID*)objectID {
	return (RemoteObjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic createdAt;






@dynamic id;



- (int16_t)idValue {
	NSNumber *result = [self id];
	return [result shortValue];
}

- (void)setIdValue:(int16_t)value_ {
	[self setId:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveIdValue {
	NSNumber *result = [self primitiveId];
	return [result shortValue];
}

- (void)setPrimitiveIdValue:(int16_t)value_ {
	[self setPrimitiveId:[NSNumber numberWithShort:value_]];
}





@dynamic updatedAt;











@end
