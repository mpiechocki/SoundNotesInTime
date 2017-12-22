//
//  ViewController.m
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 21/12/2017.
//  Copyright © 2017 dontgonearthecastle. All rights reserved.
//

#import "ViewController.h"
#import <IGListKit/IGListKit.h>
#import <Masonry/Masonry.h>

#import "TestSectionController.h"

@interface ViewController () <IGListAdapterDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) IGListAdapter *adapter;
@property NSArray<NSString *> *items;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	UIView *superview = self.view;
	
	self.items = @[
				   @"QWERTY",
				   @"ASDFGH",
				   @"ZXCVBN",
				   @"MIKO",
				   @"Miko",
				   @"q",
				   @"w",
				   @"e",
				   @"r",
				   @"t",
				   ];

	self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
											 collectionViewLayout:[UICollectionViewFlowLayout new]];
	self.collectionView.backgroundColor = UIColor.redColor;
	[self.view addSubview:self.collectionView];
	[self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(superview);
	}];
	
	self.adapter = [[IGListAdapter alloc] initWithUpdater:IGListAdapterUpdater.new
										   viewController:self];
	self.adapter.collectionView = self.collectionView;
	self.adapter.dataSource = self;
}

#pragma mark - IGListAdapterDataSource

- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
	return self.items;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
	return [TestSectionController new];
}

- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
	return nil;
}

@end
