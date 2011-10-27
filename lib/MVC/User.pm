package MVC::User;
use Dancer ':syntax';

#my $prefix = Dancer::App->current->prefix();
#debug "prefix in User: $prefix";

get '/name' => sub {
    template 'index';
};



true;

