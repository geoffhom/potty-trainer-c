//
//  GGKAboutUsViewController.m
//  Perfect Potty Pal
//
//  Created by Geoff Hom on 3/5/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKYourSupportViewController.h"

#import "GGKPerfectPottyAppDelegate.h"

@interface GGKYourSupportViewController ()

// For letting the player know when the app is busy/waiting (purchasing something).
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

// For storing the give-a-dollar product available for in-app purchase.
@property (strong, nonatomic) SKProduct *giveADollarProduct;

// For playing sound.
//@property (strong, nonatomic) GGKSoundModel *soundModel;

// Create payment object and add to queue. Return whether the payment was added.
- (BOOL)buyProductWithID:(NSString *)theProductID;

// Ask Apple for info on available products.
- (void)requestProductData;

//// Start an activity indicator spinning to show the user that the app's working/waiting and the user should wait.
//- (void)startActivityIndicator;
//
//// Stop the activity indicator so the user knows she can do stuff.
//- (void)stopActivityIndicator;

// Show the number of stars purchased. (One star per dollar given.)
- (void)updateStars;

@end

@implementation GGKYourSupportViewController

- (BOOL)buyProductWithID:(NSString *)theProductID
{    
    BOOL thePaymentWasAdded;
    if ([SKPaymentQueue canMakePayments]) {
        
        SKPayment *thePayment = [SKPayment paymentWithProduct:self.giveADollarProduct];
//        [self startActivityIndicator];
        [ [SKPaymentQueue defaultQueue] addPayment:thePayment ];
        thePaymentWasAdded = YES;
    } else {
        
        // Warn user that purchases are disabled.
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Can't Purchase" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        alertView.message = [ NSString stringWithFormat:@"I'm sorry, but you can't purchase this because in-app purchases on this device are currently disabled. You can change this in the device Settings under General -> Restrictions -> In-App Purchases."];
        [alertView show];
        thePaymentWasAdded = NO;
    }
    return thePaymentWasAdded;
}

