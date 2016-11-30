//
//  FingerPaintGesture.h
//  ComicMe
//
//  Created by Stefan Verveniotis on 2016-11-29.
//  Copyright © 2016 Midterm Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FingerPaintGesture : NSObject

@property NSMutableArray <NSValue *> * gestureArray;
@property NSInteger brushSize;
@property UIColor * brushColour;

@end
