//
//  DEPeakLimiterFilter.m
//  DEAmazingAudioEngineTest
//
//  Created by Jeremy Flores on 4/25/13.
//  Copyright (c) 2013 Dream Engine Interactive, Inc. All rights reserved.
//

#import "DEPeakLimiterFilter.h"

@implementation DEPeakLimiterFilter

+(OSType)audioUnitType {
    return kAudioUnitType_Effect;
}

+(OSType)audioUnitSubtype {
    return kAudioUnitSubType_PeakLimiter;
}


#pragma mark - Getters

-(double)attackTime {
    return [self getParameterValueForId:kLimiterParam_AttackTime];
}

-(double)decayTime {
    return [self getParameterValueForId:kLimiterParam_DecayTime];
}

-(double)preGain {
    return [self getParameterValueForId:kLimiterParam_PreGain];
}


#pragma mark - Setters

-(void)setAttackTime:(double)attackTime {
    [self setParameterValue: attackTime
                      forId: kLimiterParam_AttackTime];
}

-(void) setDecayTime:(double)decayTime {
    [self setParameterValue: decayTime
                      forId: kLimiterParam_DecayTime];
}

-(void) setPreGain:(double)preGain {
    [self setParameterValue: preGain
                      forId: kLimiterParam_PreGain];
}


- (NSArray *)properties
{
    if (!_properties) {
        _properties = @[[AudioProperty createWithName:@"Attack Time" min:@0.001 max:@0.03 defaultValue:@.012 delegate:self],
                        [AudioProperty createWithName:@"Decay Time" min:@0.001 max:@0.006 defaultValue:@0.024 delegate:self],
                        [AudioProperty createWithName:@"Pre Gain" min:@(-40) max:@40 defaultValue:@0 delegate:self]];
    }
    return _properties;
}


- (void)propertyDidChangeValue:(AudioProperty *)property
{
    if ([property.name isEqualToString:@"Attack Time"]) {
        self.attackTime = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Decay Time"]) {
        self.decayTime = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Pre Gain"]) {
        self.preGain = [[property currentValue] doubleValue];
    }
}



@end
