//
//  DEVarispeedFilter.m
//  DEAmazingAudioEngineTest
//
//  Created by Jeremy Flores on 4/26/13.
//  Copyright (c) 2013 Dream Engine Interactive, Inc. All rights reserved.
//

#import "DEVarispeedFilter.h"

@implementation DEVarispeedFilter

+(OSType)audioUnitType {
    return kAudioUnitType_FormatConverter;
}

+(OSType)audioUnitSubtype {
    return kAudioUnitSubType_Varispeed;
}


#pragma mark - Getters

-(double)playbackRate {
    return [self getParameterValueForId:kVarispeedParam_PlaybackRate];
}

-(double)playbackCents {
    return [self getParameterValueForId:kVarispeedParam_PlaybackCents];
}


#pragma mark - Setters

-(void)setPlaybackRate:(double)playbackRate {
    [self setParameterValue: playbackRate
                      forId: kVarispeedParam_PlaybackRate];
}

-(void)setPlaybackCents:(double)playbackCents {
    [self setParameterValue: playbackCents
                      forId: kVarispeedParam_PlaybackCents];
}



- (NSArray *)properties
{
    if (!_properties) {
        _properties = @[[AudioProperty createWithName:@"Playback Rate" min:@0.25 max:@2.0 defaultValue:@1.0 delegate:self],
                        [AudioProperty createWithName:@"Playback Cents" min:@(-2400) max:@2400 defaultValue:@0.0 delegate:self]];
    }
    return _properties;
}


- (void)propertyDidChangeValue:(AudioProperty *)property
{
    if ([property.name isEqualToString:@"Playback Rate"]) {
        self.playbackRate = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Playback Cents"]) {
        self.playbackCents = [[property currentValue] doubleValue];
    }
}



@end
