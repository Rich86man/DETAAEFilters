//
//  DEAudioUnitFilter.m
//  DEAmazingAudioEngineTest
//
//  Created by Jeremy Flores on 4/25/13.
//  Copyright (c) 2013 Dream Engine Interactive, Inc. All rights reserved.
//

#import "DEAudioUnitFilter.h"


@implementation AudioProperty


+ (instancetype)createWithName:(NSString *)name
                           min:(NSNumber *)minValue
                           max:(NSNumber *)maxValue
                  defaultValue:(NSNumber *)defaultValue
                      delegate:(id <AudioPropertyDelegate>)delegate
{
    return [[AudioProperty alloc] initWithName:name
                                           min:minValue
                                           max:maxValue
                                  defaultValue:defaultValue
                                      delegate:delegate];
}

- (instancetype)initWithName:(NSString *)name
                         min:(NSNumber *)min
                         max:(NSNumber *)max
                defaultValue:(NSNumber *)defaultValue
                    delegate:(id <AudioPropertyDelegate>)delegate
{
    self = [super init];
    _name = name;
    _min = min;
    _max = max;
    _defaultValue = defaultValue;
    _delegate = delegate;
    _currentValue = defaultValue;
    return self;
}

+ (instancetype)createFromDictionary:(NSDictionary *)dictionary withDelegate:(id <AudioPropertyDelegate>)delegate
{
    AudioProperty *property = [self createWithName:dictionary[@"name"] min:dictionary[@"min"] max:dictionary[@"max"] defaultValue:dictionary[@"default"] delegate:nil];
    property.currentValue = dictionary[@"current"];
    property.delegate = delegate;
    return property;
}


- (NSDictionary *)toDictionary
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    dictionary[@"name"] = self.name;
    dictionary[@"min"] = self.min;
    dictionary[@"max"] = self.max;
    dictionary[@"default"] = self.defaultValue;
    dictionary[@"current"] = self.currentValue;
    return dictionary;
}


- (void)setCurrentValue:(NSNumber *)currentValue
{
    _currentValue = currentValue;
    if ([self.delegate respondsToSelector:@selector(propertyDidChangeValue:)]) {
        [self.delegate propertyDidChangeValue:self];
    }
}


@end

static double getAudioUnitParameterValue(AudioUnit audioUnit, AudioUnitParameterID parameterType) {
    AudioUnitParameterValue value = 0.0;
    OSStatus status = noErr;
    status = AudioUnitGetParameter(audioUnit,
                                   parameterType,
                                   kAudioUnitScope_Global,
                                   0,
                                   &value);
    
    if (status == noErr) {
        return value;
    }
    else {
        return 0.0;
    }
}

static void setAudioUnitParameterValue(AudioUnit audioUnit, AudioUnitParameterID parameterType, double value) {
    OSStatus status = noErr;
    status = AudioUnitSetParameter(audioUnit,
                                   parameterType,
                                   kAudioUnitScope_Global,
                                   0,
                                   value,
                                   0);
}



@implementation DEAudioUnitFilter

+(OSType)audioUnitType {
    return -1;
}

+(OSType)audioUnitSubtype {
    return -1;
}

+(instancetype)filterWithAudioController:(AEAudioController *)controller {
    OSType audioUnitType = [[self class] audioUnitType];

    NSAssert(audioUnitType != -1, @"You must define the audioUnitType in a subclass");

    OSType audioUnitSubtype = [[self class] audioUnitSubtype];

    NSAssert(audioUnitSubtype != -1, @"You must define the audioUnitSubtype in a subclass");

    AudioComponentDescription component = AEAudioComponentDescriptionMake(kAudioUnitManufacturer_Apple,
                                                                          audioUnitType,
                                                                          audioUnitSubtype);
    
    NSError *error = nil;
    
    id filter = [[[self class] alloc] initWithComponentDescription: component
                                                   audioController: controller
                                                             error: &error];
    
    if (error) {
        return nil;
    }
    else {
        return filter;
    }
}

+ (instancetype)filterFromDictionary:(NSDictionary *)dict withAudioController:(AEAudioController *)controller
{
    DEAudioUnitFilter *filter = [[NSClassFromString(dict[@"class"]) alloc] init];
    
    NSMutableArray *properties = [NSMutableArray array];
    for (NSDictionary *propDictionary in dict[@"properties"]) {
        AudioProperty *property = [AudioProperty createFromDictionary:propDictionary withDelegate:filter];
        [properties addObject:property];
        [filter propertyDidChangeValue:property];
    }
    filter.properties = properties;
    return filter;
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"class"] = NSStringFromClass([self class]);
    NSMutableArray *array = [NSMutableArray array];
    for (AudioProperty *property in self.properties) {
        [array addObject:[property toDictionary]];
    }
    dict[@"properties"] = array;
    return dict;
}



#pragma mark - Parameter Values

-(double) getParameterValueForId:(AudioUnitParameterID) parameterId {
    return getAudioUnitParameterValue(self.audioUnit, parameterId);
}

-(void) setParameterValue: (double)value
                    forId: (AudioUnitParameterID) parameterId {
    setAudioUnitParameterValue(self.audioUnit,
                               parameterId,
                               value);
}

@end
