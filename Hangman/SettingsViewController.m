//
//  SettingsViewController.m
//  Hangman
//
//  Created by Emiel on 11/17/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//
//  Controls the Settings View. On load, sets slider, switch and label values to
//  defaults. When values are manually changed, it sets defaults to those, values.


#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize livesSlider = _livesSlider;
@synthesize livesLabel = _livesLabel;
@synthesize evilSwitch = _evilSwitch;
@synthesize defaults = _defaults;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateSliders];
    [self updateLabels];

}

- (NSUserDefaults *)defaults {
    if (_defaults == nil) {
        _defaults = [NSUserDefaults standardUserDefaults];
    }
    return _defaults;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


/*
 * Updates sliders with values from defaults.
 */
- (void)updateSliders {
    int lives = (int) [self.defaults integerForKey:@"lives"];
    int wordsize = (int) [self.defaults integerForKey:@"wordsize"];
    BOOL evil = [self.defaults boolForKey:@"evilMode"];
    self.livesSlider.value = lives;
    self.wordsizeSlider.value = wordsize;
    self.evilSwitch.on = evil;
}

/*
 * Updates labels with values from defaults.
 */
- (void)updateLabels {
    int lives = (int) [self.defaults integerForKey:@"lives"];
    self.livesLabel.text = [NSString stringWithFormat:@"Lives: %i", lives];
    
    int wordsize = (int) [self.defaults integerForKey:@"wordsize"];
    self.wordsizeLabel.text = [NSString stringWithFormat:@"Wordsize: %i", wordsize];
}

/*
 * When the lives value changes, updates defaults and labels.
 */
- (IBAction)livesChanged:(id)sender {
    NSInteger x = self.livesSlider.value;
    [self.defaults setInteger:x forKey:@"lives"];
    
    [self.defaults synchronize];
    
    [self updateLabels];
}

/*
 * When the lives value changes, updates defaults and labels.
 */
- (IBAction)wordsizeChanged:(id)sender {
    NSInteger x = self.wordsizeSlider.value;
    [self.defaults setInteger:x forKey:@"wordsize"];
    
    [self.defaults synchronize];
    
    [self updateLabels];
}

/*
 * When the evil value changes, update labels.
 */
- (IBAction)evilChanged:(id)sender {
    BOOL x = self.evilSwitch.on;
    [self.defaults setBool:x forKey:@"evilMode"];
}


- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
