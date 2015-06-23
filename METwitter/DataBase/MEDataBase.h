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

/*Fetching all my wall enteries
 @param paramBlock returns an array of enteries or error
 */
- (void)fetchWallEnteriesWithCompletionBlock:(MECompletionBlock)paramBlock;

/*Fetching all wall enteries for specific user
 @param paramUser  username
 @param paramBlock returns an array of enteries or error
 */
- (void)fetchWallEnteriesForUser:(NSString*)paramUser withCompletionBlock:(MECompletionBlock)paramBlock;

/*Fetching all wall enteries for specific user
 @param paramEntery  entery for the wall
 @param paramBlock returns success or failure
 */
- (void)sendMessage:(MEWallEntery*)paramEntery WithCompletionBlock:(MESuccessBlock)paramBlock;

/*Fetches all users which are twitted once
 @param paramBlock returns list of users
 */
- (void)getListOfUsersWithCompletionBlock:(MECompletionBlock)paramBlock;

/*Follow specific user
 @param paramUserName  user to be followed
 @param paramBlock returns success or failure
 */
- (void)followUser:(NSString*)paramUserName withCompletionBlock:(MESuccessBlock)paramBlock;

/*Gets list of subscribed users
 @param paramBlock returns list of users
 */
- (void)getMyFriendsWithCompletionBlock:(MECompletionBlock)paramBlock;
@end
