//
//  ExpandedLabel.h
//  V1.2
//
//  Created by Kalvar on 13/6/27.
//  Copyright (c) 2013 - 2014 年 Kuo-Ming Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpandedLabel : UILabel
{
    CGFloat defaultHeight;
    CGFloat defaultWidth;
}

@property (nonatomic, assign) CGFloat defaultHeight;
@property (nonatomic, assign) CGFloat defaultWidth;

+(instancetype)sharedLabel;
-(float)getExpandedHeight;
-(float)getExpandedWidth;
-(void)autoExpandHeight;
-(void)autoExpandWidth;

@end
