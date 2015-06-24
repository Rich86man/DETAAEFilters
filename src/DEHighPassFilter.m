//
//  DEHighPassFilter.m
//  DEAmazingAudioEngineTest
//
//  Created by Jeremy Flores on 4/25/13.
//  Copyright (c) 2013 Dream Engine Interactive, Inc. All rights reserved.
//

#import "DEHighPassFilter.h"

@implementation DEHighPassFilter

+(OSType)audioUnitType {
    return kAudioUnitType_Effect;
}

+(OSType)audioUnitSubtype {
    return kAudioUnitSubType_HighPassFilter;
}


#pragma mark - Getters

-(double)cutoffFrequency {
    return [self getParameterValueForId:kHipassParam_CutoffFrequency];
}

-(double)resonance {
    return [self getParameterValueForId:kHipassParam_Resonance];
}


#pragma mark - Setters

-(void) setCutoffFrequency:(double)cutoffFrequency {
    [self setParameterValue: cutoffFrequency
                      forId: kHipassParam_CutoffFrequency];
}

- (void) setResonance:(double)resonance {
    [self setParameterValue: resonance
                      forId: kHipassParam_Resonance];
}

- (NSArray *)properties
{
    if (!_properties) {
        _properties = @[[AudioProperty createWithName:@"Cutoff Frequency" min:@10 max:@22050 defaultValue:@6900 delegate:self],
                        [AudioProperty createWithName:@"Resonance" min:@(-20) max:@40 defaultValue:@0 delegate:self]];
    }
    return _properties;
}


- (void)propertyDidChangeValue:(AudioProperty *)property
{
    if ([property.name isEqualToString:@"Cutoff Frequency"]) {
        self.cutoffFrequency = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Resonance"]) {
        self.resonance = [[property currentValue] doubleValue];
    }
}


@end

