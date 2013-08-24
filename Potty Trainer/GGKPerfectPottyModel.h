//
//  GGKPerfectPottyModel.h
//  Perfect Potty
//
//  Created by Geoff Hom on 8/23/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GGKChild.h"

@interface GGKPerfectPottyModel : NSObject

// Child the parent is currently tracking.
@property (strong, nonatomic) GGKChild *currentChild;

// Custom symbol to use, if any, for a new potty attempt.
@property (strong, nonatomic) NSString *currentCustomSymbol;

// For in-app donation. Not related to child rewards.
@property (assign, nonatomic) NSInteger numberOfStarsPurchasedInteger;

// The reminder is set using date components. I.e., time from the given date. 
@property (strong, nonatomic) NSDateComponents *reminderIncrementDateComponents;

// Override.
- (id)init;

@end