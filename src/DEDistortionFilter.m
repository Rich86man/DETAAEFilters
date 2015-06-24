//
//  DEDistortionFilter.m
//  DEAmazingAudioEngineTest
//
//  Created by Jeremy Flores on 4/25/13.
//  Copyright (c) 2013 Dream Engine Interactive, Inc. All rights reserved.
//

#import "DEDistortionFilter.h"

@implementation DEDistortionFilter

+(OSType)audioUnitType {
    return kAudioUnitType_Effect;
}

+(OSType)audioUnitSubtype {
    return kAudioUnitSubType_Distortion;
}


#pragma mark - Getters

-(double) delay {
    return [self getParameterValueForId:kDistortionParam_Delay];
}

-(double) decay {
    return [self getParameterValueForId:kDistortionParam_Decay];
}

-(double) delayMix {
    return [self getParameterValueForId:kDistortionParam_DelayMix];
}

-(double) decimation {
    return [self getParameterValueForId:kDistortionParam_Decimation];
}

-(double) rounding {
    return [self getParameterValueForId:kDistortionParam_Rounding];
}

-(double) decimationMix {
    return [self getParameterValueForId:kDistortionParam_DecimationMix];
}

-(double) linearTerm {
    return [self getParameterValueForId:kDistortionParam_LinearTerm];
}

-(double) squaredTerm {
    return [self getParameterValueForId:kDistortionParam_SquaredTerm];
}

-(double) cubicTerm {
    return [self getParameterValueForId:kDistortionParam_CubicTerm];
}

-(double) polynomialMix {
    return [self getParameterValueForId:kDistortionParam_PolynomialMix];
}

-(double) ringModFreq1 {
    return [self getParameterValueForId:kDistortionParam_RingModFreq1];
}

-(double) ringModFreq2 {
    return [self getParameterValueForId:kDistortionParam_RingModFreq2];
}

-(double) ringModBalance {
    return [self getParameterValueForId:kDistortionParam_RingModBalance];
}

-(double) ringModMix {
    return [self getParameterValueForId:kDistortionParam_RingModMix];
}

-(double) softClipGain {
    return [self getParameterValueForId:kDistortionParam_SoftClipGain];
}

-(double) finalMix {
    return [self getParameterValueForId:kDistortionParam_FinalMix];
}


#pragma mark - Setters

-(void)setDelay:(double)delay {
    [self setParameterValue: delay
                      forId: kDistortionParam_Delay];
}

-(void)setDecay:(double)decay {
    [self setParameterValue: decay
                      forId: kDistortionParam_Decay];
}

-(void)setDelayMix:(double)delayMix {
    [self setParameterValue: delayMix
                      forId: kDistortionParam_DelayMix];
}

-(void)setDecimation:(double)decimation {
    [self setParameterValue: decimation
                      forId: kDistortionParam_Decimation];
}

-(void)setRounding:(double)rounding {
    [self setParameterValue: rounding
                      forId: kDistortionParam_Rounding];
}

-(void)setDecimationMix:(double)decimationMix {
    [self setParameterValue: decimationMix
                      forId: kDistortionParam_DecimationMix];
}

-(void)setLinearTerm:(double)linearTerm {
    [self setParameterValue: linearTerm
                      forId: kDistortionParam_LinearTerm];
}

-(void)setSquaredTerm:(double)squaredTerm {
    [self setParameterValue: squaredTerm
                      forId: kDistortionParam_SquaredTerm];
}

-(void)setCubicTerm:(double)cubicTerm {
    [self setParameterValue: cubicTerm
                      forId: kDistortionParam_CubicTerm];
}

-(void)setPolynomialMix:(double)polynomialMix {
    [self setParameterValue: polynomialMix
                      forId: kDistortionParam_PolynomialMix];
}

-(void)setRingModFreq1:(double)ringModFreq1 {
    [self setParameterValue: ringModFreq1
                      forId: kDistortionParam_RingModFreq1];
}

