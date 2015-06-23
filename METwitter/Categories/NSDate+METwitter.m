//
//  NSDate+METwitter.m
//  METwitter
//
//  Created by Muge Ersoy on 19/06/2015.
//  Copyright (c) 2015 MugeErsoy. All rights reserved.
//

#import "NSDate+METwitter.h"

static NSInteger MENumberOfSecondsInMinute = 60;
static NSInteger MENumberOfSecondsInAhour = 3600;
static NSInteger MENumberOfSecondsInADay = 86400;

@implementation NSDate (METwitter)

- (NSString*)formatMETwitterDate{
    NSString *result;
    
    NSTimeInterval numberOfSeconds = [[NSDate date] timeIntervalSinceDate:self];
    if(numberOfSeconds <= 1 )
    {
        result = @"1 second ago";
    }else if(numberOfSeconds < MENumberOfSecondsInMinute){
        
        result = [NSString stringWithFormat:@"%0.f seconds ago",numberOfSeconds];
    
    }else if(numberOfSeconds == MENumberOfSecondsInMinute || floor(numberOfSeconds/MENumberOfSecondsInMinute) < 2){
    
        result = @"1 minute ago";
    
    }else if(numberOfSeconds < MENumberOfSecondsInAhour)
    {
        result = [NSString stringWithFormat:@"%0.f minutes ago", floor(numberOfSeconds/MENumberOfSecondsInMinute)];
        
    }else if( numberOfSeconds == MENumberOfSecondsInAhour || floor(numberOfSeconds/MENumberOfSecondsInAhour) < 2)
    {
        result = @"1 hour ago";
        
    }else if(numberOfSeconds < MENumberOfSecondsInADay)
    {
        result = [NSString stringWithFormat:@"%0.f hours ago", floor(numberOfSeconds/MENumberOfSecondsInAhour)];
    }
    else if(numberOfSeconds == MENumberOfSecondsInADay || floor(numberOfSeconds/MENumberOfSecondsInADay) < 2)
    {
        result = @"1 day ago";
        
    }else if(numberOfSeconds > MENumberOfSecondsInADay)
    {
        result = [NSString stringWithFormat:@"%0.f days ago", floor(numberOfSeconds/MENumberOfSecondsInADay)];
    }

    return result;


}

@end
