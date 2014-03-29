//
//  ExpandedLabel.m
//  V1.2
//
//  Created by Kalvar on 13/6/27.
//  Copyright (c) 2013 - 2014 年 Kuo-Ming Lin. All rights reserved.
//

#import "ExpandedLabel.h"

@interface ExpandedLabel ()

@property (nonatomic, assign) BOOL _isWidthMode;

@end

@interface ExpandedLabel ( fixPrivate )

-(void)_fitsInfiniteExpanded;
-(BOOL)_isIOS7;
-(CGSize)_calculateForIOS7;
-(CGSize)_calculateForIOS6;

@end

@implementation ExpandedLabel ( fixPrivate )

-(void)_fitsInfiniteExpanded
{
    [self setNumberOfLines:0];
}

-(BOOL)_isIOS7
{
    return ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f);
}

-(CGSize)_calculateForIOS7
{
    UIFont *_textFont = self.font;
    if( !_textFont )
    {
        _textFont = [UIFont systemFontOfSize:17.0f];
    }
    NSString *_text   = self.text;
    CGSize _scopeSize = self._isWidthMode ? CGSizeMake(CGFLOAT_MAX, self.frame.size.height) : CGSizeMake(self.frame.size.width, CGFLOAT_MAX);
    //將字串格式化為屬性字串
    //NSAttributedString *_attributedString = [[NSAttributedString alloc] initWithString:_text];
    //可以這麼用
    //self.outTextView.attributedText = _attributedString;
    //取得文字的最大範圍
    //NSRange range = NSMakeRange(0, _attributedString.length);
    //取得字串屬性集合
    //NSDictionary *_textAttributes = [attrStr attributesAtIndex:0 effectiveRange:&range];
    
    NSDictionary *_textAttributes = @{NSFontAttributeName:_textFont};
    //NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
    //NSStringDrawingUsesFontLeading 為計算行高時，同時參考使用行距為計算標準( 行距 = 字體大小 + 行間距 )
    CGSize _size = [_text boundingRectWithSize:_scopeSize //用於計算限制字串繪製時所佔據的矩形塊呎吋
                                       options:NSStringDrawingUsesLineFragmentOrigin //字串繪製時的附加計算選項
                                    attributes:_textAttributes        //文字的屬性
                                       context:nil].size; //包含如何調整字間距與縮放，可為 nil
    //一定要進位，否則會出問題
    return CGSizeMake( ceilf(_size.width) , ceil(_size.height));
}

-(CGSize)_calculateForIOS6
{
    //必須給定一個固定的寬度，才能計算可變的高度
    CGSize _toSize = self._isWidthMode ? CGSizeMake(CGFLOAT_MAX, self.frame.size.height) : CGSizeMake(self.frame.size.width, CGFLOAT_MAX);
    CGSize size = [self.text sizeWithFont:self.font
                        constrainedToSize:_toSize
                            lineBreakMode:NSLineBreakByWordWrapping];
    return size;
}

@end

@implementation ExpandedLabel

@synthesize defaultHeight = _defaultHeight;
@synthesize defaultWidth  = _defaultWidth;

+(instancetype)sharedLabel
{
    static dispatch_once_t pred;
    static ExpandedLabel *_object = nil;
    dispatch_once(&pred, ^{
        _object = [[ExpandedLabel alloc] init];
    });
    return _object;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _defaultHeight = CGFLOAT_MIN;
        _defaultWidth  = CGFLOAT_MAX;
    }
    return self;
}

#pragma --mark Public Methods
-(float)getExpandedHeight
{
    self._isWidthMode = NO;
    CGSize size = [self _isIOS7] ? [self _calculateForIOS7] : [self _calculateForIOS6];
    return (CGFloat) MAX(size.height, _defaultHeight);
}

-(float)getExpandedWidth
{
    self._isWidthMode = YES;
    CGSize size = [self _isIOS7] ? [self _calculateForIOS7] : [self _calculateForIOS6];
    return (CGFloat) MIN(size.width, _defaultWidth);
}

-(void)autoExpandHeight
{
    self._isWidthMode = NO;
    [self _fitsInfiniteExpanded];
    CGRect _frame      = self.frame;
    _frame.size.height = [self getExpandedHeight];
    [self setFrame:_frame];
}

-(void)autoExpandWidth
{
    self._isWidthMode = YES;
    [self _fitsInfiniteExpanded];
    CGRect _frame      = self.frame;
    _frame.size.width  = [self getExpandedWidth];
    [self setFrame:_frame];
}

@end
