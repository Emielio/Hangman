//
//  ViewController.m
//  Hangman
//
//  Created by Emiel on 11/6/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (retain, readwrite, nonatomic) HangmanBrain *brain;
@property (weak, readonly, nonatomic) NSUserDefaults *settings;
@end

@implementation ViewController
@synthesize brain = _brain;
@synthesize settings = _settings;

@synthesize guessedLabel = _guessedLabel;
@synthesize wordLabel = _wordLabel;
@synthesize guessField = _guessField;
@synthesize livesLabel = _livesLabel;

- (HangmanBrain *)brain {
    // HangmanBrain is instanciated when a new one is necessary.
    if (_brain == nil) {
        int lives = (int) [self.settings integerForKey:@"lives"];
        _brain = [[HangmanBrain alloc] initWithLives:lives];
    }
    return _brain;
}

- (NSUserDefaults *)settings {
    _settings = [NSUserDefaults standardUserDefaults];
    if ([_settings integerForKey:@"lives"] == 0) {
        [_settings setInteger:7 forKey:@"lives"];
    }
    return _settings;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateLabels];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkUserInput:(UIButton *)sender {
    /* 
     * User's input (a letter) is tested in
     * the hangmanbrain.
     */
    if ([self.guessField.text length] != 1) {
        NSLog(@"Please enter 1 character at a time.");
        return;
    }
    char letter = [self.guessField.text characterAtIndex:0];
    
    if ([self.brain guess:letter] == YES)
    {
        [self updateLabels];
        // If the game is won, an alert message is pushed
        if ([self.brain won])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations" message:@"You've won!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
        
    }
    else
    {
        self.brain.lives--;
        [self updateLabels];
        
        if ([self.brain lost])
        {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Too bad" message:@"You have lost" delegate:self cancelButtonTitle:@"Try again" otherButtonTitles:nil];
        [alert show];
        }
    }
}

- (IBAction)newGame:(UIButton *)sender {
    [self clean];
    [self updateLabels];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self clean];
    [self updateLabels];
}

- (void)updateLabels {
    self.wordLabel.text = self.brain.currentState;
    self.livesLabel.text = [NSString stringWithFormat:@"Lives: %d", self.brain.lives];
    self.guessField.text = @"";
    
}

- (void)clean {
    
    [self.brain clean];
    self.brain = nil;
}

@end
