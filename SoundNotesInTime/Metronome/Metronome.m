//
//  Metronome.m
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 11/01/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#import "Metronome.h"

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#import "TriangleGenerator.h"

static Float32 kBipDurationSeconds = 0.020;
static Float32 kTempoChangeResponsivenessSeconds = 0.250;

@interface Metronome () {
	AVAudioEngine *engine;
	AVAudioPlayerNode *player;
	NSArray<AVAudioPCMBuffer *> *soundBuffer;
	int bufferNumber;
	Float64 bufferSampleRate;
	Float32 tempoBPM;
	int beatNumber;
	Float64 nextBeatSampleTime;
	int beatsToScheduleAhead;
	int beatsScheduled;
	BOOL isPlaying;
	BOOL playerStarted;
	
	dispatch_queue_t syncQueue;
}
@end

@implementation Metronome

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self setup];
	}
	return self;
}

- (void) setup {
	engine = AVAudioEngine.new;
	player = AVAudioPlayerNode.new;
	
	AVAudioFormat *format = [[AVAudioFormat alloc] initStandardFormatWithSampleRate:44100.0 channels:2];
	UInt32 bipFrames = kBipDurationSeconds * format.sampleRate;
	soundBuffer = @[[[AVAudioPCMBuffer alloc] initWithPCMFormat:format frameCapacity:bipFrames],
					[[AVAudioPCMBuffer alloc] initWithPCMFormat:format frameCapacity:bipFrames],
					];
	soundBuffer[0].frameLength = bipFrames;
	soundBuffer[1].frameLength = bipFrames;
	
	TriangleGenerator *generator1 = [[TriangleGenerator alloc] initWithSampleRate:format.sampleRate];
	TriangleGenerator *generator2 = [[TriangleGenerator alloc] initWithSampleRate:format.sampleRate frequency:261.6];
	[generator1 renderBuffer:soundBuffer[0]];
	[generator2 renderBuffer:soundBuffer[1]];
	
	AVAudioOutputNode *output = engine.outputNode;
	[engine attachNode:player];
	[engine connect:player to:output format:format];
	
	bufferSampleRate = format.sampleRate;
	
	const char *queueLabel = [@"Metronome" UTF8String];
	syncQueue = dispatch_queue_create(queueLabel, NULL);
	
	[self setTempo:120.0];
}

- (void)dealloc
{
	[self stop];
	[engine detachNode:player];
}

- (void) scheduleBeats {
	if (isPlaying) return;
}

- (BOOL) start {
	if (![engine startAndReturnError:nil]) return false;
	
	isPlaying = true;
	nextBeatSampleTime = 0;
	beatNumber = 0;
	bufferNumber = 0;
	
	dispatch_sync(syncQueue, ^{
		[self scheduleBeats];
	});
	
	return true;
}

- (void) stop {
	isPlaying = false;
	[player stop];
	[player reset];
	[engine stop];
	playerStarted = false;
}

- (void) setTempo: (Float32)tempo {
	tempoBPM = tempo;
	Float32 secondsPerBeat = 60.0 / tempoBPM;
	beatsToScheduleAhead = kTempoChangeResponsivenessSeconds / secondsPerBeat;
	if (beatsToScheduleAhead < 1) beatsToScheduleAhead = 1;
}

@end
