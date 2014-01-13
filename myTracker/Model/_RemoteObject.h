// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RemoteObject.h instead.

#import <CoreData/CoreData.h>


extern const struct RemoteObjectAttributes {
	__unsafe_unretained NSString *createdAt;
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *updatedAt;
} RemoteObjectAttributes;

extern const struct RemoteObjectRelationships {
} RemoteObjectRelationships;

extern const struct RemoteObjectFetchedProperties {
} RemoteObjectFetchedProperties;






@interface RemoteObjectID : NSManagedObjectID {}
@end

@interface _RemoteObject : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RemoteObjectID*)objectID;





@property (nonatomic, strong) NSDate* createdAt;



//- (BOOL)validateCreatedAt:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* id;



@property int16_t idValue;
- (int16_t)idValue;
- (void)setIdValue:(int16_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* updatedAt;



//- (BOOL)validateUpdatedAt:(id*)value_ error:(NSError**)error_;






@end

@interface _RemoteObject (CoreDataGeneratedAccessors)

@end

@interface _RemoteObject (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveCreatedAt;
- (void)setPrimitiveCreatedAt:(NSDate*)value;




- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int16_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int16_t)value_;




- (NSDate*)primitiveUpdatedAt;
- (void)setPrimitiveUpdatedAt:(NSDate*)value;




@end
