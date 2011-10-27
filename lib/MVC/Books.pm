package MVC::Books;
use Dancer ':syntax';


get '/title' => sub {
    template 'index';
};



true;


