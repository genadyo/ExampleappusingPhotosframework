## Example app using Photos framework - enumerateMovesWithBlock Issue

This is an example project to reproduce the assertion failure I'm having on collectionChanges enumerateMovesWithBlock.

## Steps I used to create this project:
1. Download the example from: https://developer.apple.com/library/ios/samplecode/UsingPhotosFramework/Introduction/Intro.html#//apple_ref/doc/uid/TP40014575
2. Use the photoLibraryDidChange example from: https://developer.apple.com/library/prerelease/ios/documentation/Photos/Reference/PHPhotoLibraryChangeObserver_Protocol/index.html

This added the support for moving updated items with collectionChanges.hasMoves.

## Steps to reproduce the bad access:
1. Run the example, the following code will start updating the creation date:
```Objective-C
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
  [self shuffle];
});
```

## Result:
1.  The same indexPath is used for reloadItemsAtIndexPaths and moveItemAtIndexPath:
```Objective-C
Assertion failure in -[UICollectionView _endItemAnimationsWithInvalidationContext:tentativelyForReordering:], /BuildRoot/Library/Caches/com.apple.xbs/Sources/UIKit_Sim/UIKit-3486.4/UICollectionView.m:3948
attempt to perform a delete and a move from the same index path (<NSIndexPath: 0xc000000001200016> {length = 2, path = 0 - 9})
```