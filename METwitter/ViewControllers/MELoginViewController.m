//
//  MELoginViewController.m
//  METwitter
//
//  Created by Muge Ersoy on 18/06/2015.
//  Copyright (c) 2015 MugeErsoy. All rights reserved.
//

#import "MELoginViewController.h"
#import "MEWallViewController.h"
#import "AppDelegate.h"
#import "MEConstants.h"
#import "METwitterSession.h"


@interface MELoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UIButton *login;

@end

@implementation MELoginViewController

+ (instancetype)instance
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MEStoryBoardString bundle:nil];
    MELoginViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:MELoginViewControllerString];
    return viewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.login.enabled = NO;
}

- (IBAction)login:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MEStoryBoardString bundle:nil];
    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:MEWallNavControllerString];
    [[METwitterSession sharedInstance] setUsername:self.username.text];
    [[AppDelegate sharedAppDelegate] setRootViewController:navigationController animated:YES];
}

#pragma mark - UITextViewDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    self.login.enabled = newLength > 0;
    return YES;
}


@end
