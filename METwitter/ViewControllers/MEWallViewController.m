//
//  MasterViewController.m
//  METwitter
//
//  Created by Muge Ersoy on 18/06/2015.
//  Copyright (c) 2015 MugeErsoy. All rights reserved.
//

#import "MEWallViewController.h"
#import "METwitterDataProvider.h"
#import "MEWallEntity.h"
#import "NSDate+METwitter.h"
#import "MELoginViewController.h"
#import "AppDelegate.h"
#import "METweetViewController.h"
#import "METwitterSession.h"
#import "UIViewController+MessageHandler.h"
#import "MEUsersViewController.h"

@interface MEWallViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *activityView;
@property (weak, nonatomic) IBOutlet UILabel *info;

@property (copy, nonatomic) NSArray *friends;
@property (copy, nonatomic) NSArray *dataSource;

@end

@implementation MEWallViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    __weak typeof(self) weakSelf =  self;

    [self getMyFriends:^(BOOL success)
     {
         if([weakSelf.userName length] > 0)
         {
             [weakSelf customizeViewForSpecificUser];
             [weakSelf getWallEnteriesForSpecificUser];
         }else{
             [weakSelf customizeViewForCurrentUser];
             [weakSelf getWallEnteriesForCurrentUser];
         }
     }];
}

- (void)getMyFriends:(MESuccessCompletionBlock)paramBlock
{
    __weak typeof(self) weakSelf =  self;
    [[METwitterDataProvider new] getMyFriendsWithCompletionBlock:^(NSArray *friends,NSError *error){
        if(!error)
        {
            weakSelf.friends = [friends copy];
            if(paramBlock)
            {
                paramBlock(YES);
            }
        }else{
            
            [weakSelf showError];
        }
    }];
}

- (void)getWallEnteriesForSpecificUser
{
    [self activityOverlay:YES];
    __weak typeof(self) weakSelf =  self;
    [[METwitterDataProvider new] getWallEnteriesForUser:self.userName WithCompletionBlock:^(NSArray *enteries,NSError *error){
        [weakSelf activityOverlay:NO];
        if(!error)
        {
            weakSelf.dataSource = [enteries copy];
            [weakSelf.tableView reloadData];
        }else{
            
            [weakSelf showError];
        }
    }];
}

- (void)getWallEnteriesForCurrentUser
{
    [self activityOverlay:YES];

    __weak typeof(self) weakSelf =  self;
    [[METwitterDataProvider new] getMyWallEnteriesWithCompletionBlock:^(NSArray *enteries,NSError *error){
        [self activityOverlay:NO];
        if(!error)
        {
            weakSelf.dataSource = [enteries copy];
            [weakSelf.tableView reloadData];
        }else{
            [weakSelf showError];
        }
    }];
}

- (void)customizeViewForSpecificUser
{
    UIBarButtonItem *subscribe = [[UIBarButtonItem alloc] initWithTitle:@"Subscribe" style:UIBarButtonItemStylePlain target:self action:@selector(subscribe:)];
    self.navigationItem.rightBarButtonItem = subscribe;
    subscribe.enabled = ![self.friends containsObject:self.userName];
}


- (void)customizeViewForCurrentUser
{
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logout:)];
    self.navigationItem.leftBarButtonItem = logoutButton;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addUsers:)];
    UIBarButtonItem *tweetButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(tweet:)];
    self.navigationItem.rightBarButtonItems = @[tweetButton,addButton];
}

#pragma mark - Actions

- (IBAction)subscribe:(id)sender {
    
     [self activityOverlay:YES];
    
    __weak typeof(self) weakSelf =  self;

    [[METwitterDataProvider new] followUser:self.userName withCompletionBlock:^(BOOL sucess){
        [weakSelf activityOverlay:NO];
        if(!sucess)
        {
            [self showError];
        }else{
            NSString *msg = [NSString stringWithFormat:@"You just subscribed to \"%@\"",self.userName];
            [weakSelf showMessage:msg];
        }
    }];
}

#pragma mark Button Actions

- (IBAction)addUsers:(id)sender {
    [self.navigationController pushViewController:[MEUsersViewController instance] animated:YES];
}

- (IBAction)tweet:(id)sender {
    [self.navigationController pushViewController:[METweetViewController instance] animated:YES];
}

- (IBAction)logout:(id)sender {
    [[AppDelegate sharedAppDelegate] setRootViewController:[MELoginViewController instance] animated:YES];
}

#pragma mark - Table View Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MECell" forIndexPath:indexPath];
    MEWallEntity *entery = self.dataSource[indexPath.row];
    cell.textLabel.text = entery.message;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@)",entery.username,[entery.date formatMETwitterDate]];
    return cell;
}

#pragma mark - Helper

- (void)activityOverlay:(BOOL)paramShow
{
    self.tableView.hidden = paramShow;
    self.activityView.hidden = !paramShow;
}
@end
