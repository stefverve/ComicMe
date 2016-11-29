//
//  StoryManager.h
//  ComicMe
//
//  Created by Stefan Verveniotis on 2016-11-28.
//  Copyright © 2016 Midterm Team. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Story+CoreDataClass.h"
#import "Image+CoreDataClass.h"
#import "Layer+CoreDataClass.h"
#import "AppDelegate.h"

@interface StoryManager : NSObject {NSMutableArray * stories;}

@property (nonatomic) NSManagedObjectContext * context;
@property (nonatomic, retain) NSMutableArray <Story *> * stories;

+ (id) sharedManager;
- (Story *) createNewStory;

@end
