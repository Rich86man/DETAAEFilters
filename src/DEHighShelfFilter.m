//
//  DEHighShelfFilter.m
//  DEAmazingAudioEngineTest
//
//  Created by Jeremy Flores on 4/25/13.
//  Copyright (c) 2013 Dream Engine Interactive, Inc. All rights reserved.
//

#import "DEHighShelfFilter.h"

@implementation DEHighShelfFilter

+(OSType)audioUnitType {
    return kAudioUnitType_Effect;
}

+(OSType) audioUnitSubtype {
    return kAudioUnitSubType_HighShelfFilter;
}


#pragma mark - Getters

-(double)cutoffFrequency {
    return [self getParameterValueForId:kHighShelfParam_CutOffFrequency];
}

-(double)gain {
    return [self getParameterValueForId:kHighShelfParam_Gain];
}


#pragma mark - Setters

-(void) setCutoffFrequency:(double)cutoffFrequency {
    [self setParameterValue: cutoffFrequency
                      forId: kHighShelfParam_CutOffFrequency];
}

-(void) setGain:(double)gain {
    [self setParameterValue: gain
                      forId: kHighShelfParam_Gain];
}

- (NSArray *)properties
{
    if (!_properties) {
        _properties = @[[AudioProperty createWithName:@"Cutoff Frequency" min:@10 max:@22050 defaultValue:@6900 delegate:self],
                        [AudioProperty createWithName:@"Gain" min:@(-40) max:@40 defaultValue:@0 delegate:self]];
    }
    return _properties;
}


- (void)propertyDidChangeValue:(AudioProperty *)property
{
    if ([property.name isEqualToString:@"Cutoff Frequency"]) {
        self.cutoffFrequency = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Gain"]) {
        self.gain = [[property currentValue] doubleValue];
    }
}

@end
