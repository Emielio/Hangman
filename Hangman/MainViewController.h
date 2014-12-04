//
//  ViewController.h
//  Hangman
//
//  Created by Emiel on 11/6/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HangmanBrain.h"
#import "PauseViewController.h"

@interface MainViewController : UIViewController <UIAlertViewDelegate, UIKeyInput, PauseControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *guessedLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UILabel *livesLabel;
@property (weak, nonatomic) IBOutlet UILabel *inputLabel;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *instructionArrow;
@property (weak, nonatomic) IBOutlet UIImageView *gallowImage;

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)newGame;

@end




