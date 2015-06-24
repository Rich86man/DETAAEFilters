//
//  DEBandpassFilter.m
//  DEAmazingAudioEngineTest
//
//  Created by Jeremy Flores on 4/25/13.
//  Copyright (c) 2013 Dream Engine Interactive, Inc. All rights reserved.
//

#import "DEBandpassFilter.h"

@implementation DEBandpassFilter

+(OSType)audioUnitType {
    return kAudioUnitType_Effect;
}

+(OSType)audioUnitSubtype {
    return kAudioUnitSubType_BandPassFilter;
}

- (NSArray *)properties
{
    if (!_properties) {
        _properties = @[[AudioProperty createWithName:@"Center Frequency" min:@20 max:@22050 defaultValue:@5000 delegate:self],
                        [AudioProperty createWithName:@"Bandwidth" min:@100 max:@12000 defaultValue:@600 delegate:self] ];
    }
    return _properties;
}


#pragma mark - Getters
-(double)centerFrequency {
    return [self getParameterValueForId:kBandpassParam_CenterFrequency];
}

-(double)bandwidth {
    return [self getParameterValueForId:kBandpassParam_Bandwidth];
}


#pragma mark - Setters
-(void)setCenterFrequency:(double)centerFrequency {
    [self setParameterValue: centerFrequency
                      forId: kBandpassParam_CenterFrequency];
}

-(void)setBandwidth:(double)bandwidth {
    [self setParameterValue: bandwidth
                      forId: kBandpassParam_Bandwidth];
}


- (void)propertyDidChangeValue:(AudioProperty *)property
{
    if ([property.name isEqualToString:@"Center Frequency"]) {
        self.centerFrequency = [[property currentValue] doubleValue];
    } else if ([property.name isEqualToString:@"Bandwidth"]) {
        self.bandwidth = [[property currentValue] doubleValue];
    }
}

@end
