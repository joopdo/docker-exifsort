exifsort
========
Dockerized version of:https://github.com/linucksrox/exifsort/blob/master/README.md


exifsort organizes pictures and movies into a date-based directory hierarchy
derived from the embedded EXIF data in the media files themselves.

exifsort is written in Perl, because Perl is awesome.  In order to run exifsort
you will need to install these Perl modules first:
* Image::ExifTool
* File::Util
* Try::Tiny

The target date-based directory hierarchy may or may not already exist.  It's
just fine if it does.  The resulting layout is compatible with shotwell and
f-spot.  It looks like this: $TARGET/YYYY/MM-FULLMONTHNAME (e.g. ./destination/2014/09-September)

So if you have a source directory like this...

    $ ls -l source/
    total 5108
    Dec  2  2012 2009-12-28 22.02.36.jpg
    Dec  2  2012 4056906951_e3108261a4_b.jpg
    Dec  2  2012 ahs st louis trip paddle boat ride.jpg
    Dec  2  2012 bless-vanity-bedroom.jpg
    Dec  2  2012 dax-pan-on-head.jpg
    Dec  2  2012 leviathan-pic-lowres-2010-02-04 20.38.25.jpg
    Dec 17  2012 lightsaber hilts.jpg
    Dec  2  2012 peace-love-linux.png
    Dec  2  2012 wp_Helix_Nebula_1920x1200.jpg

...you can run exifsort like this...

    $ <clone this git>, navigate to root
    $ docker build ./ -t 'exiftool:latest'
    $ docker run -t -i -v "/hostdir":"/containerdir"  exiftool  -s /mnt/usb/<source> --dest /mnt/usb/<target>


...and the files will be moved to the target directory, which will then
look like this:

    $ find target/
    target/
    target/2013
    target/2013/02-February
    target/2013/02-February/r2d2-247.jpg
    target/2010
    target/2010/02-February
    target/2010/02-February/leviathan-pic-lowres-2010-02-04 20.38.25.jpg
    target/2003
    target/2003/12-December
    target/2003/12-December/Coiled Up.jpg
    target/2009
    target/2009/12-December
    target/2009/12-December/2009-12-28 22.02.36.jpg
    target/2012
    target/2012/12-December
    target/2012/12-December/lightsaber hilts.jpg
    target/2012/12-December/peace-love-linux.png
    target/2012/12-December/wp_Helix_Nebula_1920x1200.jpg
    target/2012/12-December/ahs st louis trip paddle boat ride.jpg
    target/2012/12-December/bless-vanity-bedroom.jpg
    target/2012/12-December/dax-pan-on-head.jpg
    target/2012/12-December/4056906951_e3108261a4_b.jpg

exifsort is written for Linux specifically, and it isn't recommended that you
try running it on Windows.

Always back up your media files before using any kind of photo management
utility software such as this.  By using this software you acknowledge that
you have read, understood, and agree to be bound to the LICENSE under which
it is distributed.# docker-exiftool
