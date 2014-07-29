//
//  Another_Scrolling_ShooterTests.m
//  Another Scrolling ShooterTests
//
//  Created by Clay on 7/27/14.
//  Copyright (c) 2014 Clay Jones. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SSColor.h"

@interface Another_Scrolling_ShooterTests : XCTestCase

@end

@implementation Another_Scrolling_ShooterTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testColorDifference {
  UIColor *color3 = [SSColor colorWithHue:.3f];
  UIColor *color7 = [SSColor colorWithHue:.7f];
  UIColor *color5 = [SSColor colorWithHue:.5f];
  UIColor *color1 = [SSColor colorWithHue:.1f];
  UIColor *color9 = [SSColor colorWithHue:.9f];
  UIColor *color95 = [SSColor colorWithHue:.95f];
  UIColor *color55 = [SSColor colorWithHue:.55f];
  UIColor *color17 = [SSColor colorWithHue:.17f];
  
  XCTAssertEqualWithAccuracy([SSColor colorDifference:color3 from:color7], 0.4f, 0.00001f, @"should be .4 apart");
  XCTAssertEqualWithAccuracy([SSColor colorDifference:color3 from:color5], 0.2f, 0.00001f, @"should be .2 apart");
  XCTAssertEqualWithAccuracy([SSColor colorDifference:color1 from:color9], 0.2f, 0.00001f, @"should be .2 apart");
  XCTAssertEqualWithAccuracy([SSColor colorDifference:color3 from:color9], 0.4f, 0.00001f, @"should be .4 apart");
  XCTAssertEqualWithAccuracy([SSColor colorDifference:color95 from:color55], 0.4f, 0.00001f, @"should be .4 apart");
  XCTAssertEqualWithAccuracy([SSColor colorDifference:color17 from:color95], 0.22f, 0.00001f, @"should be .22 apart");
}

@end
