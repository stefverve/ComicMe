//
//  StoryManager.m
//  ComicMe
//
//  Created by Stefan Verveniotis on 2016-11-28.
//  Copyright © 2016 Midterm Team. All rights reserved.
//

#import "StoryManager.h"
#import "Story+CoreDataClass.h"
#import "Image+CoreDataClass.h"
#import "Layer+CoreDataClass.h"
#import "AppDelegate.h"

@interface StoryManager ()

@property (nonatomic, strong) Story * currentStory;

@end

@implementation StoryManager

@synthesize stories;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static StoryManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (id)init {
    if (self = [super init]) {
        stories = [NSMutableArray new];
    }
    return self;
}



@end
