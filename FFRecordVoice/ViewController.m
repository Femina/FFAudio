//
//  ViewController.m
//  FFRecordVoice
//
//  Created by Femina Ernest on 5/30/13.
//  Copyright (c) 2013 Femina Ernest. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    AVAudioPlayer *player;
    AVAudioRecorder *recorder;
}

@end

@implementation ViewController

@synthesize playButton,recordButton,stopButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [playButton setEnabled:NO];
    [stopButton setEnabled:NO];
    
    NSArray *path = [NSArray arrayWithObjects:
                     [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                     @"MyAudio.m4a",
                     nil];
    
    NSURL *url = [NSURL fileURLWithPathComponents:path];
    
    AVAudioSession *avSession = [AVAudioSession sharedInstance];
    [avSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    // It define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    // Initiate and prepare the recorder
    recorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:nil];
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    [recorder prepareToRecord];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)recordPauseTapped:(id)sender
{
    // This is to support record / pause
    
    if(player.playing)
    {
        [player stop];
    }
    
    if(!recorder.recording)
    {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        [recorder record];
        [recordButton setTitle:@"Pause" forState:UIControlStateNormal];
    }
    else
    {
        [recorder stop];
        [recordButton setTitle:@"Record" forState:UIControlStateNormal];
    }
    
    [stopButton setEnabled:YES];
    [playButton setEnabled:NO];
}

- (IBAction)stopTapped:(id)sender
{
    [recorder stop];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
}

- (IBAction)playTapped:(id)sender
{
    if (!recorder.recording)
    {
        
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:nil];
        [player setDelegate:self];
        [player play];
        
    }
}

#pragma mark - AVAudioRecorderDelegate

- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag{
    [recordButton setTitle:@"Record" forState:UIControlStateNormal];
    [stopButton setEnabled:NO];
    [playButton setEnabled:YES];
}

#pragma mark - AVAudioPlayerDelegate

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Wow!"
                                                    message: @"Hey!Im done with playing the recorded audio clip :)!"
                                                   delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


@end
