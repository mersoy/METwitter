//
//  METwitterDataProvider.h
//  METwitter
//
//  Created by Muge Ersoy on 18/06/2015.
//  Copyright (c) 2015 MugeErsoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MEWallEntery;


/* Completion block to return list of wall enteries */
typedef void(^METwitterCompletionBlock)(NSArray *list,NSError *error);

/* Completiong block to return success or failure */
typedef void(^MESuccessCompletionBlock)(BOOL success);

/*Twitter Asycn data provider class */
@interface METwitterDataProvider : NSObject


/*Data call method to provide list of wall enteries for the current user
 @param paramBlock will include list of wall enteries or error
 @return Void
 */
-(void)getMyWallEnteriesWithCompletionBlock:(METwitterCompletionBlock)paramBlock;

/*Data call method to provide list of wall enteries specific user
 @param paramBlock will include list of wall enteries or error
 @return Void
 */
-(void)getWallEnteriesForUser:(NSString*)paramUSer WithCompletionBlock:(METwitterCompletionBlock)paramBlock;

/*Data call method to send Message to current User's wall
 @param paramBlock will include success or failure
 @return Void
 */
-(void)sendMessage:(MEWallEntery*)paramEntery withCompletionBlock:(MESuccessCompletionBlock)paramBlock;

/*Data call method to follow specific user
 @param paramBlock will include success or failure
 @return Void
 */
-(void)followUser:(NSString*)paramName withCompletionBlock:(MESuccessCompletionBlock)paramBlock;

/*Data call method to get list of users
 @param paramBlock will include list of users or error
 @return Void
 */
-(void)getListOfUsersWithCompletionBlock:(METwitterCompletionBlock)paramBlock;

/*Data call method to get list of subscribed users
 @param paramBlock will include list of users or error
 @return Void
 */
-(void)getMyFriendsWithCompletionBlock:(METwitterCompletionBlock)paramBlock;

@end
