# sss
A script for finding a safespot in shoot 'em up games.
It combines frames from a video into one image, so that it would be easier to find a safespot in a certain pattern.

## Usage
First of all, using ffmpeg you have to extract frames from a video with a pattern.
```
$ mkdir frame
$ ffmpeg video.mp4 frame/%5d.png
```
Then, using this script, extracted frames will be combined into one image.
```
$ ./sss.sh [directory with frames] [output.png]
```
(You can do the same thing without this script, by using 
`convert [sequence of images] -evaluate-sequence Max [output]` 
but it takes too much RAM if a really big amount of images is provided)

### Dependencies
- ImageMagick

### Credits
Original method of finding a safespot was created by [toimine](https://www.youtube.com/watch?v=1iLxYD-f4ko).
