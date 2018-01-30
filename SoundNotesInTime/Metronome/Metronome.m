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
	
	TriangleGenerator *generator1 = [[TriangleGenerator alloc] initWithSampleRate:format.sampleRate frequency:440.0 amplitude:0.5];
	TriangleGenerator *generator2 = [[TriangleGenerator alloc] initWithSampleRate:format.sampleRate frequency:261.6 amplitude:0.5];
	[generator1 renderBuffer:soundBuffer[0]];
	[generator2 renderBuffer:soundBuffer[1]];
	
	AVAudioOutputNode *output = engine.outputNode;
	[engine attachNode:player];
	[engine connect:player to:output format:format];
	
	bufferSampleRate = format.sampleRate;
	
	const char *queueLabel = [@"Metronome" UTF8String];
	syncQueue = dispatch_queue_create(queueLabel, NULL);
	
	[self setTempo:220.0];
}

- (void)dealloc
{
	[self stop];
	[engine detachNode:player];
}

- (void)scheduleBeats {
	if (!isPlaying) return;
	
	while (beatsScheduled < beatsToScheduleAhead) {
		// Schedule the beat.
		
		float secondsPerBeat = 60.0f / tempoBPM;
		float samplesPerBeat = (float)(secondsPerBeat * bufferSampleRate);
		AVAudioFramePosition beatSampleTime = (AVAudioFramePosition) nextBeatSampleTime;
		AVAudioTime *playerBeatTime = [AVAudioTime timeWithSampleTime: beatSampleTime atRate: bufferSampleRate];
		// This time is relative to the player's start time.
		
		[player scheduleBuffer:soundBuffer[bufferNumber] atTime:playerBeatTime options:0 completionHandler:^{
			dispatch_sync(syncQueue, ^{
				beatsScheduled -= 1;
				bufferNumber ^= 1;
				[self scheduleBeats];
			});
		}];
		
		beatsScheduled += 1;
		
		if (!playerStarted) {
			// We defer the starting of the player so that the first beat will play precisely
			// at player time 0. Having scheduled the first beat, we need the player to be running
			// in order for nodeTimeForPlayerTime to return a non-nil value.
			[player play];
			playerStarted = YES;
		}
		
		// Schedule the delegate callback (metronomeTicking:bar:beat:) if necessary.
		if (_delegate && [_delegate respondsToSelector: @selector(tick)]) {
			AVAudioTime *nodeBeatTime = [player nodeTimeForPlayerTime: playerBeatTime];
			
			AVAudioIONode *output = engine.outputNode;
			
			//NSLog(@"%@ %@ %.6f", playerBeatTime, nodeBeatTime, output.presentationLatency);
			uint64_t latencyHostTicks = [AVAudioTime hostTimeForSeconds: output.presentationLatency];
			dispatch_after(dispatch_time(nodeBeatTime.hostTime + latencyHostTicks, 0), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
				// hardcoded to 4/4 meter
				if (isPlaying)
					[_delegate tick];
			});
		}
		
		nextBeatSampleTime += samplesPerBeat;
	}
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
