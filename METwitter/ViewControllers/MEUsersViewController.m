//
//  MEUsersViewController.m
//  METwitter
//
//  Created by Pembe Muge Ersoy on 22/06/2015.
//  Copyright (c) 2015 MugeErsoy. All rights reserved.
//

#import "MEUsersViewController.h"
#import "METwitterDataProvider.h"
#import "METwitterSession.h"
#import "MEFriendShipEntity.h"
#import "UIViewController+MessageHandler.h"
#import "MEConstants.h"
#import "MEWallViewController.h"

@interface MEUsersViewController ()<UITableViewDataSource, UITableViewDelegate>


@property (copy, nonatomic) NSArray *dataSource;

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation MEUsersViewController


+ (instancetype)instance
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MEStoryBoardString bundle:nil];
    MEUsersViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:MEUsersViewControllerString];
    return viewController;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
        self.title = @"Users";
    __weak typeof(self) weakSelf =  self;

    [[METwitterDataProvider new] getListOfUsersWithCompletionBlock:^(NSArray *users, NSError *error)
     {
         if(error)
         {
             [weakSelf showError];
         }else{
             weakSelf.dataSource = [users copy];
             [weakSelf.tableview reloadData];
         }
     }];
}

#pragma mark - Table View

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Registered Users";
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MEUserCell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MEStoryBoardString bundle:nil];
    MEWallViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:MEWallViewControllerString];
    viewController.userName = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
