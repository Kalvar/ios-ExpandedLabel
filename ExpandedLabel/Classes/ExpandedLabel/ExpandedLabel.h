//
//  ExpandedLabel.h
//  V1.1
//
//  Created by Kalvar on 13/6/27.
//  Copyright (c) 2013年 Kuo-Ming Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpandedLabel : UILabel
{
    CGFloat defaultHeight;
}

@property (nonatomic, assign) CGFloat defaultHeight;

-(float)getExpandedHeight;
-(void)autoExpandHeight;

@end
