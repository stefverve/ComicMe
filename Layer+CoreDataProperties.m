//
//  Layer+CoreDataProperties.m
//  ComicMe
//
//  Created by Stefan Verveniotis on 2016-11-29.
//  Copyright © 2016 Midterm Team. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Layer+CoreDataProperties.h"

@implementation Layer (CoreDataProperties)

+ (NSFetchRequest<Layer *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Layer"];
}

@dynamic layerImage;
@dynamic x;
@dynamic y;
@dynamic width;
@dynamic height;
@dynamic image;

@end
