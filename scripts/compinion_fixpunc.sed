#!/bin/sed -f

s/\([] "#$%&()*+,/«»:0123456789<=>@[\\^_`{|}~\t]\)\+/ /g;
s/' / /g;
s/'/ /g;
s/ — / /g;
s/- -/ /g;  # emdash
s/--/ /g;   # other hyphens
s/- /-/g;   
s/ -/ /g;
s/' / /g;
s/”/ /g;
s/“/ /g;
s/[?!;]/\./g; #replace end-of-sentence markers by single fullstop
s/\. \./\. /g;
s/ \./\. /g;
s/\.\.\+/\./g;
s/^\s\+//; 
s/\s\+$//; 
s/ \+/ /g;
s/^ *//; 
s/ *$//;
/^$/d;
