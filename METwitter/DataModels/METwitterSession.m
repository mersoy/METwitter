//
//  METwitterSession.m
//  METwitter
//
//  Created by Pembe Muge Ersoy on 22/06/2015.
//  Copyright (c) 2015 MugeErsoy. All rights reserved.
//

#import "METwitterSession.h"
#import "MEDataBase.h"

#if defined TEST
static NSString* MEDatabaseName = @"METest";
#else
static NSString* MEDatabaseName = @"METwitter";
#endif

@implementation METwitterSession


+ (instancetype)sharedInstance
{
    static METwitterSession *staticSharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticSharedInstance = [[METwitterSession alloc] init];
        NSError *error;
        staticSharedInstance.dataBase  = [MEDataBase initWithDBName:MEDatabaseName error:&error];

    });
    return staticSharedInstance;
}


@end
