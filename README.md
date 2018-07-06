

 _______  _    __________________ _______  _          _______  _______  _______ _________
(  ___  )( \   \__   __/\__   __/(  ____ \( (    /|  (  ____ )(  ___  )(  ____ )\__   __/
| (   ) || (      ) (      ) (   | (    \/|  \  ( |  | (    )|| (   ) || (    )|   ) (   
| (___) || |      | |      | |   | (__    |   \ | |  | (____)|| |   | || (____)|   | |   
|  ___  || |      | |      | |   |  __)   | (\ \) |  |  _____)| |   | ||     __)   | |   
| (   ) || |      | |      | |   | (      | | \   |  | (      | |   | || (\ (      | |   
| )   ( || (____/\| |   ___) (___| (____/\| )  \  |  | )      | (___) || ) \ \__   | |   
|/     \|(_______/)_(   \_______/(_______/|/    )_)  |/       (_______)|/   \__/   )_(   
                                                                                         
       _________ _______  _______  _______  _        _______  _______                       
       \__   __/(  ____ )(  ___  )(  ____ \| \    /\(  ____ \(  ____ )                      
          ) (   | (    )|| (   ) || (    \/|  \  / /| (    \/| (    )|                      
          | |   | (____)|| (___) || |      |  (_/ / | (__    | (____)|                      
          | |   |     __)|  ___  || |      |   _ (  |  __)   |     __)                      
          | |   | (\ (   | (   ) || |      |  ( \ \ | (      | (\ (                         
          | |   | ) \ \__| )   ( || (____/\|  /  \ \| (____/\| ) \ \__                      
          )_(   |/   \__/|/     \|(_______/|_/    \/(_______/|/   \__/                      
                                                                                         

Altien Port Tracker allows you to customize a schedule to scan a target and then runs the scan against previous scans to locate any differences. If a difference is found, a report will be generated and emailed to the designated recipient and also sent to seashells for easy access through the web to a full report.

Dependencies:

-NMAP : Install with sudo apt-get install nmap
-NDIFF : Install with sudo apt-get install ndiff
-seashells : Install with sudo pip install seashells
-msmtp : Use the following guide to install and configure msmtp https://jacmoe.dk/blog/2013/january/how-to-send-emails-with-msmtp-on-windows-or-linux-or-mac-os-x
-crontab : Install with sudo apt-get install cron

Install:

Check if all dependencies are installed.

Command:
which nmap ndiff seashells crontab msmtp

If dependencies are not installed, run the above commands. Be sure to run sudo apt-get update prior to installing.

Once all dependencies are installed, place apt.sh and config.sh into a directory. Set scripts to be executable. APT requires root access to run and must be owned by the root user. Place images folder in a directory, open config.sh in a text editor to point to the images paths.

Configuring:

Run config.sh to open the GUI. This GUI will take you through the configuration process.
