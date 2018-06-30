#!/bin/bash

yad --title="" --list --limit='7' --separator=' ' --text="           Welcome to Altien Port Tracker\n                  Configure APT below:\n" \
--image="/root/Downloads/imageedit_1_3572484977(1).png" \
--window-icon="/root/Downloads/imageedit_1_3572484977.ico" \
--form \
--field="Directory" \
--field="Web Directory" \
--field="Web URL" \
--field="Target" \
--field="Email Recipients (use spaces to separate)" \
--field="NMAP directory" \
--field="NDIFF directory" \
"" "" "" "192.168.1.0/24" "" "/usr/bin/nmap" "usr/bin/ndiff" > /tmp/entries

RUN_DIRECTORY=$(cut -d' ' -f1 < /tmp/entries)
WEB_DIRECTORY=$(cut -d' ' -f2 < /tmp/entries)
WEB_URL=$(cut -d' ' -f3 < /tmp/entries)
SCAN_SUBNETS=$(cut -d' ' -f4 < /tmp/entries)
EMAIL_RECIPIENTS=$(cut -d' ' -f5 < /tmp/entries)
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

if [[ ! -e $RUN_DIRECTORY ]]; then
    mkdir -p -v  $RUN_DIRECTORY
fi

if [[ ! -e $WEB_DIRECTORY ]]; then
    mkdir -p -v  $WEB_DIRECTORY
fi

cd $RUN_DIRECTORY || exit 2
echo "`date` - Scan is currently running... Please be patient.  "
$NMAP --open -T4 -PN $SCAN_SUBNETS -n -oX scan-$DATE.xml --stylesheet "nmap.xsl" > /dev/null
echo "`date` - Scan has completed $?"

# If this is not the first time running, we can check for a diff. Otherwise skip this section, and tomorrow when the link exists we can diff.
if [ -e scan-prev.xml ]
then
    echo "`date` - Running ndiff..."
    # Run ndiff with the link to yesterdays scan and todays scan
    DIFF=`$NDIFF scan-prev.xml scan-$DATE.xml`

    echo "`date` - Checking ndiff output"
    # There is always two lines of difference; the run header that has the time/date in. So we can discount that.
    if [ `echo "$DIFF" | wc -l` -gt 2 ]
    then
            echo "`date` - Differences Detected. Sending mail."
            echo -e "Scan completed for '${SCAN_SUBNETS}' has detected differences since yesterday. \n\n$DIFF\n\nFull report available at $WEB_URL" | mail$
    else
            echo "`date`- No differences, skipping mail. "
    fi

else 
    echo "`date` - There is no previous scan (scan-prev.xml). Cannot diff today; will do so tomorrow."
fi

# Copy the scan report to the web directory so it can be viewed later.
echo "`date` - Copying XML to web directory. "
cp scan-$DATE.xml $WEB_DIRECTORY

# Create the link from today's report to scan-prev so it can be used tomorrow for diff.
echo "`date` - Linking todays scan to scan-prev.xml"
ln -sf scan-$DATE.xml scan-prev.xml

echo "`date` - APT daily scan is complete."
exit 0 

