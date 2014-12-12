//
//  PauseViewController.m
//  Hangman
//
//  Created by Emiel on 12/3/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//
//  Appears when pause button in the MainViewController
//  is pressed, functions as a menu for the app.

#import "PauseViewController.h"

@interface PauseViewController ()
@end

@implementation PauseViewController
@synthesize delegate = _delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) prefersStatusBarHidden {
    return YES;
}

- (IBAction)resumePressed:(id)sender {
    [self dismiss];
}

/*
 * Start new game and dismiss when new game is pressed.
 */
- (IBAction)newgamePressed:(id)sender {
    [self.delegate newGame];
    [self dismiss];
}

- (IBAction)backgroundPressed:(id)sender {
    [self dismiss];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
