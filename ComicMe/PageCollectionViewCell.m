//
//  PageCollectionViewCell.m
//  ComicMe
//
//  Created by Erin Luu on 2016-11-30.
//  Copyright © 2016 Midterm Team. All rights reserved.
//

#import "PageCollectionViewCell.h"

@implementation PageCollectionViewCell

- (void) prepareForReuse {
    self.imageView.image = nil;
    self.pageLabel.text = @"";
}

@end
