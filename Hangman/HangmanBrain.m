//
//  hangmanBrain.m
//  Hangman
//
//  Created by Emiel on 11/7/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//
//  Main brain which handles all game mechanics.

#import "HangmanBrain.h"
@interface HangmanBrain ()
@property (retain, readwrite, nonatomic) DictionaryModel *dictionaryModel;
@property (retain, readwrite, nonatomic) NSArray *possibleWords;

@property (assign, readwrite, nonatomic) int wordsize;
@property (assign, readwrite, nonatomic) int initialLives;
@property (assign, readwrite, nonatomic) BOOL evil;
@end


@implementation HangmanBrain
@synthesize currentState = _currentState;
@synthesize areLettersInWord = _areLettersInWord;
@synthesize lives = _lives;
@synthesize score = _score;
@synthesize progress = _progress;

@synthesize dictionaryModel = _dictionaryModel;
@synthesize possibleWords = _possibleWords;
@synthesize wordsize = _wordsize;

@synthesize initialLives = _initialLives;
@synthesize evil = _evil;




#pragma mark - init
- (HangmanBrain *)initWithLives:(int)lives andWordsize:(int)wordsize isEvil:(BOOL)evil {
    /*
     * Initialize a HangmanBrain with an amount of lives, wordsize and score.
     */
    self.wordsize = 9;
    self = [super init];
    self.wordsize = wordsize;
    self.lives = lives;
    self.initialLives = lives;
    self.evil = evil;
    self.score = 100 - lives;
    [self.dictionaryModel loadDictionary];
    
    if (!evil) {
        self.possibleWords = @[[self randomWordFromArray:self.possibleWords]];
    }
    
    return self;
}

#pragma mark - Getters/Setters
/*
 * Returns a Model which can read the dictionary
 */
- (DictionaryModel *)dictionaryModel {
    if (_dictionaryModel == nil)
    {
        _dictionaryModel = [[DictionaryModel alloc] init];
    }
    return _dictionaryModel;
}

/*
 * Returns an array with the currently still possible words.
 */
- (NSArray *)possibleWords {
    if (_possibleWords == nil)
    {
        NSMutableArray *storage = [NSMutableArray array];
        for (NSString *word in self.dictionaryModel.wordlist)
        {
            if (word.length == self.wordsize)
                [storage addObject:word];
        }

        if (storage.count < 200)
            self.score -= 10;

        _possibleWords = storage;
    }
    return _possibleWords;
}

/*
 * Create a new current word state if none exists
 */
- (NSMutableArray *)currentState {
    if (_currentState == nil)
    {
        _currentState = [NSMutableArray arrayWithCapacity:self.wordsize];
        
        for (int i = 0, n = self.wordsize; i < n; i++)
            [_currentState addObject:@""];
    }
    return _currentState;
}

/*
 * guessedLetters will contain all characters that have been guessed
 */
- (NSMutableDictionary *)areLettersInWord {
    if (_areLettersInWord == nil)
        _areLettersInWord = [NSMutableDictionary dictionaryWithCapacity:26];

    return _areLettersInWord;
}

/*
 * Updates progress if lives is set.
 */
- (void)setLives:(int)lives {
    _lives = lives;
    
    _progress = 1.0 - (double) lives / self.initialLives;
}

#pragma mark - Game Core
/*
 * Guess whether a letter is in the secret word.
 */
- (void)guess:(NSString *)letter {
    
    // Check if letter is guessed already.
    if ([self.areLettersInWord objectForKey:letter] != nil) {
        return;
    }
    
    // Divide words in containers.
    NSMutableDictionary *containers = [NSMutableDictionary dictionary];
    for (NSString *word in self.possibleWords)
    {
        NSString *key = [self hash:letter inString:word];
        
        if ([containers objectForKey:key] == nil)
            containers[key] = [NSMutableArray array];
        
        [containers[key] addObject:word];
    }
    
    // Find the largest container.
    NSArray *largestContainer;
    NSString *correspondingKey;
    for (NSString *key in containers) {
        if ([containers[key] count] > largestContainer.count) {
            largestContainer = containers[key];
            correspondingKey = key;
        }
    }
    
    // possibleWords is reduced to the largest container (i.e. a subrange of itself).
    self.possibleWords = largestContainer;
    
    // Update whether letter is a good or bad guess.
    if ([correspondingKey isEqualToString:@""]) {
        [self.areLettersInWord setObject:[NSNumber numberWithBool:NO] forKey:letter];
        self.lives--;
        self.score--;
    }
    else {
        [self.areLettersInWord setObject:[NSNumber numberWithBool:YES] forKey:letter];
    }
    
    // Update currentState with letters.
    NSArray *indices = [correspondingKey componentsSeparatedByString:@","];
    for (NSString *index in indices)
    {
        if ([index isEqualToString:@""])
            continue;

        [self.currentState replaceObjectAtIndex:[index integerValue] withObject:letter];
    }
}

/*
 * Returns a NSString with format "i_1,i_2,i_3," where i_n is
 * an index at which the letter is in the string.
 */
- (NSString *)hash:(NSString *) letter inString:(NSString *)string {
    char c = [letter characterAtIndex:0];
    
    NSMutableString *locations = [NSMutableString string];
    
    for (int i = 0; i < (int) string.length; i++) {
        if (c == [string characterAtIndex:i]) {
            [locations appendFormat:@"%i,", i];
        }
    }
    return locations;
}

/*
 * Check if the currentState is the secret word.
 */
- (BOOL)won {
    for (NSString *letter in self.currentState)
    {
        if ([letter isEqualToString:@""]) {
            return NO;
        }
    }
    return YES;
}

/*
 * Check whether the lives are 0 (or less).
 */
- (BOOL)lost
{
    if (self.lives <= 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

/*
 * Returns a random string from an array.
 */
- (NSString *)randomWordFromArray:(NSArray *)array {
    NSUInteger max = [array count];
    
    return array[arc4random() % max];
}

/*
 * Get the word if lost.
 */
- (NSString *)answer {
    return [self randomWordFromArray:self.possibleWords];
}

/*
 * Limit memory usage by trashing the dictionaryModel.
 */
- (void)memoryWarning {
    [self.dictionaryModel clean];
    self.dictionaryModel = nil;
}

/*
 * Detroys all objects
 */
- (void)clean
{
    [self.dictionaryModel clean];
    self.dictionaryModel = nil;
    
    self.currentState = nil;
    self.areLettersInWord = nil;
    self.possibleWords = nil;
}

@end
