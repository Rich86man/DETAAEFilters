//
//  DEReverbFilter.m
//  DEAmazingAudioEngineTest
//
//  Created by Jeremy Flores on 4/25/13.
//  Copyright (c) 2013 Dream Engine Interactive, Inc. All rights reserved.
//

#import "DEReverbFilter.h"

#import "AEAudioController.h"

@implementation DEReverbFilter

+(OSType)audioUnitType {
    return kAudioUnitType_Effect;
}

+(OSType)audioUnitSubtype {
    return kAudioUnitSubType_Reverb2;
}


#pragma mark - Getters

-(double)dryWetMix {
    return [self getParameterValueForId:kReverb2Param_DryWetMix];
}

-(double)gain {
    return [self getParameterValueForId:kReverb2Param_Gain];
}

-(double)minDelayTime {
    return [self getParameterValueForId:kReverb2Param_MinDelayTime];
}

-(double) maxDelayTime {
    return [self getParameterValueForId:kReverb2Param_MaxDelayTime];
}

-(double) decayTimeAt0Hz {
    return [self getParameterValueForId:kReverb2Param_DecayTimeAt0Hz];
}

-(double) decayTimeAtNyquist {
    return [self getParameterValueForId:kReverb2Param_DecayTimeAtNyquist];
}

-(double)randomizeReflections {
    return [self getParameterValueForId:kReverb2Param_RandomizeReflections];
}

-(double) filterFrequency {
    return [self getParameterValueForId:kReverbParam_FilterFrequency];
}

-(double) filterBandwidth {
    return [self getParameterValueForId:kReverbParam_FilterBandwidth];
}

-(double) filterGain {
    return [self getParameterValueForId:kReverbParam_FilterGain];
}


#pragma mark - Setters

-(void)setDryWetMix:(double)dryWetMix {
    [self setParameterValue: dryWetMix
                      forId: kReverb2Param_DryWetMix];
}

-(void) setGain:(double)gain {
    [self setParameterValue: gain
                      forId: kReverb2Param_Gain];
}

-(void) setMinDelayTime:(double)minDelayTime {
    [self setParameterValue: minDelayTime
                      forId: kReverb2Param_MinDelayTime];
}

-(void) setMaxDelayTime:(double)maxDelayTime {
    [self setParameterValue: maxDelayTime
                      forId: kReverb2Param_MaxDelayTime];
}

-(void) setDecayTimeAt0Hz:(double)decayTimeAt0Hz {
    [self setParameterValue: decayTimeAt0Hz
                      forId: kReverb2Param_DecayTimeAt0Hz];
}

-(void) setDecayTimeAtNyquist:(double)decayTimeAtNyquist {
    [self setParameterValue: decayTimeAtNyquist
                      forId: kReverb2Param_DecayTimeAtNyquist];
}

-(void) setRandomizeReflections:(double)randomizeReflections {
    [self setParameterValue: randomizeReflections
                      forId: kReverb2Param_RandomizeReflections];
}

-(void) setFilterFrequency:(double)filterFrequency {
    [self setParameterValue: filterFrequency
                      forId: kReverbParam_FilterFrequency];
}

-(void) setFilterBandwidth:(double)filterBandwidth {
    [self setParameterValue: filterBandwidth
                      forId: kReverbParam_FilterBandwidth];
}

-(void) setFilterGain:(double)filterGain {
    [self setParameterValue: filterGain
                      forId: kReverbParam_FilterGain];
}



- (NSArray *)properties
{
    if (!_properties) {
        _properties = @[[AudioProperty createWithName:@"Dry Wet Mix" min:@0 max:@100 defaultValue:@100 delegate:self],
                        [AudioProperty createWithName:@"Gain" min:@(-20) max:@20 defaultValue:@0 delegate:self],
                        [AudioProperty createWithName:@"Min Delay Time" min:@0.0001 max:@1.0 defaultValue:@0.008 delegate:self],
                        [AudioProperty createWithName:@"Max Delay Time" min:@0.0001 max:@1.0 defaultValue:@0.050 delegate:self],
                        [AudioProperty createWithName:@"Decay Time At 0hz" min:@0.001 max:@20 defaultValue:@1.0 delegate:self],
                        [AudioProperty createWithName:@"Decay Time At Nyquist" min:@0.001 max:@20 defaultValue:@0.5 delegate:self],
                        [AudioProperty createWithName:@"Randomize Reflections" min:@0 max:@1000 defaultValue:@1 delegate:self],
                        [AudioProperty createWithName:@"Filter Frequency" min:@10 max:@20000 defaultValue:@800 delegate:self],
                        [AudioProperty createWithName:@"Filter Bandwidth" min:@0.05 max:@4 defaultValue:@3.0 delegate:self],
                        [AudioProperty createWithName:@"Filter Gain" min:@(-18) max:@18 defaultValue:@0 delegate:self]];
    }
    return _properties;
}


- (void)propertyDidChangeValue:(AudioProperty *)property
{
    if ([property.name isEqualToString:@"Dry Wet Mix"]) {
        self.dryWetMix = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Gain"]) {
        self.gain = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Min Delay Time"]) {
        self.minDelayTime = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Max Delay Time"]) {
        self.maxDelayTime = [[property currentValue] doubleValue];
    } else  if ([property.name isEqualToString:@"Decay Time At 0hz"]) {
        self.decayTimeAt0Hz = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Decay Time At Nyquist"]) {
        self.decayTimeAtNyquist = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Randomize Reflections"]) {
        self.randomizeReflections = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Filter Frequency"]) {
        self.filterFrequency = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Filter Bandwidth"]) {
        self.filterBandwidth = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Filter Gain"]) {
        self.filterGain = [[property currentValue] doubleValue];
    }
}



@end
