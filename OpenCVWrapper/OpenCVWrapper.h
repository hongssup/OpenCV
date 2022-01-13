//
//  OpenCVWrapper.h
//  OpenCV
//
//  Created by SeoYeon Hong on 2021/08/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OpenCVWrapper : NSObject

//Define here interface with OpenCV

//Function to convert an image to grayscale
+ (UIImage *)toGray:(UIImage *)image;
+ (UIImage *)getContours:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
