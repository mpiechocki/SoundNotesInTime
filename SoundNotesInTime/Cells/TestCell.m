//
//  TestCell.m
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 22/12/2017.
//  Copyright © 2017 dontgonearthecastle. All rights reserved.
//

#import "TestCell.h"

#import <Masonry/Masonry.h>

@interface TestCell ()
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation TestCell

- (instancetype)init {
	if(self = [super init]) {
		[self setupSubviews];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
	if(self = [super initWithFrame:frame]) {
		[self setupSubviews];
	}
	return self;
}

- (void) setupSubviews {
	self.textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	[self.contentView addSubview: self.textLabel];
	[self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.textLabel.superview);
	}];
	self.textLabel.textAlignment = NSTextAlignmentCenter;
}

- (void) setText:(NSString *)text {
	[self.textLabel setText:text];
}

@end
