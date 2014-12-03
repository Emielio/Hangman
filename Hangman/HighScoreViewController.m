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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *highscore = [[NSUserDefaults standardUserDefaults] objectForKey:@"highScoreList"];
    
    [self printHighScore:highscore];
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
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

- (IBAction)donePressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
