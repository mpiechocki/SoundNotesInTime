//
//  LibraryCell.m
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 11/01/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#import "LibraryCell.h"

#import <Masonry.h>

@implementation LibraryCell {
	UITableView *tableView;
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
	tableView = UITableView.new;
	[self.contentView addSubview:tableView];
	[tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(tableView.superview);
	}];
}

@end
