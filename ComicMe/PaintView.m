//
//  PaintView.m
//  ComicMe
//
//  Created by Stefan Verveniotis on 2016-11-29.
//  Copyright © 2016 Midterm Team. All rights reserved.
//

#import "PaintView.h"

@implementation PaintView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _gestureCollection = [NSMutableArray new];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    if (self.undo) {
        for (FingerPaintGesture *fPG in self.gestureCollection) {
            CGContextSetStrokeColorWithColor(ctx, fPG.brushColour.CGColor);
            CGContextSetLineWidth(ctx, fPG.brushSize);
            CGContextMoveToPoint(ctx, [fPG.gestureArray[0] CGPointValue].x, [fPG.gestureArray[0] CGPointValue].y);
            for (NSValue *point in fPG.gestureArray) {
                CGPoint cGpoint = point.CGPointValue;
                CGContextAddLineToPoint(ctx, cGpoint.x, cGpoint.y);
            }
            CGContextStrokePath(ctx);
        }
    } else {
        FingerPaintGesture *fPG = [FingerPaintGesture new];
        [self.currentImage drawInRect:self.bounds];
        if (self.gestureCollection.count > 0) {
            fPG = self.gestureCollection[self.gestureCollection.count - 1];
            CGContextSetStrokeColorWithColor(ctx, fPG.brushColour.CGColor);
            CGContextSetLineWidth(ctx, fPG.brushSize);
            CGContextMoveToPoint(ctx, [fPG.gestureArray[0] CGPointValue].x, [fPG.gestureArray[0] CGPointValue].y);
            for (NSValue *point in fPG.gestureArray) {
                CGPoint cGpoint = point.CGPointValue;
                CGContextAddLineToPoint(ctx, cGpoint.x, cGpoint.y);
            }
        }
        CGContextStrokePath(ctx);
    }
    self.undo = NO;
}


@end

