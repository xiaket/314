#!/bin/bash

PASV_MIN=50000
PASV_MAX=50100

# Parse users from FTP_LIST, create them and chown their home directories
if [ -n "$FTP_LIST" ]; then
	echo "Parsing user list and creating home folders..."
	IFS=';' read -r -a parsed_ftp_list <<< "$FTP_LIST" ; unset IFS
	for ftp_account in ${parsed_ftp_list[@]}
	do
		IFS=':' read -r -a tab <<< "$ftp_account" ; unset IFS
		ftp_login=${tab[0]}
		ftp_pass=${tab[1]}
		CRYPTED_PASSWORD=$(perl -e 'print crypt($ARGV[0], "password")' $ftp_pass)
		echo "ftp_login: $ftp_login"
		# Only create user if it does not exist (e.g.: container is re-started)
		USER_EXISTS=`id $ftp_login 2&> /dev/null; echo $?`
		if [ $USER_EXISTS -ne 0 ]; then
			useradd --shell /bin/sh ${USERADD_OPTIONS} -d /home/$ftp_login --password $CRYPTED_PASSWORD $ftp_login || { echo "Creating user $ftp_login failed! Check previous log message." ; exit 1; }
    		chown -R $ftp_login:$ftp_login /home/$ftp_login || { echo "Failed to chown home folder for $ftp_login ! Check previous log message." ; exit 1; }
		fi;
	done
fi

sed -i "s/^\(# \)\?PassivePorts.*$/PassivePorts ${PASV_MIN} ${PASV_MAX}/" /etc/proftpd/proftpd.conf

exec "$@"
