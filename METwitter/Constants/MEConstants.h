//
//  MEConstants.h
//  METwitter
//
//  Created by Muge Ersoy on 19/06/2015.
//  Copyright (c) 2015 MugeErsoy. All rights reserved.
//

extern NSString *MEErrorDomain;


#pragma mark UIViewControllers

extern NSString *MEStoryBoardString;
extern NSString *MEWallNavControllerString;
extern NSString *MEWallViewControllerString;
extern NSString *MELoginViewControllerString;
extern NSString *METweetViewControllerString;
extern NSString *MEUsersViewControllerString;

#pragma mark Error Codes

typedef NS_ENUM(NSInteger, MEClientErrorCode) {
    MEClientErrorCodeUnknown,
    MEClientErrorCodeSaveError           = 2001
  };
