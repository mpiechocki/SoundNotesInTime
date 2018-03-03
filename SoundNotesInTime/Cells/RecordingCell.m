//
//  RecordingCell.m
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 11/01/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#import "RecordingCell.h"

#import <Masonry.h>

@implementation RecordingCell {
	UIButton *recordButton;
}

- (instancetype)init {
	self = [super init];
	if (self) {
		[self setupSubviews];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self setupSubviews];
	}
	return self;
}

- (void)setupSubviews {
	recordButton = UIButton.new;
	
	recordButton.titleLabel.textAlignment = NSTextAlignmentCenter;
	[recordButton setTitle:@"RECORD" forState:UIControlStateNormal];
	[recordButton setTitleColor:UIColor.redColor forState:UIControlStateNormal];
	[recordButton setTitle:@"STOP" forState:UIControlStateSelected];
	[recordButton setTitleColor:UIColor.redColor forState:UIControlStateSelected];
	[recordButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
	
	[self.contentView addSubview:recordButton];
	UIEdgeInsets padding = UIEdgeInsetsMake(5.0, 20.0, 5.0, 20.0);
	[recordButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(recordButton.superview).with.insets(padding);
	}];
}

- (void) clicked:(UIButton *)sender {
	recordButton.selected = !recordButton.isSelected;
	[_delegate recordClicked:recordButton.isSelected];
}
@end
