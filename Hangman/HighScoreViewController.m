//
//  HighScoreViewController.m
//  Hangman
//
//  Created by Emiel on 11/30/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//
//  Manages the High Score View. Shows the current high scores.

#import "HighScoreViewController.h"

@interface HighScoreViewController ()
@property (retain, readwrite, nonatomic) HighScoreModel *highScoreModel;
@end

@implementation HighScoreViewController
@synthesize highScoreModel = _highScoreModel;

@synthesize highScoreLabel = _highScoreLabel;
@synthesize highNameLabel = _highNameLabel;

#pragma mark - Getters
- (HighScoreModel *)highScoreModel {
    if (_highScoreModel == nil) {
        _highScoreModel = [[HighScoreModel alloc] init];
    }
    return _highScoreModel;
}

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
/*
 * Displays high scores in the labels
 */
- (void)printHighScore:(NSArray *)highscore {
    NSMutableString *names = [NSMutableString string];
    NSMutableString *scores = [NSMutableString string];
    
    for (int i = 0; i < self.highScoreModel.names.count; i++) {
        [names appendFormat:@"%i.\t %@\n", i + 1, self.highScoreModel.names[i]];
        [scores appendFormat:@"%@\n", self.highScoreModel.scores[i]];
    }
    
    self.highNameLabel.text = names;
    self.highScoreLabel.text = scores;
}

#pragma mark - IBActions
- (IBAction)donePressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
