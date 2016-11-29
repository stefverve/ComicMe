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
@property (nonatomic, strong) Image * currentImage;
@property (nonatomic, strong) Layer * currentLayer;
@property (nonatomic) NSArray * storyCollection;
@end

@implementation StoryManager
@synthesize stories;

#pragma mark - Singleton Methods
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

#pragma mark - Core Data Handling
- (Story *) createNewStory {
    //Create story with date
    NSEntityDescription *storyEntity = [NSEntityDescription entityForName:@"Story" inManagedObjectContext:self.context];
    self.currentStory = [[Story alloc] initWithEntity:storyEntity insertIntoManagedObjectContext:self.context];
    NSDate * currentDate = [NSDate date];
    self.currentStory.timestamp = currentDate;
    
    //Create new image
    NSEntityDescription *imageEntity = [NSEntityDescription entityForName:@"Image" inManagedObjectContext:self.context];
    self.currentImage = [[Image alloc] initWithEntity:imageEntity insertIntoManagedObjectContext:self.context];
    
    //Get set of images for story and add in the new image
    [self.currentImage setValue:self.currentStory forKeyPath:@"story"];
    
    [self saveCoreData];
    return self.currentStory;
}

- (Layer*) createNewLayer {
    NSEntityDescription *layerEntity = [NSEntityDescription entityForName:@"Layer" inManagedObjectContext:self.context];
    self.currentLayer = [[Layer alloc] initWithEntity:layerEntity insertIntoManagedObjectContext:self.context];
    NSMutableSet *layers = [self.currentImage valueForKey:@"layers"];
    [layers addObject:self.currentLayer];
    self.currentLayer.x = 2;
    self.currentLayer.y = 3;
    self.currentLayer.width = 4;
    self.currentLayer.height = 5;
    [self saveCoreData];

    return self.currentLayer;
}

- (NSArray *) getStoryCollection {
    //Fetch all stories
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Story" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    
    //Error check and storage
    NSError *error;
    self.storyCollection = [self.context executeFetchRequest:fetchRequest error:&error];
    if (error) {NSLog(@"Error with story fetch: %@", error.localizedDescription);}
    return self.storyCollection;
}

//-(void) getImageCollection: (Story*) story{
//}

//-(void) getLayerCollection: (Image*) image{
//}

-(void) saveCoreData {
    NSError * error = nil;
    [self.context save:&error];
    if (error) {NSLog(@"Error with core data save: %@", error.localizedDescription);}
}

@end
