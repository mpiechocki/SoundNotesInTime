//
//  TriangleGenerator.m
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 26/01/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#import "TriangleGenerator.h"

@interface TriangleGenerator () {
	Float32 sampleRate;
	Float32 freqHz;
	Float32 amplitude;
	Float32 frameCount;
}
@end

@implementation TriangleGenerator

- (void)setupWithSampleRate:(Float32)withSampleRate frequency:(Float32)withFrequency amplitude:(Float32)withAmplitude
{
	sampleRate = withSampleRate;
	freqHz = withFrequency;
	amplitude = withAmplitude;
	frameCount = 0.0;
}

- (void)setupWithSampleRate:(Float32)rate
{
	[self setupWithSampleRate:rate frequency:440.0 amplitude:0.25];
}

- (void)setupWithSampleRate:(Float32)rate frequency:(Float32)frequency
{
	[self setupWithSampleRate:rate frequency:frequency amplitude:0.25];
}

- (void)setup
{
	[self setupWithSampleRate:44100.0 frequency:440.0 amplitude:0.25];
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self setup];
	}
	return self;
}

- (instancetype)initWithSampleRate:(Float32)rate frequency:(Float32)frequency amplitude:(Float32)amplitude
{
	self = [super init];
	if (self) {
		[self setupWithSampleRate:rate frequency:frequency amplitude:amplitude];
	}
	return self;
}

- (instancetype)initWithSampleRate:(Float32)rate frequency:(Float32)frequency
{
	self = [super init];
	if (self) {
		[self setupWithSampleRate:rate frequency:frequency];
	}
	return self;
}

- (instancetype)initWithSampleRate:(Float32)rate
{
	self = [super init];
	if (self) {
		[self setupWithSampleRate:rate];
	}
	return self;
}

- (void)renderBuffer:(AVAudioPCMBuffer *)buffer { 
	AVAudioFrameCount nFrames = buffer.frameLength;
	AVAudioChannelCount nChannels = buffer.format.channelCount;
	BOOL isInterleaved = buffer.format.isInterleaved;
	
	Float32 phaseStep = freqHz / sampleRate;
	
	if(isInterleaved) {
		float *ptr = buffer.floatChannelData[0];
		for (int frame = 0; frame < nFrames; ++frame) {
			float phase = fmodf((float) frame * phaseStep, 1.0);
			float value = (fabsf(2.0 - 4.0 * phase) - 1.0) * amplitude;
			
			for (int i = 0; i < nChannels; ++i) {
				*ptr = value;
				ptr = ptr + sizeof(float);
			}
		}
	} else {
		for (int ch = 0; ch < nChannels; ++ch) {
			float *ptr = buffer.floatChannelData[ch];
			
			for (int frame = 0; frame < nFrames; ++frame) {
				float phase = fmodf((float) frame * phaseStep, 1.0);
				float value = (fabsf(2.0 - 4.0 * phase) - 1.0) * amplitude;
				
				*ptr = value;
				ptr = ptr + sizeof(float);
			}
		}
	}
}

@end
