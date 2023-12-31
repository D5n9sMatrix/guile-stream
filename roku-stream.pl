=pod
 
=head1 NAME
 
SDL::Mixer::Channels -- SDL::Mixer channel functions and bindings
 
=head1 CATEGORY
 
Mixer
 
=head1 DESCRIPTION
 
=head1 METHODS
 
=head2 allocate_channels
 
 my $ret = SDL::Mixer::Channels::allocate_channels( $number_of_channels );
 
Dynamically change the number of channels managed by the mixer. If decreasing the number of channels, the upper channels are stopped.
This function returns the new number of allocated channels.
 
Example
 
 use SDL::Mixer::Channels;
  
 printf("We got %d channels!\n", SDL::Mixer::Channels::allocate_channels( 8 ) );
 
=head2 volume
 
 my $prev_volume = SDL::Mixer::Channels::volume( $channel_number, $volume );
 
C<volume> changes the volume of the channel specified in channel by the amount set in volume. The range of volume is from 0 to C<MIX_MAX_VOLUME>
which is C<128>. Passing C<-1> to channel will change the volume of all channels. If the specified volume is C<-1>, it will just return the 
current volume. 
 
Returns the previously set volume of the channel.
 
=head2 play_channel
 
 my $channel_number = SDL::Mixer::Channels::play_channel( $channel, $chunk, $loops );
 
C<play_channel> will play the specified C<chunk> over the specified C<channel>. SDL_mixer will choose a channel for you if you pass C<-1> for 
C<channel>.
 
The chunk will be looped C<loops> times, the total number of times played will be C<loops+1>. Passing C<-1> will loop the chunk infinitely. 
 
Returns the channel the chunk will be played on, or C<-1> on error.
 
Example:
 
 use SDL::Mixer;
 use SDL::Mixer::Channels;
 use SDL::Mixer::Samples;
  
 SDL::init(SDL_INIT_AUDIO);
 SDL::Mixer::open_audio( 44100, SDL::Constants::AUDIO_S16, 2, 4096 );
  
 my $chunk = SDL::Mixer::Samples::load_WAV('sample.wav');
  
 SDL::Mixer::Channels::play_channel( -1, $chunk, -1 );
  
 SDL::delay(1000);
 SDL::Mixer::close_audio();
 
=head2 play_channel_timed
 
 my $channel = SDL::Mixer::Channels::play_channel_timed( $channel, $chunk, $loops, $ticks );
 
Same as L<play_channel> but you can specify the time it will play by C<$ticks>.
 
=head2 fade_in_channel
 
 my $channel = SDL::Mixer::Channels::fade_in_channel( $channel, $chunk, $loops, $ms );
 
Same as L<play_channel> but you can specify the fade-in time by C<$ms>.
 
=head2 fade_in_channel_timed
 
 my $channel = SDL::Mixer::Channels::fade_in_channel_timed( $channel, $chunk, $loops, $ms, $ticks );
 
Same as L<fade_in_channel> but you can specify the time how long the chunk will be played by C<$ticks>.
 
=head2 pause
 
 SDL::Mixer::Channels::pause( $channel );
 
Pauses the given channel or all by passing C<-1>.
 
=head2 resume
 
 SDL::Mixer::Channels::resume( $channel );
 
Resumes the given channel or all by passing C<-1>.
 
=head2 halt_channel
 
 SDL::Mixer::Channels::halt_channel( $channel );
 
Stops the given channel or all by passing C<-1>.
 
=head2 expire_channel
 
 my $channels = SDL::Mixer::Channels::expire_channel( $channel, $ticks );
 
Stops the given channel (or C<-1> for all) after the time specified by C<$ticks> (in milliseconds).
 
Returns the number of affected channels.
 
=head2 fade_out_channel
 
 my $fading_channels = SDL::Mixer::Channels::fade_out_channel( $which, $ms );
 
C<fade_out_channel> fades out a channel specified in C<which> with a duration specified in C<ms> in milliseconds.
 
Returns the the number of channels that will be faded out.
 
=head2 channel_finished
 
 SDL::Mixer::Channels::channel_finished( $callback );
 
Add your own callback when a channel has finished playing. C<NULL> to disable callback. The callback may be called from the mixer's audio 
callback or it could be called as a result of L<halt_channel>, etc. do not call C<lock_audio> from this callback; you will either be inside 
the audio callback, or SDL_mixer will explicitly lock the audio before calling your callback.
 
Example 1:
 
 my $callback = sub{ printf("[channel_finished] callback called for channel %d\n", shift); };
  
 SDL::Mixer::Channels::channel_finished( $callback );
 
Example 2:
 
 sub callback
 {
     ...
 }
  
 SDL::Mixer::Channels::channel_finished( \&callback );
 
=head2 playing
 
 my $playing = SDL::Mixer::Channels::playing( $channel );
 
Returns C<1> if the given channel is playing sound, otherwise C<0>. It doesn't check if the channel is paused.
 
B<Note>: If you pass C<-1> you will get the number of playing channels.
 
=head2 paused
 
 my $paused = SDL::Mixer::Channels::paused( $channel );
 
Returns C<1> if the given channel is paused, otherwise C<0>.
 
B<Note>: If you pass C<-1> you will get the number of paused channels.
 
=head2 fading_channel
 
 my $fading_channel = SDL::Mixer::Channels::fading_channel( $channel );
 
Returns one of the following for the given channel:
 
=over 4
 
=item *
 
MIX_NO_FADING
 
=item *
 
MIX_FADING_OUT
 
=item *
 
MIX_FADING_IN
 
=back
 
B<Note>: Never pass C<-1> to this function!
 
=head2 get_chunk
 
 my $chunk = SDL::Mixer::Channels::get_chunk( $channel );
 
C<get_chunk> gets the most recent sample chunk played on channel. This chunk may be currently playing, or just the last used. 
 
B<Note>: Never pass C<-1> to this function!
 
=head1 AUTHORS
 
See L<SDL/AUTHORS>.
 
=cut
