//
//  ViewController.h
//  FFRecordVoice
//
//  Created by Femina Ernest on 5/30/13.
//  Copyright (c) 2013 Femina Ernest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<AVAudioRecorderDelegate,AVAudioPlayerDelegate>

@property(nonatomic,retain) IBOutlet UIButton *playButton;
@property(nonatomic,retain) IBOutlet UIButton *recordButton;
@property(nonatomic,retain) IBOutlet UIButton *stopButton;


- (IBAction)recordPauseTapped:(id)sender;
- (IBAction)stopTapped:(id)sender;
- (IBAction)playTapped:(id)sender;

@end
