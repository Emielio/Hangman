//
//  ViewController.m
//  Hangman
//
//  Created by Emiel on 11/6/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (readonly, nonatomic) HangmanBrain *brain;
@end

@implementation ViewController
@synthesize guessedLabel = _guessedLabel;
@synthesize wordLabel = _wordLabel;
@synthesize guessField = _guessField;
@synthesize brain = _brain;

- (HangmanBrain *)brain {
    if (_brain == nil) {
        _brain = [[HangmanBrain alloc] init];
    }
    return _brain;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *) updateWord:(char)guess {
    [self.brain guessLetter:guess];
    
    return self.brain.currentState;
    
}

- (IBAction)checkUserInput:(UIButton *)sender {
    NSLog(@"Starting");
    
    if ([self.guessField.text length] != 1) {
        NSLog(@"Please enter 1 character at a time.");
        return;
    }
    char guess = [self.guessField.text characterAtIndex:0];
    
    // TODO Check if length is 1
    
    self.guessedLabel.text = [self.guessedLabel.text stringByAppendingFormat:@"%c, ", guess];
    
    NSLog(@"Checking word");
    self.wordLabel.text = [self updateWord:guess];
    
    
    self.guessField.text = @"";
}

@end
