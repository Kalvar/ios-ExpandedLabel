//
//  ExpandedLabel.m
//  ExpandedLabel
//
//  Created by Kalvar on 13/6/27.
//  Copyright (c) 2013年 Kuo-Ming Lin. All rights reserved.
//

#import "ExpandedLabel.h"

@interface ExpandedLabel ()

@end

@interface ExpandedLabel ( fixPrivate )

-(void)_fitsInfiniteExpanded;

@end

@implementation ExpandedLabel ( fixPrivate )

-(void)_fitsInfiniteExpanded
{
    [self setNumberOfLines:0];
}

@end

@implementation ExpandedLabel

@synthesize defaultHeight;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

#pragma --mark Methods
-(float)getExpandedHeight
{
    //必須給定一個固定的寬度，才能計算可變的高度
    CGSize size = [self.text sizeWithFont:self.font
                        constrainedToSize:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)
                            lineBreakMode:NSLineBreakByWordWrapping];
    return (CGFloat) MAX(size.height, self.defaultHeight);
}

-(void)autoExpandHeight
{
    [self _fitsInfiniteExpanded];
    CGRect _frame      = self.frame;
    _frame.size.height = [self getExpandedHeight];
    [self setFrame:_frame];
}

@end
