//
//  ViewController.m
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 21/12/2017.
//  Copyright © 2017 dontgonearthecastle. All rights reserved.
//

#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>

#import <IGListKit/IGListKit.h>
#import <Masonry/Masonry.h>

#import "SectionTypeDescriptor.h"
#import "TestSectionController.h"
#import "PlaybackSectionController.h"
#import "RecordingSectionController.h"
#import "LibrarySectionController.h"
#import "Metronome.h"

@interface ViewController () <IGListAdapterDataSource, MetronomeDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) IGListAdapter *adapter;
@property NSArray<SectionTypeDescriptor *> *sections;
@property Metronome *metronome;

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
	
	[self setupAudioSession];
	self.metronome = [[Metronome alloc] init];
	self.metronome.delegate = self;
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

- (void)setupAudioSession
{
	NSError *error = nil;
	AVAudioSession *session = [AVAudioSession sharedInstance];
	[session setCategory:AVAudioSessionCategoryAmbient error:&error];
	if(error) {
		NSLog(@"AVAudioSession error %ld, %@", error.code, error.localizedDescription);
	}
	[session setActive:true error:&error];
	if(error) {
		NSLog(@"AVAudioSession error %ld, %@", error.code, error.localizedDescription);
	}
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleMediaServicesWereReset:)
												 name:AVAudioSessionMediaServicesWereResetNotification
											   object:session];
}

#pragma mark- AVAudioSession Notifications
// see https://developer.apple.com/library/content/qa/qa1749/_index.html
- (void)handleMediaServicesWereReset:(NSNotification *)notification
{
	NSLog(@"Media services have reset...");
	
	// tear down
	self.metronome.delegate = nil;
	self.metronome = nil;
	
	// re-create
	self.metronome = [[Metronome alloc] init];
	self.metronome.delegate = self;
	
	NSError *error = nil;
	[[AVAudioSession sharedInstance] setActive:YES error:&error];
	if(error) {
		NSLog(@"AVAudioSession error %ld, %@", error.code, error.localizedDescription);
	}
}

#pragma mark- Metronome Delegate
- (void) tick
{
	NSLog(@"TICK");
}

@end
