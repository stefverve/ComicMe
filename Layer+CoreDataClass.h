//
//  Layer+CoreDataClass.h
//  ComicMe
//
//  Created by Stefan Verveniotis on 2016-11-29.
//  Copyright © 2016 Midterm Team. All rights reserved.
//  This file was automatically generated and should not be edited.
//

//#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@import UIKit;

@class Image;

NS_ASSUME_NONNULL_BEGIN



@interface Layer : NSManagedObject

@property (nonatomic) CGRect * layerRect;
@property (nonatomic, strong) UIImage * layerImage;

- (void) wrap;
- (void) unwrap;

@end

NS_ASSUME_NONNULL_END

#import "Layer+CoreDataProperties.h"
