//
//  DEAudioUnitFilter.h
//  DEAmazingAudioEngineTest
//
//  Created by Jeremy Flores on 4/25/13.
//  Copyright (c) 2013 Dream Engine Interactive, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AEAudioUnitFilter.h"

@protocol AudioPropertyDelegate;

@interface AudioProperty : NSObject
@property (weak, nonatomic) id <AudioPropertyDelegate> delegate;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *min;
@property (strong, nonatomic) NSNumber *max;
@property (strong, nonatomic) NSNumber *defaultValue;
@property (strong, nonatomic) NSNumber *currentValue;

+ (instancetype)createWithName:(NSString *)name
                           min:(NSNumber *)minValue
                           max:(NSNumber *)maxValue
                  defaultValue:(NSNumber *)defaultValue
                      delegate:(id <AudioPropertyDelegate>)delegate;
- (NSDictionary *)toDictionary;
+ (instancetype)createFromDictionary:(NSDictionary *)dictionary withDelegate:(id <AudioPropertyDelegate>)delegate;;
@end

@protocol AudioPropertyDelegate <NSObject>

- (void)propertyDidChangeValue:(AudioProperty *)property;
@end

@class AEAudioController;

@interface DEAudioUnitFilter : AEAudioUnitFilter <AudioPropertyDelegate>
{
    @protected
    NSArray *_properties;
}
@property (strong, nonatomic) NSArray *properties;
// this will be overridden by subclasses
+(OSType)audioUnitType;

// this will be overridden by subclasses
+(OSType)audioUnitSubtype;

+(instancetype)filterWithAudioController:(AEAudioController *)controller;
+(instancetype)filterFromDictionary:(NSDictionary *)dict withAudioController:(AEAudioController *)controller;
- (NSDictionary *)toDictionary;
// these should only be used by subclasses. Use the properties instead to get and set values.
-(double) getParameterValueForId:(AudioUnitParameterID) parameterId;

-(void) setParameterValue: (double)value
                    forId: (AudioUnitParameterID) parameterId;



@end
