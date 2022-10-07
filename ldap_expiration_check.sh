
date_now=$(date "+%Y%m%d%H%MZ")

echo $date_now


echo "This is checking LDAP active user password expiration script, source path : /home/user/ldap_expiration_check.sh" >> ldap_exp_report.txt



check_user_info=$(ldapsearch -x -b 'ou=people,dc='your setting',dc='your setting',dc='your setting',dc='your setting'' uid=* \* + | grep -E "bash|pwdChangedTime|uid:|gecos" |  sed '/^gecos/i \-\-\-\-\-\-\-\-\-\-\-\-' > ldap_user_info.txt)



ot=$(cat ldap_user_info.txt | grep pwdChangedTime | awk -F ' ' '{print $2}')


#save all ldap user in file
$check_user_info


e = 0

#every wrong time format value
for TIME in $ot;

do
e=$((e+1))
echo "total how many loop :"$e





function _convert_ldap_timestamp() {
    ts=$1
    if [[ "${ts}" =~ ^[0-9]{14}Z$ ]]; then
        echo "${ts:0:4}-${ts:4:2}-${ts:6:2} ${ts:8:2}:${ts:10:2}:${ts:12:2}"
    fi
}


#modified time format
ct=$(_convert_ldap_timestamp $TIME)

#ct=\"${ct}\"
echo $ct >> ldap_check_time.txt

echo "this is original time" $TIME
echo "this is ct :" $ct



plus_months=$(date -d "$ct 90 day" "+%s")

echo "plus_months :" $plus_months

echo "##"




unchanged_current_date=$(echo -e date)
current_date=$(date -d "$date" "+%s")

echo "current_date : " $current_date


)
day_left=$(((($plus_months - $current_date))/86400))
echo $day_left ": left days"

# any between 0 to 7
if [ "$day_left" -gt "-1" ] && [ "$day_left" -lt 8 ];
then
  echo "Active password expiring soon." >> ldap_exp_report.txt
  echo "Remaining $day_left days before expiration" >> ldap_exp_report.txt
  cat ldap_user_info.txt | grep "$TIME" -B 4 | sed -n -e  '/-----/,/pwd/  p' >> ldap_exp_report.txt
  echo "It is within the alert period" >> ldap_exp_report.txt
  echo "---------------------------"
  echo "##################################################" >> ldap_exp_report.txt

# any less than -7 = start from -8
elif [ "$day_left" -lt "-7" ];
then
  echo "throw and ignore"
  echo "---------------------------"


# -7 to -1
elif [ "$day_left" -gt "-8" ]  && [ "$day_left" -lt "0" ];
then
  echo "It is EXPIRED with grace period"
  echo "Password is EXPIRED, it is within grace period, please confirm the user is still exist." >> ldap_exp_report.txt
  echo "EXPIRED $day_left days" >> ldap_exp_report.txt
  cat ldap_user_info.txt | grep "$TIME" -B 4 | sed -n -e  '/-----/,/pwd/  p' >> ldap_exp_report.txt
  echo "---------------------------"
  echo "##################################################" >> ldap_exp_report.txt


else

  echo "Still healthy and valid, It is not whithin than 0-7 and below -7 to 01 or below -7 "
  echo "---------------------------"
fi


#cut command to replace


t



done

cat ldap_exp_report.txt | grep bash -B 4 -A 4 > report_tmpfile && mv -f report_tmpfile ldap_exp_report.txt
sed -i '1i This is checking LDAP active user password expiration script, source path : /home/user/ldap_expiration_check.sh' ldap_exp_report.txt




mail -s "ldap_expiration_daily_report" youremail@gmail.com youremail2@gmail.com< ldap_exp_report.txt


sleep 5

rm -rf /home/user/ldap*

