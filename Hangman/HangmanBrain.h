//
//  hangmanBrain.h
//  Hangman
//
//  Created by Emiel on 11/7/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HangmanBrain : NSObject

@property (readonly, nonatomic) NSString *hangmanWord;
@property (copy, readwrite, nonatomic) NSString *currentState;
@property (copy, readwrite, nonatomic) NSMutableArray *guessedLetters;
@property (readwrite, nonatomic) int lives;

- (HangmanBrain *)initWithLives:(int)lives;

- (BOOL)guess:(char)letter;

- (BOOL)won;

- (BOOL)lost;

- (void)clean;
@end
