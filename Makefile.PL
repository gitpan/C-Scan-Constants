use 5.008003;
use ExtUtils::MakeMaker;
use File::Copy;

my $g_use_bundled_cscan;

BEGIN {
    # Initialize global variables
    $g_use_bundled_cscan = 0;

    eval 'require ModPerl::CScan';

    if ($@) {
        print STDERR "ModPerl::CScan not installed, using bundled copy.\n";
        $g_use_bundled_cscan = 1;
    } elsif ($ModPerl::CScan::VERSION < 0.75) {
        print STDERR "ModPerl::CScan too old ($ModPerl::CScan::VERSION < 0.75),  using bundled copy.\n";
        $g_use_bundled_cscan = 1;
    }
      

    if ($g_use_bundled_cscan) {
        if ( ! -d 'lib/ModPerl' ) {
            mkdir('lib/ModPerl') or
                die "Could not create lib/ModPerl to relocate bundled CScan.pm: $!"
        }
        copy('contrib/lib/ModPerl/CScan.pm', 'lib/ModPerl/CScan.pm') or
            die "Could not copy bundled ModPerl::CScan to lib directory: $!";
    }
}

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'C::Scan::Constants',
    VERSION_FROM      => 'lib/C/Scan/Constants.pm', # finds $VERSION
    PREREQ_PM         => { 'Data::Flow'      => 0,
                           'File::Temp'      => 0,
                           'File::Copy'      => 0,
                           'File::Spec'      => 0,
                           'File::Path'      => 0,
                           'Scalar::Util'    => 0,
                           'List::MoreUtils' => 0,
                           'Test::Pod'       => 0 },
    LICENSE           => 'Perl',    # supported since E::M 6.31
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (AUTHOR         => 'Philip Monsen <philip.monsen@gmail.com>') : ()),
    LIBS              => [''], # e.g., '-lm'
    DEFINE            => '', # e.g., '-DHAVE_SOMETHING'
    INC               => "-I.", # e.g., '-I. -I/usr/include/other'
	# Un-comment this if you add C files to link with later:
    # OBJECT            => '$(O_FILES)', # link all the C files too

#    test              => {TESTS => 't/01-use-module.t'},
    test              => {TESTS => 't/*.t'},
);

# clean up appropriately on "make clean"
sub MY::postamble {
	if ($g_use_bundled_cscan) {
	'
clean :: myclean
myclean:
	$(RM) Makefile.old 
	$(RM) const-c.inc const-xs.inc
	$(RM) -r tmp*
	$(RM) -r lib/ModPerl
	$(RM) *.gz
';
	} else {
'
clean :: myclean
myclean:
	$(RM) Makefile.old 
	$(RM) const-c.inc const-xs.inc
	$(RM) -r tmp*
	$(RM) *.gz
';
	}
}
