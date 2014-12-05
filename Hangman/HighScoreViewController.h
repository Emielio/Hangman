//
//  HighScoreViewController.h
//  Hangman
//
//  Created by Emiel on 11/30/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighScoreModel.h"

@interface HighScoreViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *highNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;

- (IBAction)donePressed:(id)sender;

@end
