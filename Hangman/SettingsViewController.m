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
@synthesize wordsizeSetting = _wordsizeSetting;
@synthesize livesLabel = _livesLabel;
@synthesize settings = _settings;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateSliders];

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
    self.livesSlider.value = lives;
    self.livesLabel.text = [NSString stringWithFormat:@"Lives: %i", lives];
}

- (IBAction)livesChanged:(id)sender {
    NSInteger x = self.livesSlider.value;
    [self updateSliders];
    [self.settings setInteger:x forKey:@"lives"];
    
    [self.settings synchronize];
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
