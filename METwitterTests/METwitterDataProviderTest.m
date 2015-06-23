//
//  MEDatabaseTests.m
//  MEDatabaseTests
//
//  Created by Muge Ersoy on 18/06/2015.
//  Copyright (c) 2015 MugeErsoy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "METwitterDataProvider.h"
#import "MEWallEntery.h"
#import "METwitterSession.h"
#import "MEDataBase.h"

@interface MEDatabaseTests : XCTestCase

@property (nonatomic, copy) NSString *currentUserName;
@property (nonatomic, copy) NSString *friendUserName;


@end

@implementation MEDatabaseTests

- (void)setUp {
    [super setUp];
    self.currentUserName = @"Muge";
    self.friendUserName = @"Ersoy";
    [[METwitterSession sharedInstance] setUsername:self.currentUserName];
   // [[METwitterSession sharedInstance].dataBase emptyStorage];



}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSendTweet {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"testSendTweet"];

    MEWallEntery *entery = [MEWallEntery initWithUsername:self.currentUserName message:@"This is a tweet"];

    
    [[METwitterDataProvider new] sendMessage:entery withCompletionBlock:^(BOOL success){
        XCTAssertTrue(success, @"Send message should return successfull");
        [expectation fulfill];

    }];
    
    [self waitForExpectationsWithTimeout:2 handler:^(NSError *error) {
        XCTAssertNil(error, @"Error should be nil");

    }];
}

- (void)testgetWallEnteriesForCurrentUser {

    XCTestExpectation *expectation = [self expectationWithDescription:@"testgetWallEnteriesForCurrentUser"];
    MEWallEntery *entery = [MEWallEntery initWithUsername:self.currentUserName message:@"This is a tweet"];
    [[METwitterDataProvider new] sendMessage:entery withCompletionBlock:^(BOOL success){
        
    }];
    [[METwitterDataProvider new] getMyWallEnteriesWithCompletionBlock:^(NSArray *enteries,NSError *error){
        XCTAssertNil(error, @"Error should be nil");
        XCTAssertTrue([enteries count] > 0, @"There should be enteries");

        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        XCTAssertNil(error, @"Error should be nil");
    }];
}



- (void)testGetListOfUsers {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"testGetListOfUsers"];
    
    MEWallEntery *entery = [MEWallEntery initWithUsername:self.friendUserName message:@"This is a tweet"];
    [[METwitterDataProvider new] sendMessage:entery withCompletionBlock:^(BOOL success){
        
    }];
    [[METwitterDataProvider new] getListOfUsersWithCompletionBlock:^(NSArray *users, NSError *error){
        XCTAssertNil(error, @"Error should be nil");
        XCTAssertTrue([users count] > 0, @"There should be enteries");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        XCTAssertNil(error, @"Error should be nil");
    }];
}

- (void)testSubscribeToUser{
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"testSubscribeToUser"];


    [[METwitterDataProvider new] followUser:self.friendUserName  withCompletionBlock:^(BOOL success){
        XCTAssertTrue(success, @"There should be enteries");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        XCTAssertNil(error, @"Error should be nil");
    }];
}

@end
