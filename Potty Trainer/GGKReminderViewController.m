//
//  GGKSettingsViewController.m
//  Potty Trainer
//
//  Created by Geoff Hom on 2/21/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//
#import "GGKReminderViewController.h"

#import "GGKPerfectPottyAppDelegate.h"
#import "GGKReminderTableViewDataSource.h"
#import "NSDate+GGKDate.h"
@interface GGKReminderViewController ()

@property (strong, nonatomic) GGKReminderTableViewDataSource *reminderTableViewDataSourceAndDelegate;
- (void)updateUI;

//// For updating the view at regular intervals.
//@property (strong, nonatomic) NSTimer *timer;
//// Check if there's a reminder. If so, report on it. Else, stop the timer that checks.
//- (void)checkReminderAndUpdate;
//
//// Start a timer to update this view at regular intervals.
//- (void)startUpdateTimer;
//
//// Start updates that occur only while this view is visible to the user. E.g., a timer that updates the view. Listen for when the app enters the background.
//- (void)startVisibleUpdates;
//
//// Make sure the timer doesn't fire anymore.
//- (void)stopTimer;
//
//// Stop anything from -startVisibleUpdates.
//- (void)stopVisibleUpdates;
//
//// Update UI for a reminder existing already.
//- (void)updateForAReminder:(UILocalNotification *)theLocalNotification;
//
//// Update UI for no reminder set yet.
//- (void)updateForNoReminder;
@end

@implementation GGKReminderViewController
//- (IBAction)cancelReminder
//{
//    [[UIApplication sharedApplication] cancelAllLocalNotifications];
//    [self updateForNoReminder];
//}
//
//- (void)checkReminderAndUpdate
//{
////    NSLog(@"SVC checkReminderAndUpdate called");
//    
//    // If no reminder, adjust UI and stop timer. Else, adjust UI and report time remaining.
//    NSArray *theLocalNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
//    if (theLocalNotifications.count >= 1) {
//        
//        [self updateForAReminder:theLocalNotifications[0]];
//    } else {
//        
//        [self updateForNoReminder];
//        [self stopTimer];
//    }
//}
- (void)handleViewWillAppearToUser {
    [super handleViewWillAppearToUser];
    [self updateUI];
//    [self startVisibleUpdates];
}
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"showSetReminderView"]) {
//        [segue.destinationViewController setDelegate:self];
//    }
//}
//- (void)setReminderViewControllerDidSetReminder:(id)sender
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//- (void)startUpdateTimer
//{
//    // Every second, including now, update the view according to whether there's a reminder, and how much time is left.
//    
////    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkReminderAndUpdate) userInfo:nil repeats:YES];
//    
//    NSDate *aNowDate = [NSDate date];
//    NSTimer *aTimer = [[NSTimer alloc] initWithFireDate:aNowDate interval:1.0 target:self selector:@selector(checkReminderAndUpdate) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:aTimer forMode:NSDefaultRunLoopMode];
//    self.timer = aTimer;
//    NSLog(@"SVC timer started");
//}
//- (void)startVisibleUpdates {
//    [self startUpdateTimer];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopVisibleUpdates) name:UIApplicationDidEnterBackgroundNotification object:nil];
//}
//- (void)stopTimer
//{
//    [self.timer invalidate];
//    self.timer = nil;
//    NSLog(@"SVC timer stopped");
//}
//- (void)stopVisibleUpdates {
//    [self stopTimer];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
//}
//- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)theIndexPath {
//    static NSString *TheCellIdentifier = @"ReminderCell";
//    UITableViewCell *aTableViewCell = [theTableView dequeueReusableCellWithIdentifier:TheCellIdentifier];
//    aTableViewCell.textLabel.text = @"No reminders set";
//    return aTableViewCell;
//}
//- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)theSection {
//    return 1;
//}
//- (void)updateForAReminder:(UILocalNotification *)theLocalNotification {
//    // Report hours/mins/secs until reminder, and the actual time of the reminder.
//    
//    NSCalendar *aGregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSCalendarUnit anHourMinSecCalendarUnit = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
//    NSDate *theReminderDate = theLocalNotification.fireDate;
//    NSDateComponents *theReminderIncrementDateComponents = [aGregorianCalendar components:anHourMinSecCalendarUnit fromDate:[NSDate date] toDate:theReminderDate options:0];
//    
//    // Adjust words for singular/plural.
//    NSString *thePluralHourString;
//    if (theReminderIncrementDateComponents.hour == 1) {
//        
//        thePluralHourString = @"";
//    } else {
//        
//        thePluralHourString = @"s";
//    }
//    
//    self.reminderLabel.text = [NSString stringWithFormat:@"A reminder is set for\n%ld hour%@, %ld min, %ld sec\n from now (%@).", (long)theReminderIncrementDateComponents.hour, thePluralHourString, (long)theReminderIncrementDateComponents.minute, (long)theReminderIncrementDateComponents.second, [theReminderDate hourMinuteAMPMString]];
//    
//    self.cancelButton.enabled = YES;
//    [self.setOrChangeReminderButton setTitle:@"Change Reminder" forState:UIControlStateNormal];
//}
//
//- (void)updateForNoReminder
//{
//    self.reminderLabel.text = @"There is currently\nno reminder.";
//    self.cancelButton.enabled = NO;
//    [self.setOrChangeReminderButton setTitle:@"Set Reminder" forState:UIControlStateNormal];
//}
- (void)refreshReminders {
    [self updateUI];
}
- (void)updateUI {
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.reminderTableViewDataSourceAndDelegate = [[GGKReminderTableViewDataSource alloc] initWithTableView:self.tableView];
//    [self updateUI];
}
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    
//    [self stopVisibleUpdates];
//}

@end
