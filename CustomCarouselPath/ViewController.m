//
//  ViewController.m
//  CustomCarouselPath
//
//  Created by Alison Clarke on 24/06/2013.
//  
//  Copyright 2013 Scott Logic
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "ViewController.h"
#import "ConveyorBeltCarousel.h"

@interface ViewController ()

@end

@implementation ViewController {
    int numberOfItemsInCarousel;
    NSMutableArray *carouselData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set up the carousel data
    numberOfItemsInCarousel = 20;
    [self setupCarouselViews];
    
    // Create a conveyor belt carousel
    ConveyorBeltCarousel *conveyorBeltCarousel = [[ConveyorBeltCarousel alloc] initWithFrame:self.view.bounds];
    conveyorBeltCarousel.dataSource = self;
    conveyorBeltCarousel.focusPointNormalized = CGPointMake(0.5, 0.7);
           
    [self.view addSubview:conveyorBeltCarousel];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupCarouselViews
{
    carouselData = [[NSMutableArray alloc] init];
    for (int i=0; i<=numberOfItemsInCarousel; i++) {
        // Create a view
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width * 0.8, 250)];
        
        // Add a subview, coloured depending on its position in the carousel, with a border
        UIView *borderedView = [[UIView alloc] initWithFrame:view.bounds];
        borderedView.backgroundColor = [UIColor colorWithHue:((float)i)/numberOfItemsInCarousel saturation:1.0 brightness:0.5 alpha:1.0];
        borderedView.layer.borderWidth = 2.f;
        borderedView.layer.borderColor = [UIColor whiteColor].CGColor;
        borderedView.layer.shouldRasterize = YES;
        [view addSubview:borderedView];
        
        // Apply a shadow to the outer view, so it applies to the border as well as the contents
        CAGradientLayer *shadowGradient = [CAGradientLayer layer];
        shadowGradient.startPoint = CGPointMake(0.5, 0);
        shadowGradient.endPoint = CGPointMake(0.5, 1);
        shadowGradient.locations = @[@0, @1];
        shadowGradient.colors = @[(id)[UIColor colorWithWhite:0 alpha:0].CGColor,
                                  (id)[UIColor colorWithWhite:0 alpha:0.9f].CGColor];
        shadowGradient.frame = borderedView.bounds;
        [view.layer addSublayer:shadowGradient];
        
        // Add the view to the carousel data
        [carouselData addObject:view];
    }
}

#pragma mark - SEssentialsCarouselDataSource methods

-(int)numberOfItemsInCarousel:(SEssentialsCarousel *)carousel
{
    return numberOfItemsInCarousel;
}

-(UIView *)carousel:(SEssentialsCarousel *)carousel itemAtIndex:(int)index
{
    return [carouselData objectAtIndex:index];
}

@end