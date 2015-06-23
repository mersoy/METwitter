//
//  UIViewController+MessageHandler.h
//  METwitter
//
//  Created by Pembe Muge Ersoy on 22/06/2015.
//  Copyright (c) 2015 MugeErsoy. All rights reserved.
//

#import <UIKit/UIKit.h>

/* Category for messages*/
@interface UIViewController (MessageHandler)

/*Shows error*/
- (void)showError;

/*Shows message to user
 @param paramMessage Message for user
 */
- (void)showMessage:(NSString*)paramMessage;

@end
