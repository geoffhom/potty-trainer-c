//
//  GGKAddPottyViewController.h
//  Potty Trainer
//
//  Created by Geoff Hom on 2/23/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKViewController.h"

#import <UIKit/UIKit.h>

@protocol GGKAddPottyViewControllerDelegate

// Sent after a potty attempt has been added.
- (void)addPottyViewControllerDidAddPottyAttempt:(id)sender;

@end

@interface GGKAddPottyViewController : GGKViewController

// For choosing the date of a potty attempt.
@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) id <GGKAddPottyViewControllerDelegate> delegate;

// For choosing the symbol for the attempt.
@property (nonatomic, weak) IBOutlet UISegmentedControl *symbolSegmentedControl;

// For choosing whether the attempt was successful or not.
@property (nonatomic, weak) IBOutlet UISegmentedControl *successfulSegmentedControl;

// User chooses a symbol. Successfulness control automatically adjusts.
- (IBAction)adjustSuccessfulness:(UISegmentedControl *)theSymbolSegmentedControl;

// User chooses the custom symbol ("…" or the custom symbol). User can enter a custom symbol.
- (IBAction)showUseCustomSymbolView:(UISegmentedControl *)theSymbolSegmentedControl;

// Add the potty attempt.
- (IBAction)savePottyAttempt;

// Override.
- (void)viewDidLoad;

// Override.
- (void)viewWillAppear:(BOOL)animated;

@end
