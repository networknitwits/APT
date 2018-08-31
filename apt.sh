#!/bin/bash

# Pulls variables from /tmp/entries
date_time=`date --utc +%F-%R`
apt_loc=$(cut -d' ' -f1 < /tmp/entries)
web_dir=$(cut -d' ' -f2 < /tmp/entries)
website=$(cut -d' ' -f3 < /tmp/entries)
subnets=$(cut -d' ' -f4 < /tmp/entries)
emails=$(cut -d' ' -f5 < /tmp/entries)
NMAP=$(cut -d' ' -f6 < /tmp/entries)
NDIFF=$(cut -d' ' -f7 < /tmp/entries)


echo "`date` - Welcome to Altien Port Tracker "
echo " "
echo "                                               #  ##  ###" 
echo "                                              # # # #  # " 
echo "                                              ### ##   # " 
echo "                                              # # #    # "
echo "                                              # # #    # " 
echo " "
echo " "

# If directories not present, create them
if [[ ! -e $apt_loc ]]; then
    mkdir -p -v  $apt_loc
fi

if [[ ! -e $web_dir ]]; then
    mkdir -p -v  $web_dir
fi

cd $apt_loc || exit 2

echo "`date` - Scan is currently running... Please be patient.  "
$NMAP --open -T3 -PN $subnets -n -oX scan-$date_time.xml --stylesheet "nmap.xsl" > /dev/null
echo "`date` - Scan has completed $?"

# Checks for previous scan to run ndiff against
if [ -e scan-prev.xml ]; then
    echo "`date` - Creating baseline..."
    # Compares recent scan against previous scan using ndiff
    baseline=`$NDIFF scan-prev.xml scan-$date_time.xml`
    echo "$baseline" > scan-diff-$date_time.txt
    echo "`date` - Comparing scan againsts baseline..."
    # Discounts header and time/date when running ndiff
    if [ `echo "$baseline" | wc -l` -gt 2 ]
    then
            echo "`date` - Irregularity found, notification sent to $emails."
            echo -e "Scan completed for '${subnets}' has detected differences since yesterday. \n\n$baseline\n\nFull report available at $website" | msmtp --debug --from=default -t $emails
    else
            echo "`date`- No irregularities found. "
    fi

else 
    echo "`date` - No baseline available (scan-prev.xml). Unable to check for differences, current scan will be used as baseline against next scan."
fi

# Sends scan to user defined web directory and pipes output from ndiff to seashells
echo "`date` - XML copied to web directory. "
cp scan-$date_time.xml $web_dir
cat scan-diff-$date_time.txt | seashells

# Links recent report to scan-prev.xml to create a new baseline
echo "`date` - Creating new baseline scan-prev.xml"
ln -sf scan-$date_time.xml scan-prev.xml

echo "`date` - APT daily scan is complete."
exit 0 

