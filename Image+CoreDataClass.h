//
//  Image+CoreDataClass.h
//  ComicMe
//
//  Created by Stefan Verveniotis on 2016-11-29.
//  Copyright © 2016 Midterm Team. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import <CoreData/CoreData.h>
@import UIKit;

@class Layer, Story;

NS_ASSUME_NONNULL_BEGIN

@interface Image : NSManagedObject

@property (nonatomic) UIImage * baseUIImage;

- (void) wrap;
- (void) unwrap;

@end

NS_ASSUME_NONNULL_END

#import "Image+CoreDataProperties.h"
