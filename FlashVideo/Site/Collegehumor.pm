# Part of get-flash-videos. See get_flash_videos for copyright.
package FlashVideo::Site::Collegehumor;

use strict;
use FlashVideo::Utils;

sub find_video {
  my ($self, $browser, $embed_url) = @_;
  my $base = "http://www.collegehumor.com/moogaloop";

  my $id;
  if($browser->content =~ /clip_id=(\d+)/) {
    $id = $1;
  } elsif($embed_url =~ m![/:](\d+)!) {
    $id = $1;
  }
  die "No ID found\n" unless $id;

  $browser->get("$base/video:$id");

  my $xml = from_xml($browser);

  my $title = $xml->{video}->{caption};
  $title = extract_title($browser) if ref $title;

  return $xml->{video}->{file}, title_to_filename($title);
}

1;
