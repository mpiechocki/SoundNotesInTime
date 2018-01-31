//
//  MetronomeCell.m
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 11/01/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#import "MetronomeCell.h"

#import <Masonry.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#define BPM_MAX 300

@interface MetronomeCell () <UITextFieldDelegate>
@end

@implementation MetronomeCell {
	UIStackView *stackView;
	UIButton *startButton;
	UITextField *bpmTextField;
	UIToolbar *toolbar;
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self setupSubviews];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self setupSubviews];
	}
	return self;
}

- (void)setupSubviews {
	
	// start button
	startButton = UIButton.new;
	startButton.titleLabel.textAlignment = NSTextAlignmentCenter;
	[startButton setTitle:@"START" forState:UIControlStateNormal];
	[startButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
	[startButton setTitle:@"PAUSE" forState:UIControlStateSelected];
	[startButton setTitleColor:UIColor.grayColor forState:UIControlStateSelected];
	[startButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
	
	// toolbar
	toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 30.0, 30.0)];
	UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonAction)];
	[toolbar setItems:@[doneButtonItem]];
	
	// bpm text field
	bpmTextField = UITextField.new;
	[bpmTextField setPlaceholder:@"max 300bpm"];
	[bpmTextField setKeyboardType:UIKeyboardTypeNumberPad];
	[bpmTextField setInputAccessoryView:toolbar];
	bpmTextField.delegate = self;
	
	// stackView
	stackView = UIStackView.new;
	stackView.axis = UILayoutConstraintAxisHorizontal;
	stackView.distribution = UIStackViewDistributionFillEqually;
	[stackView addArrangedSubview:bpmTextField];
	[stackView addArrangedSubview:startButton];
	
	[self.contentView addSubview:stackView];
	UIEdgeInsets padding = UIEdgeInsetsMake(5.0, 20.0, 5.0, 20.0);
	[stackView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(stackView.superview).with.insets(padding);
	}];
}

- (void)clicked:(UIButton *)sender
{
	startButton.selected = !startButton.isSelected;
	if (startButton.isSelected) { [bpmTextField endEditing:true]; }
	[self.delegate startButton:startButton.isSelected];
}

#pragma mark - actions
- (void) doneButtonAction
{
	[bpmTextField endEditing:true];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	NSString *bpmString = textField.text;
	if (bpmString) {
		int bpm = bpmString.intValue;
		[self.delegate bpmSet:bpm];
	}
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	NSArray *stringsToConcatenate = [NSArray arrayWithObjects:textField.text, string, nil];
	NSString *newValue = [stringsToConcatenate componentsJoinedByString:@""];
	int bpm = newValue.intValue;
	if (bpm > 0 && bpm <= BPM_MAX) {
		return true;
	}
	return false;
}

@end
