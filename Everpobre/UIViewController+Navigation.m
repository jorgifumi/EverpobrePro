//
//  UIViewController+Navigation.m
//  Everpobre
//
//  Created by Jorge Miguel Lucena Pino on 19/01/16.
//  Copyright © 2016 Jorge Miguel Lucena Pino. All rights reserved.
//

#import "UIViewController+Navigation.h"

@implementation UIViewController (Navigation)

-(UINavigationController *) wrappedInNavigation{
    
    // Creamos el Navigation Controller
    UINavigationController *nav = [UINavigationController new];
    
    // Le encasquetamos
    [nav pushViewController:self
                   animated:NO];
    
    // Lo devolvemos
    return nav;
}

@end
