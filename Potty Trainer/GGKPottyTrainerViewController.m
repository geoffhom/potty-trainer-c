//
//  GGKPottyTrainerViewController.m
//  Potty Trainer
//
//  Created by Geoff Hom on 2/4/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKPottyTrainerViewController.h"

#import "GGKPickBackgroundColorViewController.h"
#import "GGKSavedInfo.h"
#import "UIColor+GGKColors.h"

//BOOL GGKCreateLaunchImages = YES;
BOOL GGKCreateLaunchImages = NO;

@interface GGKPottyTrainerViewController ()

@property (strong, nonatomic) GGKPickBackgroundColorViewController *pickBackgroundColorViewController;

@end

@implementation GGKPottyTrainerViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // Make UI blank so we can make launch images via screenshot.
    if (GGKCreateLaunchImages) {
        
        self.navigationItem.title = @"";
        for (UIView *aSubView in self.view.subviews) {
            
            aSubView.hidden = YES;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Check theme.
    NSString *theThemeString = [[NSUserDefaults standardUserDefaults] objectForKey:GGKThemeKeyString];
    if ([theThemeString isEqualToString:GGKBoyThemeString]) {
        
        self.view.backgroundColor = [UIColor cyanColor];
    } else if ([theThemeString isEqualToString:GGKGirlThemeString]) {
        
        self.view.backgroundColor = [UIColor pinkColor];
    } else {
        
        self.view.backgroundColor = [UIColor whiteColor];
    }
}

@end
