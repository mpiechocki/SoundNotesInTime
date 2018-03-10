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
#import "MetronomeSectionController.h"
#import "RecordingSectionController.h"
#import "LibrarySectionController.h"

@interface ViewController () <IGListAdapterDataSource, RecordingSectionControllerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) IGListAdapter *adapter;
@property NSArray<SectionTypeDescriptor *> *sections;
@property NSMutableArray<NSString *> *filenames;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	UIView *superview = self.view;
	
	[self setupExistingRecordingsFilenames];
	
	[self reloadSections];

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
}

-(void) setupExistingRecordingsFilenames {
	NSArray<NSURL *> *existingUrls = [self getExistingRecordingsUrls];
	self.filenames = nil;
	self.filenames = NSMutableArray.new;
	if (existingUrls) {
		for (NSURL *url in existingUrls) {
			[self.filenames addObject:[url.absoluteString lastPathComponent]];
		}
	}
}

-(NSArray<NSURL *> *) getExistingRecordingsUrls {
	NSURL *documentsDirectory = [[NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
	if (documentsDirectory) {
		return [NSFileManager.defaultManager contentsOfDirectoryAtURL:documentsDirectory includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsSubdirectoryDescendants error:nil];
	}
	return nil;
}

-(void) reloadSections {
	SectionTypeDescriptor *librarySection = [[SectionTypeDescriptor alloc] initWithType:Library];
	librarySection.filenames = self.filenames;
	self.sections = @[
					  [[SectionTypeDescriptor alloc] initWithType:Meronome],
					  [[SectionTypeDescriptor alloc] initWithType:Recording],
					  librarySection
					  ];
	[_adapter performUpdatesAnimated:YES completion:nil];
}

#pragma mark - IGListAdapterDataSource

- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
	return self.sections;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
	SectionTypeDescriptor *item = (SectionTypeDescriptor *) object;
	if (item == NULL) return IGListSectionController.new;
	
	switch (item.type) {
		case Meronome:
			return MetronomeSectionController.new;
		case Recording: {
			RecordingSectionController *controller = RecordingSectionController.new;
			controller.delegate = self;
			return controller;
		}
		case Library: {
			LibrarySectionController *controller = [[LibrarySectionController alloc] initWithFilenames: self.filenames];
			return controller;
		}
	}
}

- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
	return nil;
}

- (void)setupAudioSession
{
	NSError *error = nil;
	AVAudioSession *session = [AVAudioSession sharedInstance];
	[session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
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

#pragma mark - AVAudioSession Notifications
// see https://developer.apple.com/library/content/qa/qa1749/_index.html
- (void)handleMediaServicesWereReset:(NSNotification *)notification
{
	NSError *error = nil;
	[[AVAudioSession sharedInstance] setActive:YES error:&error];
	if(error) {
		NSLog(@"AVAudioSession error %ld, %@", error.code, error.localizedDescription);
	}
}

#pragma mark - RecordingSectionControllerDelegate
-(void)recordStopped:(NSURL *)newFileUrl {
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Enter filename"
																   message:@"Please enter file name for your recording"
															preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *submit = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
		if (alert.textFields.count > 0) {
			UITextField *textField = [alert.textFields firstObject];
			NSString *newNamedUrlDirectoryString = [newFileUrl.absoluteString stringByDeletingLastPathComponent];
			NSMutableString *newNamedUrlString = [newNamedUrlDirectoryString mutableCopy];
			[newNamedUrlString appendString:@"/"];
			[newNamedUrlString appendString:textField.text];
			[newNamedUrlString appendString:@".m4a"];
			[NSURL URLWithString:newNamedUrlString];
			[NSFileManager.defaultManager moveItemAtURL:newFileUrl toURL:[NSURL URLWithString:newNamedUrlString] error:nil];
			[self setupExistingRecordingsFilenames];
			[self reloadSections];
		}
	}];
	[alert addAction:submit];
	[alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
		textField.placeholder = @"My new recording";
	}];
	
	[self presentViewController:alert animated:YES completion:nil];
}

@end
