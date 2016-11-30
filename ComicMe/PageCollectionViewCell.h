//
//  PageCollectionViewCell.h
//  ComicMe
//
//  Created by Erin Luu on 2016-11-30.
//  Copyright © 2016 Midterm Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *pageLabel;
@end
