//
//  ViewController.h
//  TextInput
//
//  Created by Tam Henry Le Nguyen on 10/31/14.
//  Copyright (c) 2014 Tam Henry Le Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TLNInputCompletionHandler)(NSString *inputText);

@interface TLNInputViewController : UIViewController <UITextFieldDelegate>

@property (copy,nonatomic) TLNInputCompletionHandler completionHandler;

@end

