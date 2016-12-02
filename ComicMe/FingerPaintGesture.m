//
//  FingerPaintGesture.m
//  ComicMe
//
//  Created by Stefan Verveniotis on 2016-11-29.
//  Copyright © 2016 Midterm Team. All rights reserved.
//

#import "FingerPaintGesture.h"

@implementation FingerPaintGesture

- (instancetype)init
{
    self = [super init];
    if (self) {
        _gestureArray = [NSMutableArray new];
        _brushSize = 10;
        _brushColour = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1];
    }
    return self;
}

@end
