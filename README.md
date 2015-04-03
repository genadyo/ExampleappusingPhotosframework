## Example app using Photos framework - enumerateMovesWithBlock Issue

This is an example project to reproduce the bad access I'm having on collectionChanges enumerateMovesWithBlock.

## Steps I used to create this project:
1. Download the example from: https://developer.apple.com/library/ios/samplecode/UsingPhotosFramework/Introduction/Intro.html#//apple_ref/doc/uid/TP40014575
2. Use the photoLibraryDidChange example from: https://developer.apple.com/library/prerelease/ios/documentation/Photos/Reference/PHPhotoLibraryChangeObserver_Protocol/index.html

This added the support for moving updated items with collectionChanges.hasMoves.

## Steps to reproduce the bad access:
1. Run the example, the following code will start updating the creation date:
```
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
  [self shuffle];
});
```

## Result:
1. http://cl.ly/image/0T0u3D2z170A/Screen%20Shot%202015-04-02%20at%2002.37.13.png
