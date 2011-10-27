#!/usr/bin/env perl
use Dancer;
#use Browser::Open;
#use MVC;
load_app 'MVC', prefix => '/xyz';
dance;
