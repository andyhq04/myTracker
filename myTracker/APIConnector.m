//
//  APIConnector.m
//  myTracker
//
//  Created by Andrea Herbas on 1/22/14.
//
//

#import "APIConnector.h"
#import "MappingProvider.h"

@implementation APIConnector

+ (APIConnector*)sharedInstance
{
    static APIConnector *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[APIConnector alloc] init];
        [_sharedInstance setupConnector];
        [_sharedInstance setupMapping];
    });
    return _sharedInstance;
}

- (void)setupConnector
{
   // RKObjectManager *manager = [RKObjectManager sharedManager];
    
    /*if (!manager) {
        manager = [RKObjectManager objectManagerWithBaseURL:[RKURL URLWithString:self.baseUrl]];
        manager.client.serviceUnavailableAlertEnabled = YES;
        manager.requestQueue.showsNetworkActivityIndicatorWhenBusy = YES;
    } else {
        manager.client.baseURL = [RKURL URLWithString:self.baseUrl];
    }*/
    
    NSError *error = nil;
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    
    // Initialize the Core Data stack
    [managedObjectStore createPersistentStoreCoordinator];
    
    NSPersistentStore __unused *persistentStore = [managedObjectStore addInMemoryPersistentStore:&error];
    NSAssert(persistentStore, @"Failed to add persistent store: %@", error);
    
    [managedObjectStore createManagedObjectContexts];
    
    // Set the default store shared instance
    [RKManagedObjectStore setDefaultStore:managedObjectStore];
    
    // Configure the object manager
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://localhost:3000/"]];
    [[objectManager HTTPClient] setDefaultHeader:@"X-Login-Token" value:@"WySKtLx96qr83Tog6"];
    [[objectManager HTTPClient] setDefaultHeader:@"X-User-Id" value:@"SGfE7i6DubfXJ7LBo"];
    
    objectManager.managedObjectStore = managedObjectStore;
    
    [RKObjectManager setSharedManager:objectManager];
    self.managedObjectStore = managedObjectStore;
}

- (void)setupMapping
{
    [MappingProvider sharedInstance].managedObjectStore = self.managedObjectStore;
    [[MappingProvider sharedInstance] setProjectMappings];
    [[MappingProvider sharedInstance] setStoryMappings];
}

- (void)loadProjects:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
             failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure
{
    [[RKObjectManager sharedManager].HTTPClient setDefaultHeader:@"Accept" value:RKMIMETypeJSON];
    [[RKObjectManager sharedManager].HTTPClient setDefaultHeader:@"Content-Type" value:RKMIMETypeJSON];
    [RKMIMETypeSerialization registerClass:[RKMIMETypeTextXML class] forMIMEType:@"text/html"];
    [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/json"];
    [[RKObjectManager sharedManager] setAcceptHeaderWithMIMEType:@"text/html"];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"api/projects" parameters:nil success:success failure:failure];
}

- (void)loadStoriesByProject:(NSInteger*) projectId
                     success:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                     failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure
{
    
    [[RKObjectManager sharedManager].HTTPClient setDefaultHeader:@"Accept" value:RKMIMETypeJSON];
    [[RKObjectManager sharedManager].HTTPClient setDefaultHeader:@"Content-Type" value:RKMIMETypeJSON];
    [RKMIMETypeSerialization registerClass:[RKMIMETypeTextXML class] forMIMEType:@"text/html"];
    [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/json"];
    [[RKObjectManager sharedManager] setAcceptHeaderWithMIMEType:@"text/html"];
    NSLog(@"%@", [RKMIMETypeSerialization registeredMIMETypes]);
    [[RKObjectManager sharedManager] getObjectsAtPath:@"api/projects/QB4wnfjxKbai7xjXY/stories" parameters:nil success:success failure:failure];

}

@end
