//
//  UICollectionView+XD_AutoScrollLeftOrRightForCellToVisableAreaForCellInCollectionView.h
//  XDCommonLib
//
//  Created by suxinde on 16/5/31.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (XD_AutoScrollLeftOrRightForCellToVisableAreaForCellInCollectionView)

/**
 *  水平UICollectionView点击某个cell时，若cell后面还有cell，则往前移动
 *
 *  @param indexPath 点击选中的cell的indexPath
 */
- (void)autoScrollLeftOrRightForCellToVisableAreaForCellInCollectionViewAtIndexPath:(NSIndexPath *)indexPath;

@end
