//
//  MEWallEntery.m
//  METwitter
//
//  Created by Muge Ersoy on 19/06/2015.
//  Copyright (c) 2015 MugeErsoy. All rights reserved.
//

#import "MEWallEntery.h"
#import "MEWallEntity.h"

@interface MEWallEntery()

@property (nonatomic, copy, readwrite) NSString *username;
@property (nonatomic, copy, readwrite) NSString *message;
@property (nonatomic, copy, readwrite) NSDate *date;

@end

@implementation MEWallEntery

/*
+ (instancetype)initWithMEWallEntity:(MEWallEntity*)paramEntity
{
    MEWallEntery *entery = [MEWallEntery new];
    entery.username = paramEntity.username;
    entery.message = paramEntity.message;
    return entery;
}
*/
+ (instancetype)initWithUsername:(NSString*)paramUserName
                         message:(NSString*)paramMessage
{
    MEWallEntery *entery = [MEWallEntery new];
    entery.username = [paramUserName copy];
    entery.message  = [paramMessage copy];
    entery.date     = [NSDate date];
    return entery;
}

@end