- (IBAction)emailUs
{
    MFMailComposeViewController *aMailComposeViewController = [[MFMailComposeViewController alloc] init];
    aMailComposeViewController.mailComposeDelegate = self;
    
    NSArray *theToRecipientsArray = @[@"geoffhom@gmail.com"];
    [aMailComposeViewController setToRecipients:theToRecipientsArray];
    
    NSString *theAppName = @"Perfect Potty";
    [aMailComposeViewController setSubject:theAppName];
    
    // Include app version.
    NSString *theVersionString = (NSString *)[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    UIDevice *theDevice = [UIDevice currentDevice];
    NSString *theMessageBody = [NSString stringWithFormat:@"(Using %@, version %@, on an %@ running %@ %@.)"
                                "\n\nFeedback:", theAppName, theVersionString, theDevice.localizedModel, theDevice.systemName, theDevice.systemVersion];
    [aMailComposeViewController setMessageBody:theMessageBody isHTML:NO];
    
    [self presentViewController:aMailComposeViewController animated:YES completion:nil];
}

- (IBAction)giveADollar
{
    BOOL thePaymentWasAdded = [self buyProductWithID:self.giveADollarProduct.productIdentifier];
    if (thePaymentWasAdded) {
        
        self.view.window.userInteractionEnabled = NO;
        [self.giveADollarButton setTitle:@"Giving…" forState:UIControlStateDisabled];
        self.giveADollarButton.enabled = NO;        
    }
}

- (void)inAppPurchaseObserverDidHandleUpdatedTransactions:(id)sender
{    
//    NSLog(@"STVC iAPODHUT");
    self.giveADollarButton.enabled = YES;
    NSString *theNormalTitle = [self.giveADollarButton titleForState:UIControlStateNormal];
    [self.giveADollarButton setTitle:theNormalTitle forState:UIControlStateDisabled];
    
    [self updateStars];
    
    self.view.window.userInteractionEnabled = YES;
}

- (void)mailComposeController:(MFMailComposeViewController *)theViewController didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [theViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)productsRequest:(SKProductsRequest *)theRequest didReceiveResponse:(SKProductsResponse *)theResponse
{
    NSLog(@"AUVC pR dRR");
    
    // We're not checking specifically for an Internet connection. If there's no Internet, then an empty products array will be here.
    // Do something only if we have a product.
    if (theResponse.products.count >= 1) {
        
        NSLog(@"AUVC pR dRR: 1+ products found");
        SKProduct *aProduct = theResponse.products[0];
        if ([aProduct.productIdentifier isEqualToString:GGKGiveDollarProductIDString]) {
            
            // Show the price in local currency. Enable the purchase button.
            NSNumberFormatter *aNumberFormatter = [[NSNumberFormatter alloc] init];
            [aNumberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
            [aNumberFormatter setLocale:aProduct.priceLocale];
            NSString *aFormattedString = [aNumberFormatter stringFromNumber:aProduct.price];
//            NSLog(@"the price is:%@", aFormattedString);
            
            NSString *aString = [NSString stringWithFormat:@"Give $1 (actually %@) via the App Store. We'll really appreciate it!", aFormattedString];
            self.giveADollar1Label.text = aString;
            self.giveADollarButton.enabled = YES;
            self.giveADollarProduct = aProduct;
        }
    } else {
        
        if (theResponse.invalidProductIdentifiers.count >= 1) {
            
            [theResponse.invalidProductIdentifiers enumerateObjectsUsingBlock:^(NSString *aProductIdentifierString, NSUInteger idx, BOOL *stop) {
                
                NSLog(@"Invalid product: %@", aProductIdentifierString);
            }];
        }
    }
}

- (IBAction)rateOrReview
{
    NSLog(@"AUVC rateOrReview");
    
    // Go to the App Store, to this app and the section for "Ratings and Reviews." Note that the app ID won't work prior to the app's first release, but one can test by using the ID of an app that has already been released.
    // App ID for Color Fever: 585564245
    // App ID for Perfect Potty: 615088461
    // App ID for Text Memory: 490464898
    NSString *theAppIDString = @"615088461";
    NSString *theITunesURL = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", theAppIDString];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:theITunesURL]];
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)theError
{
    NSLog(@"AUVC request didFailWithError: %@", [theError localizedDescription]);
}

- (void)requestDidFinish:(SKRequest *)request
{
    NSLog(@"AUVC requestDidFinish");
}

- (void)requestProductData
{
    NSSet *productIDsSet = [NSSet setWithObject:GGKGiveDollarProductIDString];
    SKProductsRequest *productsRequest= [[SKProductsRequest alloc] initWithProductIdentifiers:productIDsSet];
    productsRequest.delegate = self;
    [productsRequest start];
    NSLog(@"AUVC rPD");
}

//- (void)startActivityIndicator
//{
//    if (self.activityIndicatorView == nil) {
//        
//        UIActivityIndicatorView *anActivityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//        anActivityIndicatorView.color = [UIColor blackColor];
//        [self.view addSubview:anActivityIndicatorView];
//        self.activityIndicatorView = anActivityIndicatorView;
//    }
//    
//    self.activityIndicatorView.center = self.view.center;
// if using .center, round origin via CGRectIntegral
//    [self.activityIndicatorView startAnimating];
//}
//
//- (void)stopActivityIndicator
//{
//    ;
//}

- (void)updateStars
{
    NSInteger numberOfStarsPurchasedInteger = self.perfectPottyModel.numberOfStarsPurchasedInteger;
    
    //testing
//    numberOfStarsPurchasedInteger = 12;
    
    NSMutableString *aMutableString = [[NSMutableString alloc] initWithCapacity:10];
    for (int i = 0; i < numberOfStarsPurchasedInteger; i++) {
        
        [aMutableString appendString:GGKStarRewardString];
    }
    self.starsLabel.text = aMutableString;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Height should match size of scroll view in the storyboard.
    CGFloat theScrollViewHeightFloat = 596;
    self.scrollView.contentSize = CGSizeMake(320, theScrollViewHeightFloat);
        
    // Listen for when a purchase is done.
    GGKPerfectPottyAppDelegate *thePottyTrainerAppDelegate = (GGKPerfectPottyAppDelegate *)[UIApplication sharedApplication].delegate;
    thePottyTrainerAppDelegate.inAppPurchaseObserver.delegate = self;
    
    // Update number of give-dollar stars purchased.
    [self updateStars];
    
    // Get info on in-app purchase.
    self.giveADollarButton.enabled = NO;
    [self requestProductData];
    
    // Enable "Email Us" only if available.
    self.emailUsButton.enabled = [MFMailComposeViewController canSendMail];
    
    // Show version number.
    NSString *versionString = (NSString *)[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    self.versionLabel.text = [NSString stringWithFormat:@"App version: %@", versionString];
}

@end
