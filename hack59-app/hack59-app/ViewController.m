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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [mapView addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - GOOGLE_MAP
- (void)mapViewDidLoad
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:mapView.myLocation.coordinate.latitude
                                                            longitude:mapView.myLocation.coordinate.longitude
                                                                 zoom:8];
    mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    mapView.myLocationEnabled = YES;
    mapView.delegate = self;
    mapView.settings.myLocationButton = YES;
    mapView.settings.compassButton = YES;
    self.view = mapView;

    // Creates a marker in the center of the map.
//    GMSMarker *marker = [[GMSMarker alloc] init];
//    marker.position = CLLocationCoordinate2DMake(25.021759, 121.535269);
//    marker.title = @"HackNTU";
//    marker.snippet = @"媽!我上電視了!!";
//    marker.map = mapView;
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker
{

}
- (IBAction)addEventOnMap:(id)sender {
    [self createMarker];
}

-(void)createMarker
{
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(mapView.myLocation.coordinate.latitude, mapView.myLocation.coordinate.longitude);
    marker.map = mapView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqual:@"myLoction"] && [object isKindOfClass:[GMSMapView class]]) {
        if (self.isFirstTimeGetMyLocation) {
            [mapView animateToCameraPosition:[GMSCameraPosition cameraWithLatitude:mapView.myLocation.coordinate.latitude longitude:mapView.myLocation.coordinate.longitude zoom:8]];
            self.isFirstTimeGetMyLocation = NO;
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [mapView removeObserver:self forKeyPath:@"myLocation"];
}

- (UIView *)addButton
{
    if (!self.addButton) {
        self.addButton = [[[NSBundle mainBundle] loadNibNamed:@"AddButton" owner:self options:nil] objectAtIndex:0];
        self.addButton.frame = CGRectMake(0, 10, 120, 120);
    }
    return self.addButton;
}


@end
