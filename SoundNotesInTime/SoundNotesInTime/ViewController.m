//
//  ViewController.m
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 21/12/2017.
//  Copyright © 2017 dontgonearthecastle. All rights reserved.
//

#import "ViewController.h"
#import "../Pods/Masonry/Masonry/Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	UIView *brownView = UIView.new;
	brownView.backgroundColor = UIColor.brownColor;
	brownView.layer.borderColor = UIColor.blackColor.CGColor;
	brownView.layer.borderWidth = 2.0;
	[self.view addSubview:brownView];
	
	UIView *superview = self.view;
	
	[brownView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(superview.mas_top).offset(20.0);
		make.bottom.equalTo(superview.mas_bottom).offset(-20.0);
		make.left.equalTo(superview.mas_left).offset(20.0);
		make.right.equalTo(superview.mas_right).offset(-20.0);
	}];
}

@end
