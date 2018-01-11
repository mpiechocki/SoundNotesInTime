//
//  PlaybackCell.m
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 11/01/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#import "PlaybackCell.h"

#import <Masonry.h>

@implementation PlaybackCell {
	UIButton *playButton;
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
	playButton = UIButton.new;
	
	playButton.titleLabel.textAlignment = NSTextAlignmentCenter;
	[playButton setTitle:@"PLAY" forState:UIControlStateNormal];
	[playButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
	[playButton setTitle:@"PAUSE" forState:UIControlStateSelected];
	[playButton setTitleColor:UIColor.grayColor forState:UIControlStateSelected];
	[playButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
	
	[self.contentView addSubview:playButton];
	UIEdgeInsets padding = UIEdgeInsetsMake(5.0, 20.0, 5.0, 20.0);
	[playButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(playButton.superview).with.insets(padding);
	}];
}

- (void) clicked:(UIButton *)sender {
	playButton.selected = !playButton.isSelected;
}

@end
