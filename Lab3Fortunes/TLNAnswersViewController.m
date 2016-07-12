//
//  TLNAnswersViewController.m
//  TableView
//
//  Created by Tam Henry Le Nguyen on 10/31/14.
//  Copyright (c) 2014 Tam Henry Le Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLNFortunesModel.h"
#import "TLNInputViewController.h"

@interface TLNAnswersViewController : UITableViewController
@property (strong, nonatomic) TLNFortunesModel *model;

@end


@implementation TLNAnswersViewController

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    TLNInputViewController *inputVC = segue.destinationViewController;
    inputVC.completionHandler = ^(NSString *text) {
        if (text != nil)
        {
            //Insert new table row here
            //add to model
            NSUInteger answerIndex = [self.model numberOfAnswers];
            [self.model insertAnswer:text atIndex:answerIndex];
            
            //add actual row
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:answerIndex inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    };
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.model = [TLNFortunesModel sharedModel];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target:self action:@selector(switchViews:)];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void) switchViews: (id) sender
{
    [self performSegueWithIdentifier:@"showAnswerInput" sender:self];
}

- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView
{
    //Return number of sections
    return 1;
}

- (void) tableView: (UITableView *) tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        //Delete from the model
        //NSLog(@"%i Fortunes", [self.model numberOfAnswers]);
        //NSLog(@"Removing Fortune: %@", [self.model answerAtIndex:indexPath.row]);
        [self.model removeAnswerAtIndex:indexPath.row];
        //NSLog(@"%i Fortunes", [self.model numberOfAnswers]);
        
        //Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        //Create a new instance of the appropriate class
        //insert it into the array
        //add a new row to the table view
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Return number of rows in the section
    return [self.model numberOfAnswers];
}



- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AnswerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //Configure the cell...
    //if statement?
    cell.textLabel.text = [self.model answerAtIndex:indexPath.row];
    return cell;
}
@end
