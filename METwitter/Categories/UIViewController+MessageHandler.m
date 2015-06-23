//
//  UIViewController+MessageHandler.m
//  METwitter
//
//  Created by Pembe Muge Ersoy on 22/06/2015.
//  Copyright (c) 2015 MugeErsoy. All rights reserved.
//

#import "UIViewController+MessageHandler.h"

@implementation UIViewController (ErrorHandler)

- (void)handleError
{
    UIAlertView *deleteCardAlertView = [[UIAlertView alloc] initWithTitle:@"Opps!"
                                                                  message:@"Something went wrong.Please try again!"
                                                                 delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles:nil];
    
    [deleteCardAlertView show];
}

- (void)showMessage:(NSString*)paramMessage
{
    UIAlertView *deleteCardAlertView = [[UIAlertView alloc] initWithTitle:@"Twitter"
                                                                  message:paramMessage
                                                                 delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles:nil];
    
    [deleteCardAlertView show];
}
@end
