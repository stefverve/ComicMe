//
//  Image+CoreDataProperties.h
//  ComicMe
//
//  Created by Stefan Verveniotis on 2016-11-29.
//  Copyright © 2016 Midterm Team. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Image+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Image (CoreDataProperties)

+ (NSFetchRequest<Image *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSData *baseImage;
@property (nullable, nonatomic, retain) Story *story;
@property (nullable, nonatomic, retain) NSOrderedSet<Layer *> *layers;

@end

@interface Image (CoreDataGeneratedAccessors)

- (void)insertObject:(Layer *)value inLayersAtIndex:(NSUInteger)idx;
- (void)removeObjectFromLayersAtIndex:(NSUInteger)idx;
- (void)insertLayers:(NSArray<Layer *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeLayersAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInLayersAtIndex:(NSUInteger)idx withObject:(Layer *)value;
- (void)replaceLayersAtIndexes:(NSIndexSet *)indexes withLayers:(NSArray<Layer *> *)values;
- (void)addLayersObject:(Layer *)value;
- (void)removeLayersObject:(Layer *)value;
- (void)addLayers:(NSOrderedSet<Layer *> *)values;
- (void)removeLayers:(NSOrderedSet<Layer *> *)values;

@end

NS_ASSUME_NONNULL_END
