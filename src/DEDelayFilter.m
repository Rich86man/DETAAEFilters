//
//  DEDelayFilter.m
//  DEAmazingAudioEngineTest
//
//  Created by Jeremy Flores on 4/25/13.
//  Copyright (c) 2013 Dream Engine Interactive, Inc. All rights reserved.
//

#import "DEDelayFilter.h"

@implementation DEDelayFilter

+(OSType)audioUnitType {
    return kAudioUnitType_Effect;
}

+(OSType)audioUnitSubtype {
    return kAudioUnitSubType_Delay;
}


#pragma mark - Getters

-(double) wetDryMix {
    return [self getParameterValueForId:kDelayParam_WetDryMix];
}

-(double) delayTime {
    return [self getParameterValueForId:kDelayParam_DelayTime];
}

-(double) feedback {
    return [self getParameterValueForId:kDelayParam_Feedback];
}

-(double) lopassCutoff {
    return [self getParameterValueForId:kDelayParam_LopassCutoff];
}


#pragma mark - Setters

-(void) setWetDryMix:(double)wetDryMix {
    [self setParameterValue: wetDryMix
                      forId: kDelayParam_WetDryMix];
}

-(void) setDelayTime:(double)delayTime {
    [self setParameterValue: delayTime
                      forId: kDelayParam_DelayTime];
}

-(void) setFeedback:(double)feedback {
    [self setParameterValue: feedback
                      forId: kDelayParam_Feedback];
}

-(void) setLopassCutoff:(double)lopassCutoff {
    [self setParameterValue: lopassCutoff
                      forId: kDelayParam_LopassCutoff];
}


- (NSArray *)properties
{
    if (!_properties) {
        _properties = @[[AudioProperty createWithName:@"Wet Dry Mix" min:@0 max:@100 defaultValue:@50 delegate:self],
                        [AudioProperty createWithName:@"Delay Time" min:@0 max:@2 defaultValue:@1 delegate:self],
                        [AudioProperty createWithName:@"Feedback" min:@(-100) max:@100 defaultValue:@50 delegate:self],
                        [AudioProperty createWithName:@"Lopass Cutoff" min:@10 max:@22050 defaultValue:@15000 delegate:self]];
    }
    return _properties;
}


- (void)propertyDidChangeValue:(AudioProperty *)property
{
    if ([property.name isEqualToString:@"Wet Dry Mix"]) {
        self.wetDryMix = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Delay Time"]) {
        self.delayTime = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Feedback"]) {
        self.feedback = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Lopass Cutoff"]) {
        self.lopassCutoff = [[property currentValue] doubleValue];
    }
}

@end
