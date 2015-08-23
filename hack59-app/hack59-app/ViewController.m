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

    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(25.021625, 121.534423);
    marker.title = @"HACK INTO THE CITY";
    marker.snippet = @"HackNTU";
    marker.draggable = YES;
    marker.icon = [UIImage imageNamed:@"marker"];
    marker.map = mapView;

    GMSMarker *marker2 = [[GMSMarker alloc] init];
    marker2.position = CLLocationCoordinate2DMake(25.0144121, 121.5350465);
    marker2.title = @"這裏還有好多樹要清理喔";
    marker2.snippet = @"捷運公館站";
    marker2.draggable = YES;
    marker2.icon = [UIImage imageNamed:@"marker"];
    marker2.map = mapView;

    GMSMarker *marker3 = [[GMSMarker alloc] init];
    marker3.position = CLLocationCoordinate2DMake(25.0173263, 121.5386983);
    marker3.title = @"媽!我在這!!";
    marker3.snippet = @"臺灣大學";
    marker3.draggable = YES;
    marker3.icon = [UIImage imageNamed:@"marker"];
    marker3.map = mapView;
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


#pragma mark - Tappe info Window
- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker
{
    NSLog(@"info window Tapped");
    [self performSegueWithIdentifier:@"SegueIdentifier" sender:self];
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
    if ([keyPath isEqualToString:@"myLocation"] && [object isKindOfClass:[GMSMapView class]]) {
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
