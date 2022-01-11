//
//  OpenCVWrapper.m
//  OpenCV
//
//  Created by SeoYeon Hong on 2021/08/20.
//

#import "OpenCVWrapper.h"
#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>

@implementation OpenCVWrapper

//Here we can use C++ code

+ (UIImage *)toGray:(UIImage *)image {
    //Transfrom UIImage to cv::Mat
    cv::Mat imageMat;
    UIImageToMat(image, imageMat);
    
    //If the image was already grayscale, return it
    if (imageMat.channels() == 1)
        return image;
    
    //Transform the cv::Mat color image to gray
    cv::Mat grayMat;
    cv::cvtColor(imageMat, grayMat, cv::COLOR_BGR2GRAY);
    
    // Transform grayMat to UIImage and return
    return MatToUIImage(grayMat);
                 
}
@end
