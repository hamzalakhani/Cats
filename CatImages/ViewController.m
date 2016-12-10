//
//  ViewController.m
//  CatImages
//
//  Created by Hamza Lakhani on 2016-11-22.
//  Copyright © 2016 Hamza Lakhani. All rights reserved.
//

#import "ViewController.h"
#import "PhotoModel.h"
#import "CollectionViewCell.h"
static NSString *const ApiKey = @"e539de769326bd0c16dca4db43f14fb2";
static NSString *const Format = @"json";
static NSString *const Nojson = @"1";
static NSString *const Extras = @"url_m";
static NSString *const Geo = @"1";

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property NSMutableArray *photoArray;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL*url=  [self makeURL:@"cars" :@"flickr.photos.search"];
    
    
    
    
    self.photoArray = [[NSMutableArray alloc] init];


    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session= [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

            
            if (error) {
                
                NSLog(@"Request failed: %@", error.localizedDescription);
            }
            
            
            NSError *err = nil;
            NSMutableDictionary *photoSearch = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
            
            if (err) {
                
                //Handle the error
                NSLog(@"jsonError: %@", err.localizedDescription);
                return;
            }
            
            NSDictionary *photosDictionary = photoSearch[@"photos"];
            
            //If we reach this point, we have successfully retrieved the JSON from the API
            for (NSDictionary *photo in photosDictionary[@"photo"]) {
                
                NSString *farmID = photo[@"farm"];
                NSString *serverID = photo[@"server"];
                NSString *photoID = photo[@"id"];
                NSString *secretID = photo[@"secret"];
                NSString *titleDescription = photo[@"title"];
//                CLLocationCoordinate2D *coordinate = (__bridge CLLocationCoordinate2D *)(photo[@"coordinate"]);
                
                [self.photoArray addObject:[[PhotoModel alloc] initWithFarmID:farmID serverID:serverID photoID:photoID secretID:secretID titleDescription:titleDescription]];
                
                NSLog(@"farm Id: %@", farmID);
                NSLog(@"server Id: %@", serverID);
                NSLog(@"photo Id: %@", photoID);
                NSLog(@"secret Id: %@", secretID);
                NSLog(@"Description: %@", titleDescription);
                
            }
            
        // photoArray
        // loop over array of photos, make a new call with new URL to get location data from photoID
        // getLocationDataForPhotoID
        
        
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                //This will run on the main queue
                [self.collectionView reloadData];
                
            }];
            
            
        }];
        
        [dataTask resume];
        
    }

-(void)getLocationDataForPhotoID:(NSString *)photoID {
    
}


                                      
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
                                          
    return 1;
                                          
    }
                                      
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
                                          
    return self.photoArray.count;
                                          
    }
                                      
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
                                          
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    PhotoModel *photoModel = self.photoArray[indexPath.row];
    
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: photoModel.imageURL]];
    
    cell.imageView.image = [UIImage imageWithData: imageData];
    
//    cell.imageView.image = photoModel.imageFile;
    
    return cell;
                                          
    }
//:(NSDictionary*)queryDictionary
//can make it of type NSDictionary to give choice to users
-(NSURL*)makeURL:(NSString*)query :(NSString*)method {
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = @"https";
    components.host = @"api.flickr.com";
    components.path = @"/services/rest/";
    
    NSMutableArray *queryItems = [NSMutableArray new];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"format" value:Format]];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"nojsoncallback" value:Nojson]];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"api_key" value:ApiKey]];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"method" value:method]];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"extras" value:@"url_m"]];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"has_geo" value:Geo]];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"tags" value:query]];
    
//    for (entry in queryDictionary) {
//        
//    }
    
    components.queryItems = queryItems;
    return components.URL;
}

@end
