//
//  PodAsset.h
//  PodAsset
//
//  Created by Hai Feng Kao on 2016/04/06.
//
//

#import <Foundation/Foundation.h>

@interface PodAsset : NSObject
+ (NSString*)pathForFilename:(NSString*)filename pod:(NSString*)podName;
+ (NSData*)dataForFilename:(NSString*)filename pod:(NSString*)podName;
+ (NSString*)stringForFilename:(NSString*)filename pod:(NSString*)podName;

// returns the resource bundle path for the specified pod  
+ (NSString*)bundlePathForPod:(NSString*)podName;

// return the resource bundle
+ (NSBundle*)bundleForPod:(NSString*)podName;

// returns all assets in the bundle that contains the specified pod 
+ (NSArray*)assetsInPod:(NSString*)podName;
@end
