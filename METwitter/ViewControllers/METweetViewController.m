//
//  METweetViewController.m
//  METwitter
//
//  Created by Muge Ersoy on 21/06/2015.
//  Copyright (c) 2015 MugeErsoy. All rights reserved.
//

#import "METweetViewController.h"
#import "MEConstants.h"
#import "MEWallEntery.h"
#import "METwitterSession.h"
#import "METwitterDataProvider.h"
#import "UIViewController+MessageHandler.h"

static NSInteger maxNumberOfCharacters = 140;

@interface METweetViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *tweet;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIButton *tweetButton;
@property (weak, nonatomic) IBOutlet UILabel *counter;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *activityView;

@end

@implementation METweetViewController

+ (instancetype)instance
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MEStoryBoardString bundle:nil];
    METweetViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:METweetViewControllerString];
    return viewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.username.text = [METwitterSession sharedInstance].username;
    self.counter.text = [NSString stringWithFormat:@"%ld",(long)maxNumberOfCharacters];
    self.tweet.delegate = self;
    self.tweetButton.enabled = NO;
    self.title = @"Tweet";
    self.activityView.hidden = YES;

}

- (IBAction)tweeted:(id)sender {
    
    MEWallEntery *entery = [MEWallEntery initWithUsername:self.username.text message:self.tweet.text];

    __weak typeof(self) weakSelf =  self;

    self.activityView.hidden = NO;
    [[METwitterDataProvider new] sendMessage:entery withCompletionBlock:^(BOOL success)
     {

            weakSelf.activityView.hidden = YES;
            if(!success)
            {
                [weakSelf showError];
            }else{
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            
            }
     }];
}

- (void)updateUI:(NSUInteger)paramCounter
{
    NSInteger numberOfRemainingCharacters = maxNumberOfCharacters - paramCounter;
    self.tweetButton.enabled = numberOfRemainingCharacters >= 0;
    self.counter.text = [NSString stringWithFormat:@"%ld",numberOfRemainingCharacters];
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    NSUInteger newLength = [textView.text length] + [text length] - range.length;
    [self updateUI:newLength];
    return YES;
}

@end
