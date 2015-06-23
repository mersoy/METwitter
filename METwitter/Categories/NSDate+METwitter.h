//
//  NSDate+METwitter.h
//  METwitter
//
//  Created by Muge Ersoy on 19/06/2015.
//  Copyright (c) 2015 MugeErsoy. All rights reserved.
//

#import <Foundation/Foundation.h>

/* Category for NSDate */
@interface NSDate (METwitter)

/*Formatted version for METwitter
 e.g 1 second ago .. 4 minutes ago..
 */
- (NSString*)formatMETwitterDate;

@end
