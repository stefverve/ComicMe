//
//  Layer+CoreDataProperties.h
//  ComicMe
//
//  Created by Stefan Verveniotis on 2016-11-29.
//  Copyright © 2016 Midterm Team. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Layer+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Layer (CoreDataProperties)

+ (NSFetchRequest<Layer *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSData *layerImage;
@property (nonatomic) float x;
@property (nonatomic) float y;
@property (nonatomic) float width;
@property (nonatomic) float height;
@property (nullable, nonatomic, retain) Image *image;

@end

NS_ASSUME_NONNULL_END
