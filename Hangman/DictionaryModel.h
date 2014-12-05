//
//  DictionaryModel.h
//  Hangman
//
//  Created by Emiel on 12/4/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DictionaryModel : NSObject

@property (retain, readwrite, nonatomic) NSArray *wordlist;

- (void)loadDictionary;

- (void)clean;

@end
