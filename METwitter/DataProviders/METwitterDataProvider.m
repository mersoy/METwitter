//
//  METwitterDataProvider.m
//  METwitter
//
//  Created by Muge Ersoy on 18/06/2015.
//  Copyright (c) 2015 MugeErsoy. All rights reserved.
//

#import "METwitterDataProvider.h"
#import "MEWallEntity.h"
#import "MEDataBase.h"
#import "METwitterSession.h"

#if defined TEST
static NSString* MEDatabaseName = @"METest";
#else
static NSString* MEDatabaseName = @"METwitter";
#endif

@interface METwitterDataProvider()

@property (nonatomic, copy) NSString *currentUser;

@end

@implementation METwitterDataProvider

-(void)getMyWallEnteriesWithCompletionBlock:(METwitterCompletionBlock)paramBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [[METwitterSession sharedInstance].dataBase fetchWallEnteriesWithCompletionBlock:^(NSArray *entities,NSError *error){
            if(paramBlock)
            {
                dispatch_async(dispatch_get_main_queue(),^{
                    paramBlock(entities,error);
                });
            }
        }];
    });
    
}


-(void)getWallEnteriesForUser:(NSString*)paramUser WithCompletionBlock:(METwitterCompletionBlock)paramBlock
{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [[METwitterSession sharedInstance].dataBase  fetchWallEnteriesForUser:paramUser withCompletionBlock:^(NSArray *entities,NSError *error){
            if(paramBlock)
            {
                dispatch_sync(dispatch_get_main_queue(),^{
                    paramBlock(entities,error);
                });
            }
        }];
     });
}

-(void)sendMessage:(MEWallEntery*)paramEntery withCompletionBlock:(MESuccessCompletionBlock)paramBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
       [[METwitterSession sharedInstance].dataBase  sendMessage:paramEntery WithCompletionBlock:^(NSError *error){
            dispatch_sync(dispatch_get_main_queue(),^{

                if(paramBlock)
                {
                    paramBlock(YES);
                }
           });
       }];
    });
    
}

-(void)getMyFriendsWithCompletionBlock:(METwitterCompletionBlock)paramBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{

        [[METwitterSession sharedInstance].dataBase  getMyFriendsWithCompletionBlock:^(NSArray *friends,NSError *error){
    
            if(paramBlock)
            {
                dispatch_sync(dispatch_get_main_queue(),^{
                    paramBlock(friends,error);
                });
            }
    
        }];
    });
    
}

-(void)followUser:(NSString*)paramName withCompletionBlock:(MESuccessCompletionBlock)paramBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [[METwitterSession sharedInstance].dataBase followUser:paramName withCompletionBlock:^(NSError *error){
        dispatch_sync(dispatch_get_main_queue(),^{

            if(paramBlock)
            {
                paramBlock(YES);
            }
            });
        }];
    });

}


-(void)getListOfUsersWithCompletionBlock:(METwitterCompletionBlock)paramBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [[METwitterSession sharedInstance].dataBase getListOfUsersWithCompletionBlock:^(NSArray *users,NSError *error){
            if(paramBlock)
            {
                dispatch_sync(dispatch_get_main_queue(),^{
                    
                    paramBlock(users,error);
                });
            }
        }];
    });

}



@end
