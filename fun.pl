#!/usr/bin/perl -w

    use warnings;
    use utf8;
    use Switch;
    use File::Basename;

    $ENV{'PATH'} = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin';

    print "Content-type: text/plain; charset=utf-8\n\n";

    $query = $ENV{'QUERY_STRING'};
    @list = split( /\&/, $query);

    #@animals=('ghostbusters','cower','eyes','hellokitty','pony','dragon','pony-smaller','sodomized-sheep',
    #          'daemon','bud-frogs','stimpy','apt','flaming-sheep','turkey','default','elephant-in-snake',
    #          'mech-and-cow','sheep','unipony','vader-koala','cock','koala','moofasa','suse','www','ren',
    #          'stegosaurus','bunny','mutilated','turtle','bong','luke-koala','calvin','kosh','head-in',
    #          'snowman','cheese','milk','elephant','skeleton','duck','gnu','three-eyes','meow','dragon-and-cow',
    #          'vader','moose','beavis.zen','kitty','tux','unipony-smaller','kiss');

    chdir "/usr/share/cowsay/cows/";
    @animals = glob("*.cow");
    $_ =~ s/\.cow//g for @animals;
    my %values = map { $_ => 1 } @animals;

    foreach (@list) {
        ($var, $val) = split(/=/);
        $val =~ s/\'//g;
        $val =~ s/\+/ /g;
        $val =~ s/%(\w\w)/sprintf("%c", hex($1))/ge;

        switch($var) {
            case "uso" {
                if($val eq "chat") {
                    $GOOGLE_CHAT = 1;
                }
            }
            case "cows" {
                @my_animals = split(/,/,$val);
        @my_animals = grep $values{ $_ }, @my_animals;
                if(!@my_animals) { @my_animals="head-in"; }
            }
            case "list" {
                $PRINT_COWS = 1;
            }
            case "msg" {
                $MESSAGE = $val;
            }
            case "addmsg" {
                $MESSAGE_ADD = $val;
            }
        }
    }

    if(!@my_animals) {
         @my_animals = @animals;
    }

    if($PRINT_COWS) {
        foreach(@animals) {
            $cowsay = `echo Oi, eu sou "$_" | /usr/games/cowsay -f "$_"`;
            print "$cowsay\n\n"
        }
    } else {
        if($MESSAGE) {
            $cowsay = `echo "$MESSAGE" | /usr/games/cowsay -f "$my_animals[rand @my_animals]"`;
        } else {
            if($MESSAGE_ADD) {
                $fortune = `/usr/games/fortune`;
                $cowsay = `echo "$fortune $MESSAGE_ADD" | /usr/games/cowsay -f "$my_animals[rand @my_animals]"`;
            } else {
                $cowsay = `/usr/games/fortune | /usr/games/cowsay -f "$my_animals[rand @my_animals]"`;
            }
        }
        if($GOOGLE_CHAT) {
            $cowsay =~ s/\"/\'/g;
            $cowsay =~ s/\\/\\\\/g;
        }
        print "$cowsay"
    }
