//
//  MEWallEntery.h
//  METwitter
//
//  Created by Muge Ersoy on 19/06/2015.
//  Copyright (c) 2015 MugeErsoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MEWallEntity;

/*Wall Entery object for tweet*/
@interface MEWallEntery : NSObject

/*User name of the twitter*/

@property (nonatomic, copy, readonly) NSString *username;

/*The tweet*/
@property (nonatomic, copy, readonly) NSString *message;

/*Instance method of the class
 @param paramUserName  twitter's username
 @param paramMessage The Tweet
 @return  instance
 */
+ (instancetype)initWithUsername:(NSString*)paramUserName
                         message:(NSString*)paramMessage;
@end
