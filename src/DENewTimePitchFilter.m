//
//  DENewTimePitchFilter.m
//  DEAmazingAudioEngineTest
//
//  Created by Jeremy Flores on 4/27/13.
//  Copyright (c) 2013 Dream Engine Interactive, Inc. All rights reserved.
//

#import "DENewTimePitchFilter.h"

@implementation DENewTimePitchFilter

+(OSType)audioUnitType {
    return kAudioUnitType_FormatConverter;
}

+(OSType)audioUnitSubtype {
    return kAudioUnitSubType_NewTimePitch;
}


#pragma mark - Getters

-(double)rate {
    return [self getParameterValueForId:kNewTimePitchParam_Rate];
}

-(double)pitch {
    return [self getParameterValueForId:kNewTimePitchParam_Pitch];
}

-(double)overlap {
    return [self getParameterValueForId:kNewTimePitchParam_Overlap];
}

-(double)enablePeakLocking {
    return [self getParameterValueForId:kNewTimePitchParam_EnablePeakLocking];
}


#pragma mark - Setters

-(void)setRate:(double)rate {
    [self setParameterValue: rate
                      forId: kNewTimePitchParam_Rate];
}

-(void)setPitch:(double)pitch {
    [self setParameterValue: pitch
                      forId: kNewTimePitchParam_Pitch];
}

-(void)setOverlap:(double)overlap {
    [self setParameterValue: overlap
                      forId: kNewTimePitchParam_Overlap];
}

-(void)setEnablePeakLocking:(double)enablePeakLocking {
    [self setParameterValue: enablePeakLocking
                      forId: kNewTimePitchParam_EnablePeakLocking];
}



- (NSArray *)properties
{
    if (!_properties) {
        _properties = @[[AudioProperty createWithName:@"Rate" min:@0.03125 max:@32 defaultValue:@1 delegate:self],
                        [AudioProperty createWithName:@"Pitch" min:@(-2400) max:@2400 defaultValue:@1.0 delegate:self],
                        [AudioProperty createWithName:@"Overlap" min:@3.0 max:@32.0 defaultValue:@8.0 delegate:self],
                        [AudioProperty createWithName:@"Enable Peak Locking" min:@0 max:@1 defaultValue:@1 delegate:self]];
    }
    return _properties;
}


- (void)propertyDidChangeValue:(AudioProperty *)property
{
    if ([property.name isEqualToString:@"Rate"]) {
        self.rate = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Pitch"]) {
        self.pitch = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Overlap"]) {
        self.overlap = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Enable Peak Locking"]) {
        self.enablePeakLocking = round([[property currentValue] doubleValue]);
    }
}




@end
