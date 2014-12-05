//
//  HighScoreModel.m
//  Hangman
//
//  Created by Emiel on 12/4/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//

#import "HighScoreModel.h"

@implementation HighScoreModel
@synthesize names = _names;
@synthesize scores = _scores;


- (NSArray *)names {
    if (_names == nil) {
        [self loadHighScores];
    }
    return _names;
}

- (NSArray *)scores {
    if (_scores == nil) {
        [self loadHighScores];
    }
    return _scores;
}



- (void)loadHighScores {
    NSArray *highscores = [[NSUserDefaults standardUserDefaults] objectForKey:@"highScoreList"];
    
    NSMutableArray *scores = [NSMutableArray arrayWithCapacity:10];
    NSMutableArray *names = [NSMutableArray arrayWithCapacity:10];
    
    for (NSArray *entry in highscores) {
        [names addObject:entry[1]];
        [scores addObject:entry[0]];
    }
    
    self.names = names;
    self.scores = scores;
}

+ (void)enterHighScore:(int)score withName: (NSString *)name {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (name.length > 12) {
        name = [name substringToIndex:12];
    }
    
    NSMutableArray *highScores = [[defaults objectForKey:@"highScoreList"] mutableCopy];
    
    NSArray *current = @[[NSNumber numberWithInt:score], name];
    
    for (int i = 0; i < highScores.count; i++) {
        if ([current[0] integerValue] >= [highScores[i][0] integerValue]) {
            [highScores insertObject:current atIndex:i];
            break;
        }
    }
    
    NSArray *output;
    if (highScores.count > 10) {
        output = [highScores subarrayWithRange:NSMakeRange(0, 10)];
    }
    else {
        output = highScores;
    }
    
    [defaults setObject:output forKey:@"highScoreList"];
    [defaults synchronize];
}

@end
