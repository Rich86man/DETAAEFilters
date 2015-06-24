//
//  DEDynamicsProcessorFilter.m
//  DEAmazingAudioEngineTest
//
//  Created by Jeremy Flores on 4/25/13.
//  Copyright (c) 2013 Dream Engine Interactive, Inc. All rights reserved.
//

#import "DEDynamicsProcessorFilter.h"

@implementation DEDynamicsProcessorFilter

+(OSType)audioUnitType {
    return kAudioUnitType_Effect;
}

+(OSType)audioUnitSubtype {
    return kAudioUnitSubType_DynamicsProcessor;
}


#pragma mark - Getters

-(double)threshold {
    return [self getParameterValueForId:kDynamicsProcessorParam_Threshold];
}

-(double)headRoom {
    return [self getParameterValueForId:kDynamicsProcessorParam_HeadRoom];
}

-(double)expansionRatio {
    return [self getParameterValueForId:kDynamicsProcessorParam_ExpansionRatio];
}

-(double)expansionThreshold {
    return [self getParameterValueForId:kDynamicsProcessorParam_ExpansionThreshold];
}

-(double)attackTime {
    return [self getParameterValueForId:kDynamicsProcessorParam_AttackTime];
}

-(double) releaseTime {
    return [self getParameterValueForId:kDynamicsProcessorParam_ReleaseTime];
}

-(double)masterGain {
    return [self getParameterValueForId:kDynamicsProcessorParam_MasterGain];
}

-(double)compressionAmount {
    return [self getParameterValueForId:kDynamicsProcessorParam_CompressionAmount];
}

-(double)inputAmplitude {
    return [self getParameterValueForId:kDynamicsProcessorParam_InputAmplitude];
}

-(double)outputAmplitude {
    return [self getParameterValueForId:kDynamicsProcessorParam_OutputAmplitude];
}


#pragma mark - Setters

-(void)setThreshold:(double)threshold {
    [self setParameterValue: threshold
                      forId: kDynamicsProcessorParam_Threshold];
}

-(void)setHeadRoom:(double)headRoom {
    [self setParameterValue: headRoom
                      forId: kDynamicsProcessorParam_HeadRoom];
}

-(void)setExpansionRatio:(double)expansionRatio {
    [self setParameterValue: expansionRatio
                      forId: kDynamicsProcessorParam_ExpansionRatio];
}

-(void)setExpansionThreshold:(double)expansionThreshold {
    [self setParameterValue: expansionThreshold
                      forId: kDynamicsProcessorParam_ExpansionThreshold];
}

-(void)setAttackTime:(double)attackTime {
    [self setParameterValue: attackTime
                      forId: kDynamicsProcessorParam_AttackTime];
}

-(void)setReleaseTime:(double)releaseTime {
    [self setParameterValue: releaseTime
                      forId: kDynamicsProcessorParam_ReleaseTime];
}

-(void)setMasterGain:(double)masterGain {
    [self setParameterValue: masterGain
                      forId: kDynamicsProcessorParam_MasterGain];
}

- (NSArray *)properties
{
    if (!_properties) {
        _properties = @[[AudioProperty createWithName:@"Threshold" min:@(-40) max:@20 defaultValue:@(-20) delegate:self],
                        [AudioProperty createWithName:@"Head Room" min:@0.1 max:@40 defaultValue:@5 delegate:self],
                        [AudioProperty createWithName:@"Expansion Ratio" min:@1 max:@50 defaultValue:@2 delegate:self],
                        [AudioProperty createWithName:@"Expansion Threshold" min:@0 max:@100 defaultValue:@0 delegate:self],
                        [AudioProperty createWithName:@"Attack Time" min:@0.0001 max:@0.2 defaultValue:@0.001 delegate:self],
                        [AudioProperty createWithName:@"Release Time" min:@0.01 max:@3 defaultValue:@0.05 delegate:self],
                        [AudioProperty createWithName:@"Master Gain" min:@(-40) max:@40 defaultValue:@0 delegate:self]];
    }
    return _properties;
}


- (void)propertyDidChangeValue:(AudioProperty *)property
{
    if ([property.name isEqualToString:@"Threshold"]) {
        self.threshold = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Head Room"]) {
        self.headRoom = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Expansion Ratio"]) {
        self.expansionRatio = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Expansion Threshold"]) {
        self.expansionThreshold = [[property currentValue] doubleValue];
    } else  if ([property.name isEqualToString:@"Attack Time"]) {
        self.attackTime = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Release Time"]) {
        self.releaseTime = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Master Gain"]) {
        self.masterGain = [[property currentValue] doubleValue];
    }
}


@end

