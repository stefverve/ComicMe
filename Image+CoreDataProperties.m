//
//  Image+CoreDataProperties.m
//  ComicMe
//
//  Created by Stefan Verveniotis on 2016-11-29.
//  Copyright © 2016 Midterm Team. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Image+CoreDataProperties.h"

@implementation Image (CoreDataProperties)

+ (NSFetchRequest<Image *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Image"];
}

@dynamic baseImage;
@dynamic story;
@dynamic layers;

@end
