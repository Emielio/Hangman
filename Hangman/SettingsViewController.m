//
//  SettingsViewController.m
//  Hangman
//
//  Created by Emiel on 11/17/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize livesSlider = _livesSlider;
@synthesize livesLabel = _livesLabel;
@synthesize settings = _settings;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateSliders];
    [self updateLabels];

}

- (NSUserDefaults *)settings {
    if (_settings == nil) {
        _settings = [NSUserDefaults standardUserDefaults];
    }
    return _settings;
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

- (void)updateSliders {
    int lives = (int) [self.settings integerForKey:@"lives"];
    int wordsize = (int) [self.settings integerForKey:@"wordsize"];
    self.livesSlider.value = lives;
    self.wordsizeSlider.value = wordsize;
}

- (void)updateLabels {
    int lives = (int) [self.settings integerForKey:@"lives"];
    self.livesLabel.text = [NSString stringWithFormat:@"Lives: %i", lives];
    
    int wordsize = (int) [self.settings integerForKey:@"wordsize"];
    self.wordsizeLabel.text = [NSString stringWithFormat:@"Wordsize: %i", wordsize];
}

- (IBAction)livesChanged:(id)sender {
    NSInteger x = self.livesSlider.value;
    [self.settings setInteger:x forKey:@"lives"];
    
    [self.settings synchronize];
    
    [self updateLabels];
}

- (IBAction)wordsizeChanged:(id)sender {
    NSInteger x = self.wordsizeSlider.value;
    [self.settings setInteger:x forKey:@"wordsize"];
    
    [self.settings synchronize];
    
    [self updateLabels];
}



- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
