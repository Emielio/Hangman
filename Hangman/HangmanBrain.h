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
@property (retain, readwrite, nonatomic) NSArray *possibleWords;
@property (assign, readwrite, nonatomic) int score;
@property (assign, readwrite, nonatomic) int lives;


- (HangmanBrain *)initWithLives:(int)lives andWordsize:(int)wordsize;

- (BOOL)guess:(NSString *)letter;

- (BOOL)won;

- (BOOL)lost;

- (void)memoryWarning;

- (void)clean;
@end
