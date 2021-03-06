//
//  GGKAboutUsViewController.h
//  Perfect Potty Pal
//
//  Created by Geoff Hom on 3/5/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKViewController.h"

#import "GGKInAppPurchaseObserver.h"
#import <MessageUI/MessageUI.h>
#import <StoreKit/StoreKit.h>
#import <UIKit/UIKit.h>

@interface GGKYourSupportViewController : GGKViewController <GGKInAppPurchaseObserverDelegate, MFMailComposeViewControllerDelegate, SKProductsRequestDelegate>

// For letting the user email the developers.
@property (nonatomic, weak) IBOutlet UIButton *emailUsButton;

// For describing giving a dollar to the developers. Should include price in local currency.
@property (nonatomic, weak) IBOutlet UILabel *giveADollar1Label;

// For letting the user give the developers a dollar (USD $1).
@property (nonatomic, weak) IBOutlet UIButton *giveADollarButton;

// User scrolls to read the rest of this section.
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

// For showing the stars purchased.
@property (nonatomic, weak) IBOutlet UILabel *starsLabel;

// For showing the app's version number.
@property (nonatomic, weak) IBOutlet UILabel *versionLabel;

// Help the user send an email to the developers. Start an email with the destination, subject line and some message body.
- (IBAction)emailUs;

// Buy the product "give a dollar."
- (IBAction)giveADollar;

- (void)inAppPurchaseObserverDidHandleUpdatedTransactions:(id)sender;
// So, update the UI.

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error;
// So, dismiss the email view.

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response;
// So, populate the store UI.

// Help the user rate/review this app by taking them to the App Store.
- (IBAction)rateOrReview;

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error;
// So, log the error.

- (void)requestDidFinish:(SKRequest *)request;
// So, log the success.
// Override.
- (void)viewDidLoad;
@end
