//
//  PauseViewController.m
//  Hangman
//
//  Created by Emiel on 12/3/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)resumePressed:(id)sender {
    [self dismiss];
}

- (IBAction)newgamePressed:(id)sender {
    [self.delegate newGame];
    [self dismiss];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
