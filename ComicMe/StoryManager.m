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
@property (nonatomic, strong) Layer * currentLayer;
@end

@implementation StoryManager
//r@synthesize stories;

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
- (Layer*) createNewLayer {
    NSEntityDescription *layerEntity = [NSEntityDescription entityForName:@"Layer" inManagedObjectContext:self.context];
    self.currentLayer = [[Layer alloc] initWithEntity:layerEntity insertIntoManagedObjectContext:self.context];
    NSMutableSet *layers = [self.currentImage valueForKey:@"layers"];
    [layers addObject:self.currentLayer];
    return self.currentLayer;
}

-(void) saveCoreData {
    NSError * error = nil;
    [self.context save:&error];
    if (error) {NSLog(@"Error with core data save: %@", error.localizedDescription);}
}

#pragma mark - Story Methods
- (void) createNewStory {
    //Create story with date
    self.currentStory = [NSEntityDescription insertNewObjectForEntityForName:@"Story" inManagedObjectContext:self.context];
    self.currentStory.timestamp = [NSDate date];
    //Create new image
    self.currentImage = [NSEntityDescription insertNewObjectForEntityForName:@"Image" inManagedObjectContext:self.context];
    NSOrderedSet *imageSet = [NSOrderedSet orderedSetWithArray:@[self.currentImage]];
    self.currentStory.images = imageSet;
    [self saveCoreData];
}

- (void) getStoryCollection {
    //Fetch all stories
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Story" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    
    //Error check and storage
    NSError *error;
    self.storyCollection = [self.context executeFetchRequest:fetchRequest error:&error];
    if (error) {NSLog(@"Error with story fetch: %@", error.localizedDescription);}
}

#pragma mark - Image Methods
-(void) setUIImage: (UIImage *) image {
    self.currentImage.baseImage = UIImagePNGRepresentation(image);
    [self saveCoreData];
}

-(UIImage*) getUIImage: (NSInteger) index {
    Story * story = self.storyCollection[index];
    Image * image = story.images[0];
    UIImage * compiledImage = [UIImage imageWithData:image.baseImage];
    return compiledImage;
}

@end
