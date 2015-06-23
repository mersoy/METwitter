//
//  MEDataBase.h
//  METwitter
//
//  Created by Muge Ersoy on 18/06/2015.
//  Copyright (c) 2015 MugeErsoy. All rights reserved.
//

@class NSManagedObjectContext;
@class MEWallEntery;

#import <Foundation/Foundation.h>

/* Completion block to return list of wall enteries */
typedef void(^MECompletionBlock)(NSArray *list,NSError *error);

/* Completion block to return list of wall enteries */
typedef void(^MESuccessBlock)(NSError *error);


/* Class for DataBase management*/
@interface MEDataBase : NSObject

/*instance of MEDataBase Class 
 @param Database name
 */
+ (instancetype)initWithDBName:(NSString*)paramDBName error:(NSError**)error;

- (void)fetchWallEnteriesWithCompletionBlock:(MECompletionBlock)paramBlock;

- (void)fetchWallEnteriesForUser:(NSString*)paramUser withCompletionBlock:(MECompletionBlock)paramBlock;

- (void)sendMessage:(MEWallEntery*)paramEntery WithCompletionBlock:(MESuccessBlock)paramBlock;

- (void)getListOfUsersWithCompletionBlock:(MECompletionBlock)paramBlock;

- (void)followUser:(NSString*)paramName withCompletionBlock:(MESuccessBlock)paramBlock;

- (void)getMyFriendsWithCompletionBlock:(MECompletionBlock)paramBlock;
@end
