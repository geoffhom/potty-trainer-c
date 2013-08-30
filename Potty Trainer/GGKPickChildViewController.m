//
//  GGKPickChildViewController.m
//  Perfect Potty
//
//  Created by Geoff Hom on 8/28/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKPickChildViewController.h"

@interface GGKPickChildViewController ()

@end

@implementation GGKPickChildViewController

- (void)editChildNameViewControllerDidCancel:(id)sender
{
    [sender dismissViewControllerAnimated:YES completion:nil];
}

- (void)editChildNameViewControllerDidEnterText:(id)sender
{
    GGKEditChildNameViewController *editChildNameViewController = (GGKEditChildNameViewController *)sender;
    NSString *newName = editChildNameViewController.textField.text;
    
    // If duplicate name, or if blank name, alert user. Else, save new name.
    
    __block BOOL isDuplicate = NO;
    [self.perfectPottyModel.childrenMutableArray enumerateObjectsUsingBlock:^(GGKChild *aChild, NSUInteger idx, BOOL *stop) {
        
        if (aChild != self.perfectPottyModel.currentChild) {
            
            if ([aChild.nameString isEqualToString:newName]) {
                
                isDuplicate = YES;
                *stop = YES;
            }
        }
    }];
    
    BOOL isBlank = NO;
    if ([newName isEqualToString:@""]) {
        
        isBlank = YES;
    }
    
    if (isDuplicate) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Name Already Exists" message:@"Another child has that name. Names must be unique." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
    } else if (isBlank) {
        
        NSString *alertMessageString = @"Please enter a unique name.";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Name Is Blank" message:alertMessageString delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
    } else {
        
        self.perfectPottyModel.currentChild.nameString = newName;
        
        // Alphabetize.
        NSSortDescriptor *aNameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"nameString" ascending:YES];
        NSArray *aSortedArray = [self.perfectPottyModel.childrenMutableArray sortedArrayUsingDescriptors:@[aNameSortDescriptor]];
        self.perfectPottyModel.childrenMutableArray = [aSortedArray mutableCopy];
        
        [self.perfectPottyModel saveChildren];
        
        [sender dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)editName
{
    GGKEditChildNameViewController *editChildNameViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"GGKEditChildNameViewController"];
    editChildNameViewController.delegate = self;
    
    // Prepopulate text field with name of selected child.
    NSIndexPath *selectedIndexPath = [self.childNamesTableView indexPathForSelectedRow];
    GGKChild *childToEdit = self.perfectPottyModel.childrenMutableArray[selectedIndexPath.row];
    editChildNameViewController.childToEdit = childToEdit;
    
    [self presentViewController:editChildNameViewController animated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ChildNameCell";
    UITableViewCell *aTableViewCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    GGKChild *aChild = self.perfectPottyModel.childrenMutableArray[indexPath.row];
    aTableViewCell.textLabel.text = aChild.nameString;
    
    return aTableViewCell;
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)theIndexPath
{
    GGKChild *selectedChild = self.perfectPottyModel.childrenMutableArray[theIndexPath.row];
    self.perfectPottyModel.currentChild = selectedChild;
    [self.perfectPottyModel saveCurrentChildID];
    self.currentChildLabel.text = selectedChild.nameString;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.perfectPottyModel.childrenMutableArray count];
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Set height of table. This is also done in the storyboard and has been sufficient in other cases, but not here. (Don't know why. May be an Autolayout or 4-inch iPhone issue.)
    CGRect frameRect = self.childNamesTableView.frame;
    frameRect.size.height = 220;
    self.childNamesTableView.frame = frameRect;
    
    [self.childNamesTableView reloadData];
    
    // Select current child.
    GGKChild *currentChild = self.perfectPottyModel.currentChild;
    self.currentChildLabel.text = currentChild.nameString;
    NSInteger currentChildIndexInteger = [self.perfectPottyModel.childrenMutableArray indexOfObject:currentChild];
    NSIndexPath *currentChildIndexPath = [NSIndexPath indexPathForRow:currentChildIndexInteger inSection:0];
    [self.childNamesTableView selectRowAtIndexPath:currentChildIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.childNamesTableView scrollToRowAtIndexPath:currentChildIndexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

@end
