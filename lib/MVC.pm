package MVC;
use Dancer ':syntax';
use Dancer::Plugin::MVC;

our $VERSION = '0.1';



get '/' => sub {
    template 'index';
};

true;
