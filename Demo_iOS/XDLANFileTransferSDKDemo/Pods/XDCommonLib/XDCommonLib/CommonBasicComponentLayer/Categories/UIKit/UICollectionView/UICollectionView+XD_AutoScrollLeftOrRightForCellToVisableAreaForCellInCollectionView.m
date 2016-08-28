//
//  UICollectionView+XD_AutoScrollLeftOrRightForCellToVisableAreaForCellInCollectionView.m
//  XDCommonLib
//
//  Created by suxinde on 16/5/31.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "UICollectionView+XD_AutoScrollLeftOrRightForCellToVisableAreaForCellInCollectionView.h"

@implementation UICollectionView (XD_AutoScrollLeftOrRightForCellToVisableAreaForCellInCollectionView)

- (void)autoScrollLeftOrRightForCellToVisableAreaForCellInCollectionViewAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect cellFrame = [self cellForItemAtIndexPath:indexPath].frame;
    CGRect visibleFrame = CGRectInset(cellFrame, -(cellFrame.size.width + 1.5f * ((UICollectionViewFlowLayout *)self.collectionViewLayout).minimumLineSpacing), 0);
    [self scrollRectToVisible:visibleFrame animated:YES];
}

@end
