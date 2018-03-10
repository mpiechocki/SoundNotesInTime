//
//  Recorder.m
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 03/03/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#import "MyRecorder.h"

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

#import "Recording.h"

@interface MyRecorder () <AVAudioPlayerDelegate, AVAudioRecorderDelegate> {
	AVAudioPlayer *player;
	AVAudioRecorder *recorder;
	NSMutableDictionary *recordSettings;
}
@end

@implementation MyRecorder

+(instancetype) shared {
	static MyRecorder *sharedMyRecorder = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedMyRecorder = [[self alloc] init];
	});
	return sharedMyRecorder;
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self setup];
	}
	return self;
}

- (void) setup {
	recordSettings = NSMutableDictionary.new;
	[recordSettings setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
	[recordSettings setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
	[recordSettings setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
}

-(void) record {
	Recording *newRec = [[Recording alloc] initWithTitle:@"New Recording"];
	NSURL *outputFileURL = [self getFileNameUrlForRecording:newRec];
	self.lastFileUrl = outputFileURL;
	[self setupRecorderWithFileUrl:outputFileURL];
	if ([recorder prepareToRecord]) {
		[recorder record];
		NSLog(@"RECORDING");
	} else {
		NSLog(@"ERROR WHILE preparing to record");
	}
}

-(void) stop {
	[recorder stop];
}

-(void) playUrl:(NSURL *) url {
	if (!recorder.isRecording) {
		player = nil;
		player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
//		[player setDelegate:self];
		[player play];
	}
}

-(void) setupRecorderWithFileUrl:(NSURL *) url {
	recorder = nil;
	recorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSettings error:NULL];
	recorder.delegate = self;
	recorder.meteringEnabled = true;
}

-(NSURL *) getFileNameUrlForRecording:(Recording *)recording {
	NSArray *pathComponents = [NSArray arrayWithObjects:
							   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
							   recording.fileName,
							   nil];
	return [NSURL fileURLWithPathComponents:pathComponents];
}

@end
