//
//  GGKSettingsViewController.h
//  Potty Trainer
//
//  Created by Geoff Hom on 2/21/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GGKSettingsViewController : UIViewController <UIAlertViewDelegate>

// For cancelling the current reminder. If no reminder, disable this.
@property (nonatomic, weak) IBOutlet UIButton *cancelButton;

// For telling the user if there is a reminder, and when.
@property (nonatomic, weak) IBOutlet UILabel *reminderLabel;

// For setting a reminder. Change label depending on whether a reminder already exists.
@property (nonatomic, weak) IBOutlet UIButton *setOrChangeReminderButton;

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
// So, if user confirmed she wants to reset the history, do so.

// Make sure the existing reminder doesn't go off.
- (IBAction)cancelReminder;

// Play sound as aural feedback for pressing button.
- (IBAction)playButtonSound;

- (IBAction)resetHistory;
// So, ask the user to confirm she wants to reset the history of potty attempts.

// UIViewController override.
- (void)viewDidLoad;

// UIViewController override.
- (void)viewWillAppear:(BOOL)animated;

@end
