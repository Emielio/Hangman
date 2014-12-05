//
//  SettingsViewController.h
//  Hangman
//
//  Created by Emiel on 11/17/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISlider *livesSlider;
@property (weak, nonatomic) IBOutlet UILabel *livesLabel;
@property (weak, nonatomic) IBOutlet UISlider *wordsizeSlider;
@property (weak, nonatomic) IBOutlet UILabel *wordsizeLabel;

@property (weak, nonatomic) NSUserDefaults *defaults;

- (IBAction)livesChanged:(id)sender;
- (IBAction)wordsizeChanged:(id)sender;
- (IBAction)goBack:(id)sender;

@end
