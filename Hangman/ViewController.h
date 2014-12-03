//
//  ViewController.h
//  Hangman
//
//  Created by Emiel on 11/6/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HangmanBrain.h"
#import "HighScoreViewController.h"

@interface ViewController : UIViewController <UIAlertViewDelegate, UIKeyInput>

@property (weak, nonatomic) IBOutlet UILabel *guessedLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UILabel *livesLabel;
@property (weak, nonatomic) IBOutlet UILabel *inputLabel;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *instructionArrow;

- (void)checkUserInput;

- (IBAction)newGame:(UIButton *)sender;
- (IBAction)doneEditing:(id)sender;

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

