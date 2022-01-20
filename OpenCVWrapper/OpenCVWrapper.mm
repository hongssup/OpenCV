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

+ (UIImage *)getContours:(UIImage *)image {
    cv::Mat imageMat;
    UIImageToMat(image, imageMat);
    //Convert to gray
    cv::Mat grayMat;
    cv::cvtColor(imageMat, grayMat, cv::COLOR_BGR2GRAY);
    //Detect edges using Threshold(임계값)
    cv::Mat threshold_output;
    cv::threshold(grayMat, threshold_output, 130.0, 255.0, cv::THRESH_BINARY);
    //Find Contours to find chains of consecutive edge pixels
    std::vector<std::vector<cv::Point>> contours;
    std::vector<cv::Vec4i> hierarchy;
    cv::findContours(threshold_output, contours, hierarchy, cv::RETR_TREE, cv::CHAIN_APPROX_SIMPLE);
    
    for (int i = 0; i < contours.size(); i++) {
        double epsilon = cv::arcLength(contours[i], true) * 0.02;
        cv::approxPolyDP(contours[i], contours[i], epsilon, true);

        if (10000 < contourArea(contours[i]) && contourArea(contours[i]) < 60000) {
            //Draw contours on image
            cv::drawContours(threshold_output, contours, i, cv::Scalar(0,255,0), 10);
            cv::boundingRect(contours[i]);
        }
    }
    return MatToUIImage(threshold_output);
}

+ (NSMutableArray *)getImageArray:(UIImage *)image {
    cv::Mat imageMat;
    UIImageToMat(image, imageMat);
    //Convert to gray
    cv::Mat grayMat;
    cv::cvtColor(imageMat, grayMat, cv::COLOR_BGR2GRAY);
    //Detect edges using Threshold(임계값)
    cv::Mat threshold_output;
    cv::threshold(grayMat, threshold_output, 130.0, 255.0, cv::THRESH_BINARY);
    //Find Contours to find chains of consecutive edge pixels
    std::vector<std::vector<cv::Point>> contours;
    std::vector<cv::Vec4i> hierarchy;
    //테두리(윤곽선) 찾기
    cv::findContours(threshold_output, contours, hierarchy, cv::RETR_TREE, cv::CHAIN_APPROX_SIMPLE);
    //Approximate contours to polygons + get bounding rects
    std::vector<std::vector<cv::Point>> contours_poly( contours.size() );
    cv::Rect boundRect;
    NSMutableArray *image_array = [[NSMutableArray alloc] init];
    for (int i = 0; i < contours.size(); i++) {
        if (10000 < contourArea(contours[i])) {
            double epsilon = cv::arcLength(contours[i], true) * 0.02;
            cv::approxPolyDP(cv::Mat(contours[i]), contours_poly[i], epsilon, true);
            
            boundRect = cv::boundingRect(cv::Mat(contours_poly[i]));
            //Draw contours on image
            cv::drawContours(threshold_output, contours, i, cv::Scalar(0,255,0), 10);
            cv::Mat cropImage = threshold_output(boundRect);
            UIImage *img = MatToUIImage(cropImage);
            [image_array addObject: img];
        }
    }
    return image_array;
}

@end
