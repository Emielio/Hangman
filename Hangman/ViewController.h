//
//  ViewController.h
//  Hangman
//
//  Created by Emiel on 11/6/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HangmanBrain.h"

@interface ViewController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *guessedLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UILabel *livesLabel;
@property (weak, nonatomic) IBOutlet UITextField *guessField;

- (IBAction)checkUserInput:(UIButton *)sender;
- (IBAction)newGame:(UIButton *)sender;

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

