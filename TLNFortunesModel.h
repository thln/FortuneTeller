//
//  TLNFortunesModel.h
//  Lab3Fortunes
//
//  Created by Tam Henry Le Nguyen on 10/4/14.
//  Copyright (c) 2014 Tam Henry Le Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLNFortunesModel : NSObject

//public properties
@property (strong, nonatomic) NSString *secretAnswer;

//public methods
+ (instancetype) sharedModel;
- (NSString *) randomAnswer;
- (NSUInteger) numberOfAnswers;
- (NSString *) answerAtIndex: (NSUInteger) index;
- (void) removeAnswerAtIndex: (NSUInteger) index;
- (void) insertAnswer: (NSString *) answer atIndex: (NSUInteger) index;
- (void) save;
- (void) setSecretAnswer:(NSString *) newSecretAnswer;


@end
