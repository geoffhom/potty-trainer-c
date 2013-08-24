//
//  GGKPottyTrainerViewController.h
//  Potty Trainer
//
//  Created by Geoff Hom on 2/4/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKViewController.h"

#import <UIKit/UIKit.h>

@interface GGKRootViewController : GGKViewController

// Name of the current child.
@property (strong, nonatomic) IBOutlet UILabel *currentChildLabel;

// Override.
- (void)viewDidLoad;

// Override.
- (void)viewWillAppear:(BOOL)animated;

@end