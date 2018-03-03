//
//  RecordingCell.h
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 11/01/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RecordingCellDelegate <NSObject>
@optional
-(void)recordClicked:(BOOL)isSelected;
@end

@interface RecordingCell : UICollectionViewCell
@property (weak, nullable) id<RecordingCellDelegate> delegate;
@end
