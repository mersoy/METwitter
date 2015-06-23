//
//  MEWallEntity.h
//  METwitter
//
//  Created by Muge Ersoy on 19/06/2015.
//  Copyright (c) 2015 MugeErsoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/*WallEntity as ManagedObject*/
@interface MEWallEntity : NSManagedObject

/*User name*/
@property (nonatomic, copy) NSString * username;

/*Message*/
@property (nonatomic, copy) NSString * message;

/*Timestamp of the tweet*/
@property (nonatomic, copy) NSDate * date;

@end
