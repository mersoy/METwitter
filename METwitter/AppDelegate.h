//
//  AppDelegate.h
//  METwitter
//
//  Created by Muge Ersoy on 18/06/2015.
//  Copyright (c) 2015 MugeErsoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

/*Main Windows*/
@property (strong, nonatomic) UIWindow *window;

/*Shared Instance for AppDelegate*/
+ (AppDelegate *)sharedAppDelegate;

/*Sets given viewcontroller as root controller
 @param paramViewController to be root view controller
 @param paramAnimated  Will display root with or w/o animation
 */
- (void)setRootViewController:(UIViewController *)paramViewController animated:(BOOL)paramAnimated;


@end