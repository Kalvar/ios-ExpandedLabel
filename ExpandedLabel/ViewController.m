//
//  ViewController.m
//  ExpandedLabel
//
//  Created by Kalvar on 13/6/27.
//  Copyright (c) 2013年 Kuo-Ming Lin. All rights reserved.
//

#import "ViewController.h"
#import "ExpandedLabel.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize expandedLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.expandedLabel.text = @"Hello\nApps\nWorld\nLaLa\n";
    [self.expandedLabel autoExpandHeight];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
