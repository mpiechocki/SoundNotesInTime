//
//  MetronomeCell.h
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 11/01/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MetronomeCellDelegate;

@interface MetronomeCell : UICollectionViewCell
@property (nullable, weak) id<MetronomeCellDelegate> delegate;
@end

@protocol MetronomeCellDelegate <NSObject>
@optional
- (void) startButton:(BOOL)isSelected;
@optional
- (void) bpmSet:(int)bpm;
@end
