//
//  APIConnector.h
//  myTracker
//
//  Created by Andrea Herbas on 1/22/14.
//
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import <CoreData/CoreData.h>

@interface APIConnector : NSObject

@property (strong, nonatomic) RKManagedObjectStore *managedObjectStore;

+ (APIConnector*)sharedInstance;

- (void)setupConnector;
- (void)setupMapping;

- (void)loadProjects:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
             failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;

- (void)loadStoriesByProject:(NSInteger*) projectId
                     success:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                     failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;
@end
