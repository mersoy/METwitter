//
//  METwitterSession.h
//  METwitter
//
//  Created by Pembe Muge Ersoy on 22/06/2015.
//  Copyright (c) 2015 MugeErsoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MEDataBase;

/*Session object for Twitter*/
@interface METwitterSession : NSObject

/*Current users name*/
@property (nonatomic, copy) NSString *username;

/*Persistent storage database*/
@property (nonatomic, strong) MEDataBase *dataBase;

/*Creates shared instance*/
+ (instancetype)sharedInstance;

@end
