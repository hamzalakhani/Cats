//
//  PhotoModel.h
//  CatImages
//
//  Created by Hamza Lakhani on 2016-11-22.
//  Copyright © 2016 Hamza Lakhani. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@import MapKit;
@interface PhotoModel : NSObject

@property (nonatomic) NSString* farmID;
@property (nonatomic) NSString* serverID;
@property (nonatomic) NSString* photoID;
@property (nonatomic) NSString* secretID;
@property (nonatomic) NSString* titleDescription;
@property (nonatomic) NSString* imageURL;
@property (nonatomic) UIImage* imageFile;

-(instancetype)initWithFarmID:(NSString *)farmID serverID:(NSString *)serverID photoID:(NSString *)photoID secretID:(NSString *)secretID titleDescription:(NSString *)titleDescription;

@property(nonatomic) CLLocationCoordinate2D coordinateID;

@end
