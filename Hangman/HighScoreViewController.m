//
//  HighScoreViewController.m
//  Hangman
//
//  Created by Emiel on 11/30/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//

#import "HighScoreViewController.h"

@interface HighScoreViewController ()

@end

@implementation HighScoreViewController
@synthesize highScoreLabel = _highScoreLabel;
@synthesize highNameLabel = _highNameLabel;

#pragma mark - UIViewController overrides
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *highscore = [[NSUserDefaults standardUserDefaults] objectForKey:@"highScoreList"];
    
    [self printHighScore:highscore];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


#pragma mark - High Score core methods

- (void)printHighScore:(NSArray *)highscore {
    NSMutableString *scoreOutput = [NSMutableString string];
    NSMutableString *nameOutput = [NSMutableString string];
    
    for (int i = 0; i < highscore.count; i++) {
        [nameOutput appendFormat:@"%i.\t %@\n", i + 1, highscore[i][1]];
        [scoreOutput appendFormat:@"%@\n", highscore[i][0]];
    }
    
    self.highNameLabel.text = nameOutput;
    self.highScoreLabel.text = scoreOutput;
}

#pragma mark - IBActions

- (IBAction)donePressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
