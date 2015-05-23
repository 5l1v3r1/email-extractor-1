#!/usr/bin/env bash 

#Whitehat is simple script to harvest email address for penetration testing.
#Script is working in two mode
#In first mode you have to create sitemap manually. You can use (http://www.xml-sitemaps.com/) to create sitemap.
#and put sitemap text file in working directory of Whitehat.Give name it to urllist.txt
#Second mode is automatic just specify domain name & it will first crawl website ;then harvest email address ;But it`s slow due to crawling process.

echo "
__        ___     _ _       _   _       _   
\ \      / / |__ (_) |_ ___| | | | __ _| |_ 
 \ \ /\ / /| '_ \| | __/ _ \ |_| |/ _` | __|
  \ V  V / | | | | | ||  __/  _  | (_| | |_ 
   \_/\_/  |_| |_|_|\__\___|_| |_|\__,_|\__|
                                                                         
"
echo "Please choose method"

echo "
1. If you have sitemap of website than make name urllist.txt & Put in same directory(work Fast)
2. Generate sitemap than harvest email(Automatic but slow)
"
read m1
if [ "$m1" = "1" ];then
echo "
Script is workng,Please be Patient & give some time to harvest it.
"
cat urllist.txt | while read f1
do

w3m $f1 >> f1
perl -wne'while(/[\w\.]+@[\w\.]+/g){print "$&\n"}' f1 | sort -u >> output.txt
rm f1
done

cat output.txt
echo "
Harvesting is complete.Open output.txt file to view email address.
"
fi

if [ "$m1" = "2" ];then
echo "
Please Enter Website To Harvest Email Address 
For example http://tipstrickshack.blogspot.com
"
read choice
echo "
Now we have to make urllist of website.So be Patient & give some time to harvest it.
"
wget --spider --recursive --no-verbose --output-file=wgetlog.txt "$choice"
sed -n "s@.\+ URL:\([^ ]\+\) .\+@\1@p" wgetlog.txt | sed "s@&@\&amp;@" > urllist.txt
rm wgetlog.txt
cat urllist.txt | while read f1
do
w3m $f1 >> f1
perl -wne'while(/[\w\.]+@[\w\.]+/g){print "$&\n"}' f1 | sort -u >> output.txt
rm f1
done

cat output.txt
echo "
Harvesting is complete. Open output.txt file to view email address.
"
echo "
Use E-sender to send email to harvested email Address
"
fi
