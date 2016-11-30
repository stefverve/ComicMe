//
//  Story+CoreDataClass.h
//  ComicMe
//
//  Created by Stefan Verveniotis on 2016-11-29.
//  Copyright © 2016 Midterm Team. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image;

NS_ASSUME_NONNULL_BEGIN

@interface Story : NSManagedObject

//@property (nonatomic) NSDate * timeStamp;

- (void) wrap;
- (void) unwrap;

@end

NS_ASSUME_NONNULL_END

#import "Story+CoreDataProperties.h"
