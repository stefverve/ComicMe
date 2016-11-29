//
//  Story+CoreDataProperties.m
//  ComicMe
//
//  Created by Stefan Verveniotis on 2016-11-29.
//  Copyright © 2016 Midterm Team. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Story+CoreDataProperties.h"

@implementation Story (CoreDataProperties)

+ (NSFetchRequest<Story *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Story"];
}

@dynamic timestamp;
@dynamic images;

@end
