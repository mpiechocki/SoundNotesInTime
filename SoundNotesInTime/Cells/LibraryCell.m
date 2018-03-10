//
//  LibraryCell.m
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 11/01/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#import "LibraryCell.h"

#import <Masonry.h>
#import <UIKit/UIKit.h>

#import "MyRecorder.h"

@interface LibraryCell () <UITableViewDataSource, UITableViewDelegate>
@end

@implementation LibraryCell {
	UITableView *tableView;
}

static NSString* cellIdentifier = @"LibraryTableViewCell";

-(instancetype)init {
	self = [super init];
	if (self) {
		[self setupSubviews];
	}
	return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self setupSubviews];
	}
	return self;
}

-(void)setupSubviews {
	tableView = UITableView.new;
	[self.contentView addSubview:tableView];
	[tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(tableView.superview);
	}];
	tableView.delegate = self;
	tableView.dataSource = self;
}

-(void)setFilenames:(NSArray<NSString *> *)filenames {
	_filenames = filenames;
	[tableView reloadData];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
	NSString *filename = self.filenames[indexPath.row];
	[cell.textLabel setText:filename];
	return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section != 0) { return 0; }
	return self.filenames.count;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//	NSURL *url = [NSURL URLWithString: self.filenames[indexPath.row]];
	NSArray *pathComponents = [NSArray arrayWithObjects:
							   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
							   self.filenames[indexPath.row],
							   nil];
	NSURL *url = [NSURL fileURLWithPathComponents:pathComponents];
	if (url) {
		MyRecorder *myRecorder = MyRecorder.shared;
		[myRecorder playUrl:url];
	}
}

@end
