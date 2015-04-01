## Example app using Photos framework - enumerateMovesWithBlock Issue

This is an example project to reproduce the bad access i'm having on collectionChanges enumerateMovesWithBlock.

## Steps I used to create this project:
1. Download the example from: https://developer.apple.com/library/ios/samplecode/UsingPhotosFramework/Introduction/Intro.html#//apple_ref/doc/uid/TP40014575
2. Use the photoLibraryDidChange example from: https://developer.apple.com/library/prerelease/ios/documentation/Photos/Reference/PHPhotoLibraryChangeObserver_Protocol/index.html

This added the support for moving updated items with collectionChanges.hasMoves.

## Steps to reproduce the bad access:
1. Run the example.
2. Download and run Organizer: https://itunes.apple.com/us/app/organizer-all-your-photos/id954717485
3. Use Organizer to adjust a date of a photo (Version 1.2.0 will crash because it uses the same code).
4. Switch back to the example.

## Result:
1. http://cl.ly/image/0T0u3D2z170A/Screen%20Shot%202015-04-02%20at%2002.37.13.png
