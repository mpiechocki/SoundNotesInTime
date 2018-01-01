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

#import "SectionTypeDescriptor.h"

#import "TestSectionController.h"
#import "PlaybackSectionController.h"
#import "RecordingSectionController.h"
#import "LibrarySectionController.h"

@interface ViewController () <IGListAdapterDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) IGListAdapter *adapter;
@property NSArray<SectionTypeDescriptor *> *sections;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	UIView *superview = self.view;
	
	self.sections = @[
					  [[SectionTypeDescriptor alloc] initWithType:Playback],
					  [[SectionTypeDescriptor alloc] initWithType:Recording],
					  [[SectionTypeDescriptor alloc] initWithType:Library]
					  ];

	self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
											 collectionViewLayout:[UICollectionViewFlowLayout new]];
	self.collectionView.backgroundColor = UIColor.whiteColor;
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
	return self.sections;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
	SectionTypeDescriptor *item = (SectionTypeDescriptor *) object;
	if (item == NULL) return IGListSectionController.new;
	
	switch (item.type) {
		case Playback: return PlaybackSectionController.new;
		case Recording: return RecordingSectionController.new;
		case Library: return LibrarySectionController.new;
	}
}

- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
	return nil;
}

@end
