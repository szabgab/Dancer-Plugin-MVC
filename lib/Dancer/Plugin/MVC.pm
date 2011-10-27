package Dancer::Plugin::MVC;
use Dancer ':syntax';


use Data::Dumper;
use File::Basename ();
use File::Find qw(find);

sub import {
    my $pkg = shift;
    my $ExportLevel = 0;
    my $callpkg = caller($ExportLevel);
    (my $path = $callpkg) =~ s{::}{/}g;

    my $dir = File::Basename::dirname($INC{"$path.pm"});
 #   warn $dir;
    set_dir($dir);
    find({ wanted => \&_wanted, no_chdir => 1 }, $dir);
 #   warn Dumper [get_pl()];
    warn "pkg: $callpkg ";
#warn Dancer::App->current;
#warn Dancer::App->current->prefix();
    my $prefix = Dancer::App->current->prefix();
    debug "prefix before: $prefix";
    foreach my $module (get_pl()) {
        next if $module eq $callpkg;
        next if $module eq $pkg;
        my $pre = $module;
        $pre =~ s/^$callpkg//;
        $pre =~ s/^:://;
        $pre =~ s{::}{/}g;
        $pre = lc $pre;
        $pre = "$prefix/$pre";

        warn "loading $module to prefix  $pre\n";
        load_app $module, prefix => $pre;
#        eval "use $module";
    }
    Dancer::App->current->prefix($prefix);
#    warn qq($pkg   $callpkg  $INC{"$path.pm"}  ); #  . Dumper \%INC;
}

{
  my @pl;
  my $dir;
  sub set_dir {
    $dir = shift;
  }

  sub _wanted {
    return if $_ !~ /\.pm$/;
#    print "--\n";
#    print "$File::Find::dir\n";
#    print "$File::Find::name\n";
#    print "$_\n";
    my $file = substr($File::Find::name, 1+length($dir), -3);
    $file =~ s{/}{::}g;
    push @pl, $file;
  }

  sub get_pl {
     return @pl;
  }
}



true;

