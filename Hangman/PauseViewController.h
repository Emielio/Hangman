//
//  PauseViewController.h
//  Hangman
//
//  Created by Emiel on 12/3/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PauseControllerDelegate
- (void) newGame;
@end

@interface PauseViewController : UIViewController

@property (weak, nonatomic) id <PauseControllerDelegate> delegate;

- (IBAction)resumePressed:(id)sender;
- (IBAction)newgamePressed:(id)sender;
- (IBAction)backgroundPressed:(id)sender;

@end

