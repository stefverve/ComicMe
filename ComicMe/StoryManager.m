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
//@synthesize stories;

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

#pragma mark - Core Data
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
    Image * secondImage = [NSEntityDescription insertNewObjectForEntityForName:@"Image" inManagedObjectContext:self.context];
    NSOrderedSet *imageSet = [NSOrderedSet orderedSetWithArray:@[self.currentImage, secondImage]];
    self.currentStory.images = imageSet;
    [self saveCoreData];
    self.imageCollection = self.currentStory.images;
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

-(UIImage*) getUIImageForStory:(Story*) story  page: (NSInteger) index {
    Image * image = story.images[index];
    UIImage * compiledImage = [UIImage imageWithData:image.baseImage];
    return compiledImage;
}

-(UIImage*) getCurrentUIImage: (Image *) image {
    UIImage * compiledImage = [UIImage imageWithData:image.baseImage];
    return compiledImage;
}

-(void) addNewImage {
    Image * newImage = [NSEntityDescription insertNewObjectForEntityForName:@"Image" inManagedObjectContext:self.context];
    NSMutableOrderedSet *set = (NSMutableOrderedSet *)self.currentStory.images.mutableCopy;
    if (set.count < 6) {
        [set addObject:newImage];
        self.currentStory.images = (NSOrderedSet *)set.copy;
        [self saveCoreData];
        self.imageCollection = self.currentStory.images;
    }

}

-(void) changeCurrentImage: (NSInteger) index {
    self.currentImage = self.currentStory.images[index];
}

#pragma mark - Layer Methods
- (void) createNewLayer {
    Layer * newLayer = [NSEntityDescription insertNewObjectForEntityForName:@"Layer" inManagedObjectContext:self.context];
    NSOrderedSet *layerSet = [NSOrderedSet orderedSetWithArray:@[newLayer]];
    self.currentImage.layers = layerSet;
    [self saveCoreData];
}
@end
