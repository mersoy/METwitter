//
//  MEFriendShipEntity.h
//  METwitter
//
//  Created by Muge Ersoy on 19/06/2015.
//  Copyright (c) 2015 MugeErsoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/*FriendShipEntity as ManagedObject*/

@interface MEFriendShipEntity : NSManagedObject

/*User who is follower*/
@property (nonatomic, copy) NSString * follower;

/*User who is followed*/
@property (nonatomic, copy) NSString * followee;

@end
