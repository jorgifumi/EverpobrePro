//
//  JLPNotesCollectionViewController.m
//  EverpobrePro
//
//  Created by Jorge Miguel Lucena Pino on 26/01/16.
//  Copyright © 2016 Jorge Miguel Lucena Pino. All rights reserved.
//

#import "JLPNotesCollectionViewController.h"
#import "KCGNote.h"
#import "JLPNoteCollectionViewCell.h"
#import "KCGPhoto.h"

static NSString *cellId = @"NoteCellId";

@interface JLPNotesCollectionViewController ()

@end

@implementation JLPNotesCollectionViewController


#pragma mark - View Life Cylce

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self registerNib];
    
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    
    self.title = @"Notas";
}

#pragma mark - Xib registration

- (void)registerNib{
    
    UINib *nib = [UINib nibWithNibName:@"JLPNoteCollectionViewCell"
                                bundle:nil];
    
    [self.collectionView registerNib:nib
          forCellWithReuseIdentifier:cellId];
}

#pragma mark - Data Source

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // Get object
    KCGNote *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    // Get Cell
    JLPNoteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId
                                                                                forIndexPath:indexPath];
    
    // Configure Cell
    [cell observeNote:note];
    
    // Return cell
    return cell;
}

@end
