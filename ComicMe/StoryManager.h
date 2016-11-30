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
@property (nonatomic, retain) NSArray <Story *> * storyCollection;
@property (nonatomic, strong) Story * currentStory;
@property (nonatomic, strong) Image * currentImage;

//Image Methods
-(void) setUIImage: (UIImage *) image;
-(UIImage*) getUIImage: (NSInteger) index;

//Story Methods
- (void) createNewStory;
- (void) getStoryCollection;

+ (id) sharedManager;
- (Layer *) createNewLayer;

@end
