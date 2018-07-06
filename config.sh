#!/bin/bash

check_cancel()
{
	if [ $? -gt 0 ]; then
		exit 1
	fi
}

yad --title="Configure APT" --center --list --limit='7' --separator=' ' --text="           Welcome to Altien Port Tracker\n                  Configure APT below:\n" \
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
"" "" "" "192.168.1.0/24" "" "/usr/bin/nmap" "/usr/bin/ndiff" > /tmp/entries
check_cancel

echo "https://crontab.guru/" | yad --title=' Help with Crontab ' --center --justify='center' --text='   Open site for assistance with setting up cron job in the following window   ' --text-info --show-uri
check_cancel

schedule="$(yad --title=' Scheduler ' --center --separator=' ' --text='     Wildcard\n   * = always' \
--image="/root/Downloads/imageedit_1_3572484977(1).png" \
--window-icon="/root/Downloads/imageedit_1_3572484977.ico" \
--form \
--field="Minutes  0-59" \
--field="Hours  0-23" \
--field="Day of Month  0-31" \
--field="Month  0-12\n(or name of month)" \
--field="Weekday  0-7\n(0 or 7 is Sun, or use names)" \
--field="Location of apt.sh" \
--field="Append":RO \
--field="Log Ouput Location" \
--field="IO Redirection":RO \
"" "" "" "" "" "" ">>" "" "2>&1" )"
check_cancel

echo "$schedule"
echo ""
(sudo crontab -l 2>/dev/null; echo "$schedule") | crontab -

