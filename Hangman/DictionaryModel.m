//
//  DictionaryModel.m
//  Hangman
//
//  Created by Emiel on 12/4/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//

#import "DictionaryModel.h"

@implementation DictionaryModel
@synthesize wordlist = _wordlist;

- (NSArray *)wordlist {
    if (_wordlist == nil) {
        [self loadDictionary];
    }
    return _wordlist;
}

- (void)loadDictionary {
    NSString *path = [[NSBundle mainBundle]pathForResource:@"words" ofType:@"plist"];
    self.wordlist = [NSArray arrayWithContentsOfFile:path];
}

- (void)clean {
    self.wordlist = nil;
}

@end
