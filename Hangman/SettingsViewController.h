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
@property (weak, nonatomic) NSNumber *livesSetting;
@property (weak, nonatomic) NSNumber *wordsizeSetting;
@property (weak, nonatomic) IBOutlet UILabel *livesLabel;
@property (weak, nonatomic) NSUserDefaults *settings;

- (IBAction)livesChanged:(id)sender;
- (IBAction)goBack:(id)sender;

@end
