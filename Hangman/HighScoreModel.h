//
//  HighScoreModel.h
//  Hangman
//
//  Created by Emiel on 12/4/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HighScoreModel : NSObject

@property (retain, readwrite, nonatomic) NSArray *names;
@property (retain, readwrite, nonatomic) NSArray *scores;

+ (void)enterHighScore:(int)score withName: (NSString *)name;

@end
