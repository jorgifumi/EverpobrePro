//
//  JLPNotesCollectionViewController.h
//  EverpobrePro
//
//  Created by Jorge Miguel Lucena Pino on 26/01/16.
//  Copyright © 2016 Jorge Miguel Lucena Pino. All rights reserved.
//

#import "AGTCoreDataCollectionViewController.h"

@class KCGNotebook;

@interface JLPNotesCollectionViewController : AGTCoreDataCollectionViewController

@property (nonatomic, strong) KCGNotebook *notebook;
@end
