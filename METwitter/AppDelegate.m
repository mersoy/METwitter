//
//  AppDelegate.m
//  METwitter
//
//  Created by Muge Ersoy on 18/06/2015.
//  Copyright (c) 2015 MugeErsoy. All rights reserved.
//

#import "AppDelegate.h"
#import "METwitterDataProvider.h"

@implementation AppDelegate

+ (AppDelegate *)sharedAppDelegate
{
    return [UIApplication sharedApplication].delegate;
}

- (void)setRootViewController:(UIViewController *)paramViewController animated:(BOOL)paramAnimated
{
    if (self.window.rootViewController == paramViewController) {
        return;
    }
    if (paramAnimated) {
        UIViewController *oldViewController = self.window.rootViewController;
        self.window.rootViewController = paramViewController;
        [self.window addSubview:oldViewController.view];
        
        [UIView transitionWithView:self.window
                          duration:0.35
                           options:UIViewAnimationOptionCurveLinear
                        animations:^{
                            oldViewController.view.alpha = 0.0f;
                        } completion:^(BOOL finished) {
                            [oldViewController.view removeFromSuperview];
                        }];
    }
    else {
        self.window.rootViewController = paramViewController;
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

@end
