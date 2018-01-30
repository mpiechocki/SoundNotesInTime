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
	Metronome *metronome;
	
	UIStackView *stackView;
	UIButton *startButton;
	UITextField *bpmTextField;
	UIToolbar *toolbar;
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self setup];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self setup];
	}
	return self;
}

- (void)setup
{
	[self setupSubviews];
	[self setupMetronome];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleMediaServicesWereReset:)
												 name:AVAudioSessionMediaServicesWereResetNotification
											   object:nil];
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
	[bpmTextField setPlaceholder:@"max 300 bpm"];
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

- (void)setupMetronome
{
	metronome = [[Metronome alloc] init];
	metronome.delegate = self;
}

- (void)clicked:(UIButton *)sender
{
	startButton.selected = !startButton.isSelected;
	if (startButton.isSelected) { [bpmTextField endEditing:true]; }
	startButton.isSelected ? [metronome start] : [metronome stop];
}

#pragma mark - MetronomeDelegate
- (void)tick
{
	NSLog(@"tick");
}

#pragma mark - Notifications
- (void)handleMediaServicesWereReset:(NSNotification *)notification
{
	// tear down
	metronome.delegate = nil;
	metronome = nil;
	
	// re-create
	metronome = [[Metronome alloc] init];
	metronome.delegate = self;
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
		[metronome setTempo:(Float32) bpm];
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
