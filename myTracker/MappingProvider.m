//
//  MappingProvider.m
//  myTracker
//
//  Created by Andrea Herbas on 1/19/14.
//
//

#import "MappingProvider.h"

@implementation MappingProvider

+ (MappingProvider*)sharedInstance
{
    static MappingProvider *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[MappingProvider alloc] init];
    });
    return _sharedInstance;
}

- (id)initWithManagedObjectStore:(RKManagedObjectStore *) managedObjectStore
{
    self = [super init];
    if (self) {
        self.managedObjectStore = managedObjectStore;
    }
    
    return self;
}

- (void)setProjectMappings;
{
    RKEntityMapping *entityMapping = [RKEntityMapping mappingForEntityForName:@"Project" inManagedObjectStore:self.managedObjectStore];
    [entityMapping addAttributeMappingsFromDictionary:@{
     @"_id": @"id",
     @"name": @"name",
     @"description": @"desc",
     @"length": @"length",
     @"velocity": @"velocity",
     @"startAt": @"startAt",
     @"createdAt": @"createdAt",
     @"updatedAt": @"updatedAt"}];
    entityMapping.identificationAttributes = @[@"id"];
    
    RKResponseDescriptor *projectResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:entityMapping method:RKRequestMethodGET pathPattern:@"api/projects" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];

    [[RKObjectManager sharedManager] addResponseDescriptor:projectResponseDescriptor];
}

- (void)setStoryMappings;
{
    RKEntityMapping *entityMapping = [RKEntityMapping mappingForEntityForName:@"Story" inManagedObjectStore:self.managedObjectStore];
    [entityMapping addAttributeMappingsFromDictionary:@{
     @"_id": @"id",
     @"title": @"title",
     @"description": @"desc",
     @"type": @"type",
     @"status": @"status",
     @"points": @"points",
     @"project_id": @"project_id",
     @"createdAt": @"createdAt",
     @"updatedAt": @"updatedAt"}];
    entityMapping.identificationAttributes = @[@"id"];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:entityMapping method:RKRequestMethodGET pathPattern:@"api/projects/QB4wnfjxKbai7xjXY/stories" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
}

@end
