//
//  SDEventItemTests.m
//  TodayTests
//
//  Created by shendong on 2017/11/23.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SDEventItem.h"


@interface SDEventItemTests : XCTestCase

@end

@implementation SDEventItemTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}
- (void)testQueryExample{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Fetch data from server-side"];
    [[SDEventItem queryAllCurrentUserEvents] subscribeNext:^(NSArray * _Nullable x) {
        [expectation fulfill];
    } error:^(NSError * _Nullable error) {
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5 handler:^(NSError * _Nullable error) {
        NSLog(@"error = %@",error);
    }];
}

@end
