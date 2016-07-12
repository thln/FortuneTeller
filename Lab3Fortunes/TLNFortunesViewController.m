//
//  TLNFortunesViewController.m
//  Lab3Fortunes
//
//  Created by Tam Henry Le Nguyen on 10/4/14.
//  Copyright (c) 2014 Tam Henry Le Nguyen. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "TLNFortunesViewController.h"
#import "TLNFortunesModel.h"
#import "TLNInputViewController.h"


@interface TLNFortunesViewController ()

//private properties
@property (strong, nonatomic) TLNFortunesModel *model;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (readonly) SystemSoundID soundFileID;

@end

@implementation TLNFortunesViewController

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    TLNInputViewController *inputVC = segue.destinationViewController;
    inputVC.completionHandler = ^(NSString *text) {
            if (text != nil)
            {
                self.model.secretAnswer = text;
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        };
}

- (void) singleTapRecognized: (UITapGestureRecognizer*) recognizer
{
   // TLNFortunesModel *fortunesModel = [[TLNFortunesModel alloc] init];
    NSString *answer = [[NSString alloc] initWithFormat:@"%@", [self.model randomAnswer]];
    
    //Play sound file
    AudioServicesPlaySystemSound(self.soundFileID);
    
    if(answer)
    {
        
        [self displayAnswer: answer];
        //NSUInteger index = [fortunesModel answerAtIndex:answer];
        //[fortunesModel removeAnswerAtIndex:index];
    }
}

- (void) doubleTapRecognized: (UITapGestureRecognizer *) recognizer
{
    //TLNFortunesModel *fortunesModel = [[TLNFortunesModel alloc] init];
    //[self displayAnswer: [fortunesModel secretAnswer]];
    
    //Vibrate
    //AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
    
    [self displayAnswer: self.model.secretAnswer];
}

- (BOOL) canBecomeFirstResponder
{
    return YES;
}

- (void) viewDidAppear:(BOOL) animated
{
    [self becomeFirstResponder];
}

- (void) motionEnded:(UIEventSubtype) motion withEvent:(UIEvent *) event
{
    if(motion == UIEventSubtypeMotionShake)
    {
        TLNFortunesModel *fortunesModel = [[TLNFortunesModel alloc] init];
        NSString *answer = [[NSString alloc] initWithFormat:@"%@", [fortunesModel randomAnswer]];
       
        if(answer)
        {
            [self displayAnswer: answer];
            //NSUInteger index = [fortunesModel answerAtIndex:answer ];
            //[fortunesModel removeAnswerAtIndex:index];
        }
    }
}

- (void) displayAnswer: (NSString *) answer
{
    [UIView animateWithDuration:1.0 animations:^{self.answerLabel.alpha = 0;} completion:^(BOOL finished) {
        [self animateAnswer: answer];
    }];
    
}

- (void) animateAnswer: (NSString *) answer
{
    [UIView animateWithDuration:1.0
                     animations:^{
                         self.answerLabel.text = answer;
                         
                         if(self.answerLabel.textColor == UIColor.blackColor)
                         {
                             self.answerLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:0.0 blue:0.0 alpha:1.0];
                         }
                         else{
                             self.answerLabel.textColor = UIColor.blackColor;
                         }
                         self.answerLabel.alpha = 1;
                     }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _model = [TLNFortunesModel sharedModel];
    
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"TaDa" ofType:@"wav"];
    NSURL *soundURL = [NSURL fileURLWithPath:soundFilePath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) soundURL, &_soundFileID);
    
    UITapGestureRecognizer *singleTap =
    [[UITapGestureRecognizer alloc] initWithTarget: self
        action:@selector(singleTapRecognized:)];
    [self.view addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *doubleTap =
    [[UITapGestureRecognizer alloc] initWithTarget: self
        action:@selector(doubleTapRecognized:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
    //Only recognize single taps if they're not the first of two
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    //NSLog (@"After init");
    //NSLog (@"Number of answers: %d", [self.model numberOfAnswers]);
    
    //NSLog (@"Call insertAnswer");
    [_model insertAnswer: @"Luck is with you." atIndex:0];
    //NSLog (@"Number of answers: %d", [self.model numberOfAnswers]);
    
   // NSLog (@"Call removeAnswerAtIndex");
    [_model removeAnswerAtIndex:0];
   // NSLog (@"Number of answers: %d", [self.model numberOfAnswers]);
     
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
