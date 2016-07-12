//
//  ViewController.m
//  TextInput
//
//  Created by Tam Henry Le Nguyen on 10/31/14.
//  Copyright (c) 2014 Tam Henry Le Nguyen. All rights reserved.
//

#import "TLNInputViewController.h"

@interface TLNInputViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation TLNInputViewController
- (IBAction)saveButtonTapped:(id)sender {
    if(self.completionHandler)
    {
        self.completionHandler(self.inputField.text);
    }
}

- (IBAction)cancelButtonTapped:(id)sender {
    if (self.completionHandler)
    {
        self.completionHandler(nil);
    }
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *changedString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    [self validateSaveButtonForText: changedString];
    
    //Do not actually replace text field's text!
    //Return YES and let UIKit do it
    return YES;
}

-(void) validateSaveButtonForText: (NSString *) text
{
    self.saveButton.enabled = ([text length] > 0);
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if(self.completionHandler)
    {
        self.completionHandler(self.inputField.text);
    }
    return YES;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.inputField becomeFirstResponder];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
