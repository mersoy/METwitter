//
//  MEDataBase.m
//  METwitter
//
//  Created by Muge Ersoy on 18/06/2015.
//  Copyright (c) 2015 MugeErsoy. All rights reserved.
//

#import "MEDataBase.h"
#import <CoreData/CoreData.h>
#import "MEConstants.h"
#import "MEWallEntity.h"
#import "MEWallEntery.h"
#import "METwitterSession.h"
#import "MEFriendShipEntity.h"

static NSString* MEWallEntityName = @"MEWallEntity";
static NSString* MEFriendShipEntityName = @"MEFriendShipEntity";
static NSString* MEUserName = @"username";
static NSString* MEDate = @"date";

@interface MEDataBase ()


@property (readwrite, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readwrite, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readwrite, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (readwrite, copy, nonatomic) NSString *databaseName;
@property (readwrite, copy, nonatomic) NSString *dataModelname;

@end
@implementation MEDataBase

+ (instancetype)initWithDBName:(NSString*)paramDBName error:(NSError**)paramError
{
    MEDataBase *database = [MEDataBase new];
    database.databaseName = [paramDBName copy];
    database.dataModelname = [database.databaseName stringByAppendingString:@".sqlite"];
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:database.databaseName withExtension:@"momd"];
    database.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    database.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:database.managedObjectModel];
    NSURL *storeURL = [database.applicationDocumentsDirectory URLByAppendingPathComponent:database.dataModelname];
    if (![database.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:paramError]) {
    }
    database.managedObjectContext = [[NSManagedObjectContext alloc] init];
    [database.managedObjectContext setPersistentStoreCoordinator:database.persistentStoreCoordinator];
    return database;
}

- (void)fetchWallEnteriesWithCompletionBlock:(MECompletionBlock)paramBlock
{
    [self getMyFriendsWithCompletionBlock:^(NSArray *list,NSError *error)
     {
         NSEntityDescription *entity = [NSEntityDescription entityForName:MEWallEntityName inManagedObjectContext:self.managedObjectContext];
         NSFetchRequest *request = [[NSFetchRequest alloc] init];
         [request setEntity:entity];
     
         NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:MEDate ascending:NO];
         NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
         [request setSortDescriptors:sortDescriptors];
         NSError *errorContext;
         NSArray *entities = [[self.managedObjectContext executeFetchRequest:request error:&errorContext] mutableCopy];
         NSMutableArray *trimmedEntities = [NSMutableArray array];
         for(MEWallEntity *entity in entities)
         {
             if( ([list containsObject:entity.username] || [entity.username isEqualToString:[METwitterSession sharedInstance].username]))
             {
                 [trimmedEntities addObject:entity];
             }
         }
         if(paramBlock)
         {
             paramBlock([trimmedEntities copy],error);
         }
     }];
}

-(void)fetchWallEnteriesForUser:(NSString*)paramUser withCompletionBlock:(MECompletionBlock)paramBlock
{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:MEWallEntityName inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    request.predicate = [NSPredicate predicateWithFormat:@"self.username == %@", paramUser];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:MEDate ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [request setSortDescriptors:sortDescriptors];
    NSError *error;
    NSArray *entities = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if(paramBlock)
    {
        paramBlock(entities,error);
    }

}

-(void)getMyFriendsWithCompletionBlock:(MECompletionBlock)paramBlock
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:MEFriendShipEntityName inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    request.predicate = [NSPredicate predicateWithFormat:@"self.follower == %@", [METwitterSession sharedInstance].username];
    NSError *error;
    NSArray *friends = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    NSMutableSet *usernameSet = [NSMutableSet set];
    for(MEFriendShipEntity *entity in friends)
    {
        [usernameSet addObject:entity.followee];
    }
    if(paramBlock)
    {
        paramBlock([usernameSet allObjects],error);
    }
}


-(void)sendMessage:(MEWallEntery*)paramEntery WithCompletionBlock:(MESuccessBlock)paramBlock
{
    MEWallEntity *entery = (MEWallEntity *)[NSEntityDescription insertNewObjectForEntityForName:MEWallEntityName inManagedObjectContext:self.managedObjectContext];
    entery.username = [paramEntery.username copy];
    entery.message = [paramEntery.message copy];
    entery.date = [NSDate date];
    NSError *error;
    [self.managedObjectContext  save:&error];
    
    if(paramBlock)
    {
        paramBlock(error);
    }
}

-(void)getListOfUsersWithCompletionBlock:(MECompletionBlock)paramBlock{

    NSEntityDescription *entity = [NSEntityDescription entityForName:MEWallEntityName inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSError *error;
    NSArray *entities = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    NSMutableSet *usernameSet = [NSMutableSet set];
    for(MEWallEntity *entity in entities)
    {
        if(![entity.username isEqualToString:[METwitterSession sharedInstance].username])
        {
            [usernameSet addObject:entity.username];
        }
    }
    if(paramBlock)
    {
        paramBlock([usernameSet allObjects],error);
    }
    
}

- (void)followUser:(NSString*)paramName withCompletionBlock:(MESuccessBlock)paramBlock
{
    MEFriendShipEntity *friendship = (MEFriendShipEntity *)[NSEntityDescription insertNewObjectForEntityForName:MEFriendShipEntityName inManagedObjectContext:self.managedObjectContext];
    
    friendship.follower = [[METwitterSession sharedInstance].username copy];
    friendship.followee = [paramName copy];
    NSError *error;
    [self.managedObjectContext  save:&error];
    
    if(paramBlock)
    {
        paramBlock(error);
    }
}


#pragma mark - Core Data stack


@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    if (!_managedObjectModel) {

        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:self.databaseName withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (!_persistentStoreCoordinator) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:self.dataModelname];
        NSError *error = nil;
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        }
        });
    }
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
        if (!coordinator) {
            return nil;
        }
        static dispatch_once_t onceToken;

        dispatch_once(&onceToken, ^{

        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
        });
    }
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support
- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            abort();
        }
    }
}

@end
