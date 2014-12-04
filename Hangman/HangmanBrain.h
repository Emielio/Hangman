//
//  hangmanBrain.h
//  Hangman
//
//  Created by Emiel on 11/7/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HangmanBrain : NSObject
@property (copy, readwrite, nonatomic) NSMutableArray *currentState;
@property (retain, readwrite, nonatomic) NSMutableDictionary *areLettersInWord;

@property (assign, readwrite, nonatomic) int score;
@property (assign, readwrite, nonatomic) int lives;
@property (assign, readonly, nonatomic) double progress;

- (HangmanBrain *)initWithLives:(int)lives andWordsize:(int)wordsize;

- (void)guess:(NSString *)letter;

- (BOOL)won;

- (BOOL)lost;

- (NSString *)answer;

- (void)memoryWarning;

- (void)clean;

@end
