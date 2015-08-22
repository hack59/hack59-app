//
//  ViewController.m
//  hack59-app
//
//  Created by Tank Lin on 2015/8/21.
//  Copyright (c) 2015年 Tank. All rights reserved.
//

#import "ViewController.h"
#import "AddButton.h"
@import GoogleMaps;

@interface ViewController () <GMSMapViewDelegate, CLLocationManagerDelegate>
{
    GMSMapView *mapView;
}

@property BOOL isFirstTimeGetMyLocation;
@property (strong, nonatomic) AddButton *addButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.isFirstTimeGetMyLocation = YES;

    [self mapViewDidLoad];
//    [self.addButton addSubview:mapView];
}



#pragma mark - Google Map
- (void)mapViewDidLoad
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:mapView.myLocation.coordinate.latitude
                                                            longitude:mapView.myLocation.coordinate.longitude
                                                                 zoom:15];
    mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    mapView.myLocationEnabled = YES;
    mapView.delegate = self;
    mapView.settings.myLocationButton = YES;
    mapView.settings.compassButton = YES;
    self.view = mapView;
}


#pragma mark - Create Markers
//- (IBAction)addEventOnMap:(id)sender {
//    [self createMarker];
//}
-(void)createMarker
{
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(mapView.myLocation.coordinate.latitude, mapView.myLocation.coordinate.longitude);
    marker.map = mapView;
}

/*
#pragma mark - Add Button
- (UIView *)addButton
{
    if (!self.addButton) {
        self.addButton = [[[NSBundle mainBundle] loadNibNamed:@"AddButton" owner:self options:nil] objectAtIndex:0];
        self.addButton.frame = CGRectMake(0, 10, 120, 120);
    }
    return self.addButton;
}
*/

#pragma mark - Observe User Location
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [mapView addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqual:@"myLoction"] && [object isKindOfClass:[GMSMapView class]]) {
        if (self.isFirstTimeGetMyLocation) {
            [mapView animateToCameraPosition:[GMSCameraPosition cameraWithLatitude:mapView.myLocation.coordinate.latitude longitude:mapView.myLocation.coordinate.longitude zoom:15]];
            self.isFirstTimeGetMyLocation = NO;
        }
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [mapView removeObserver:self forKeyPath:@"myLocation"];
}
@end
