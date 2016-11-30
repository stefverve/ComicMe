//
//  PaintView.h
//  ComicMe
//
//  Created by Stefan Verveniotis on 2016-11-29.
//  Copyright © 2016 Midterm Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FingerPaintGesture.h"

@interface PaintView : UIView

@property (nonatomic) NSMutableArray <FingerPaintGesture*> * gestureCollection;
@property (nonatomic) BOOL undo;
@property (nonatomic) UIImage * currentImage;

- (void)drawRect:(CGRect)rect;

@end
