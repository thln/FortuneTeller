//
//  TLNFortunesModel.m
//  Lab3Fortunes
//
//  Created by Tam Henry Le Nguyen on 10/4/14.
//  Copyright (c) 2014 Tam Henry Le Nguyen. All rights reserved.
//

#import "TLNFortunesModel.h"

//Keys for dictionary
NSString *const AnswerArray = @"AnswerArray";
NSString *const SecretAnswer = @"SecretAnswer";

//Filename for data - answers plist
NSString *const AnswersPlist = @"answers.plist";

//class extension
@interface TLNFortunesModel ()
//private properties
@property (strong, nonatomic) NSMutableArray *answers;
@property (strong, nonatomic) NSString *filepath;
@property (strong, nonatomic) NSMutableDictionary *plist;

@end


@implementation TLNFortunesModel

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        _filepath = [documentsDirectory stringByAppendingPathComponent:AnswersPlist];
        _plist = [NSMutableDictionary dictionaryWithContentsOfFile:_filepath];
        
        if(!_plist)
        {
            //no file
            _plist = [NSMutableDictionary dictionaryWithCapacity:2];
            _answers = [[NSMutableArray alloc] initWithObjects:@"Fortune1", @"Fortune2", @"Fortune3",
                        @"Fortune4", @"Fortune5", nil];
            [_plist setObject:_answers forKey:AnswerArray];
            
            _secretAnswer = @"You will receive a 100% on this lab.";
            [_plist setObject:_secretAnswer forKey:SecretAnswer];
        }
        else
        {
            //get answers from file
            _answers = [_plist objectForKey:AnswerArray];
            _secretAnswer = [_plist objectForKey:SecretAnswer];
        }
    }
    return self;
    /*
    self = [super init];
    if (self) {
        _secretAnswer = @"You will receive an A on this project.";
        _answers = [[NSMutableArray alloc] initWithObjects:
                    @"It's time to move on.",
                    @"Procrastination is never a key.",
                    @"Enjoy the journey, and you will reach the destination.",
                    @"Focus this week.",
                    nil];
    }
    return self;
     */
}

+ (instancetype) sharedModel
{
    static TLNFortunesModel *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //code to be executed once - thread safe version
        _sharedModel = [[self alloc] init];
    });
    
    return _sharedModel;
}

-(void) save
{
    [self.plist setObject:self.answers forKey:AnswerArray];
    [self.plist setObject:self.secretAnswer forKey:SecretAnswer];
    
    [self.plist writeToFile:self.filepath atomically:YES];
}

- (NSString *) randomAnswer
{
    if([self numberOfAnswers])
    {
    NSUInteger index = random() % [self numberOfAnswers];
    return [self.answers objectAtIndex: index];
    }
    else
    {
        return @"I got nothing.";
    }
}

- (NSUInteger) numberOfAnswers
{
    return [self.answers count];
}

- (NSString *) answerAtIndex: (NSUInteger) index
{
    return [self.answers objectAtIndex: index];
}

- (void) removeAnswerAtIndex: (NSUInteger) index
{
    NSUInteger numOfAnswers = [self numberOfAnswers];
    if( index < numOfAnswers)
    {
        [self.answers removeObjectAtIndex: index];
        [self save];
    }
}

- (void) insertAnswer: (NSString *) answer atIndex: (NSUInteger) index
{
    NSUInteger numOfAnswers = [self numberOfAnswers];
    if( index <= numOfAnswers)
    {
        [self.answers insertObject: answer atIndex:index ];
        [self save];
    }
}

//Override secret answer setter
- (void) setSecretAnswer:(NSString *) newSecretAnswer
{
    _secretAnswer = newSecretAnswer;
    [self save];
}


@end
