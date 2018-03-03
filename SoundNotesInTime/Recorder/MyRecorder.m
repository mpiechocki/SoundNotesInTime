//
//  Recorder.m
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 03/03/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#import "MyRecorder.h"

#import <AVFoundation/AVFoundation.h>

@interface MyRecorder () <AVAudioPlayerDelegate, AVAudioRecorderDelegate> {
	AVAudioPlayer *player;
	AVAudioRecorder *recorder;
}
@end

@implementation MyRecorder

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self setup];
	}
	return self;
}

- (void) setup {
	NSArray *pathComponents = [NSArray arrayWithObjects:
							   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
							   @"MyAudioMemo2.m4a",
							   nil];
	NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
	
	NSMutableDictionary *recordSettings = NSMutableDictionary.new;
	[recordSettings setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
	[recordSettings setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
	[recordSettings setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
	
	recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSettings error:NULL];
	recorder.delegate = self;
	recorder.meteringEnabled = true;
	[recorder prepareToRecord];
}

-(void) record {
	[recorder record];
	NSLog(@"RECORDING");
}

-(void) stop {
	[recorder stop];
	NSLog(@"STOPPED RECORDING");
}

@end
