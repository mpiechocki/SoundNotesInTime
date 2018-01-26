//
//  This class is basically TriangleWaveGenerator.swift from Apple examples rewritten to objc.
//

#ifndef TriangleGenerator_h
#define TriangleGenerator_h

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface TriangleGenerator: NSObject

- (instancetype)initWithSampleRate:(Float32)rate;
- (instancetype)initWithSampleRate:(Float32)rate frequency:(Float32)frequency;
- (instancetype)initWithSampleRate:(Float32)rate frequency:(Float32)frequency amplitude:(Float32)amplitude;

-(void) renderBuffer: (AVAudioPCMBuffer *)buffer;
@end

#endif /* TriangleGenerator_h */