-(void)setRingModFreq2:(double)ringModFreq2 {
    [self setParameterValue: ringModFreq2
                      forId: kDistortionParam_RingModFreq2];
}

-(void)setRingModBalance:(double)ringModBalance {
    [self setParameterValue: ringModBalance
                      forId: kDistortionParam_RingModBalance];
}

-(void)setRingModMix:(double)ringModMix {
    [self setParameterValue: ringModMix
                      forId: kDistortionParam_RingModMix];
}

-(void)setSoftClipGain:(double)softClipGain {
    [self setParameterValue: softClipGain
                      forId: kDistortionParam_SoftClipGain];
}

-(void)setFinalMix:(double)finalMix {
    [self setParameterValue: finalMix
                      forId: kDistortionParam_FinalMix];
}


- (NSArray *)properties
{
    if (!_properties) {
        _properties = @[[AudioProperty createWithName:@"Delay" min:@0.1 max:@500 defaultValue:@.1 delegate:self],
                        [AudioProperty createWithName:@"Decay" min:@0.1 max:@50 defaultValue:@1.0 delegate:self],
                        [AudioProperty createWithName:@"Delay Mix" min:@0 max:@100 defaultValue:@50 delegate:self],
                        [AudioProperty createWithName:@"Decimation" min:@0 max:@100 defaultValue:@0 delegate:self],
                        [AudioProperty createWithName:@"Rounding" min:@0 max:@100 defaultValue:@0 delegate:self],
                        [AudioProperty createWithName:@"Decimation Mix" min:@0 max:@100 defaultValue:@50 delegate:self],
                        [AudioProperty createWithName:@"Linear Term" min:@0 max:@1 defaultValue:@1 delegate:self],
                        [AudioProperty createWithName:@"Squared Term" min:@0 max:@20 defaultValue:@0 delegate:self],
                        [AudioProperty createWithName:@"Cubic Term" min:@0 max:@20 defaultValue:@0 delegate:self],
                        [AudioProperty createWithName:@"Polynomial Mix" min:@0 max:@100 defaultValue:@50 delegate:self],
                        [AudioProperty createWithName:@"Ring Mod Freq1" min:@.5 max:@8000 defaultValue:@100 delegate:self],
                        [AudioProperty createWithName:@"Ring Mod Freq2" min:@.5 max:@8000 defaultValue:@100 delegate:self],
                        [AudioProperty createWithName:@"Ring Mod Balance" min:@0 max:@100 defaultValue:@0 delegate:self],
                        [AudioProperty createWithName:@"Ring Mod Mix" min:@0 max:@100 defaultValue:@0 delegate:self],
                        [AudioProperty createWithName:@"Soft Clip Gain" min:@(-80) max:@20 defaultValue:@(-6) delegate:self],
                        [AudioProperty createWithName:@"Final Mix" min:@0 max:@100 defaultValue:@50 delegate:self]];
    }
    return _properties;
}


- (void)propertyDidChangeValue:(AudioProperty *)property
{
    if ([property.name isEqualToString:@"Delay"]) {
        self.delay = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Decay"]) {
        self.decay = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Delay Mix"]) {
        self.delayMix = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Decimation"]) {
        self.decimation = [[property currentValue] doubleValue];
    } else  if ([property.name isEqualToString:@"Rounding"]) {
        self.rounding = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Decimation Mix"]) {
        self.decimationMix = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Linear Term"]) {
        self.linearTerm = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Squared Term"]) {
        self.squaredTerm = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Cubic Term"]) {
        self.cubicTerm = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Polynomial Mix"]) {
        self.polynomialMix = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Ring Mod Freq1"]) {
        self.ringModFreq1 = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Ring Mod Freq2"]) {
        self.ringModFreq2 = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Ring Mod Balance"]) {
        self.ringModBalance = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Ring Mod Mix"]) {
        self.ringModMix = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Soft Clip Gain"]) {
        self.softClipGain = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Final Mix"]) {
        self.finalMix = [[property currentValue] doubleValue];
    }
}


@end
