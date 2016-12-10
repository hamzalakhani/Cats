//
//  PhotoModel.m
//  CatImages
//
//  Created by Hamza Lakhani on 2016-11-22.
//  Copyright © 2016 Hamza Lakhani. All rights reserved.
//

#import "PhotoModel.h"

@implementation PhotoModel
-(instancetype)initWithFarmID:(NSString *)farmID serverID:(NSString *)serverID photoID:(NSString *)photoID secretID:(NSString *)secretID titleDescription:(NSString *)titleDescription

{
    self = [super init];
    if (self) {
        _farmID =farmID;
        _serverID = serverID;
        _photoID = photoID;
        _secretID = serverID;
        _titleDescription = titleDescription;
        _imageURL = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", farmID, serverID, photoID, secretID];
    }
    return self;
}

@end
