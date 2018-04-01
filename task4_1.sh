#!/bin/bash
exec 1> `pwd`/task4_1.out
echo '--- Hardware ---'
echo "CPU: " `cat /proc/cpuinfo | grep 'model name' | cut -d : -f 2`
echo "RAM: " `free -h |  grep  Mem | awk '{print $2}'`
manufacturer=`dmidecode -s baseboard-manufacturer`
product_name=`dmidecode -s baseboard-product-name`
serial_number=`dmidecode -s system-serial-number`
echo "Motherboard: "  ${manufacturer:-Unknown} ${product_name:-Unknown}
echo "System Serial Number: " ${serial_number:-Unknown}
echo '--- System ---'
echo "OS Distribution: " `lsb_release -ds`
echo "Kernel version:" `uname -r`
echo "Installation date: " `cat /var/log/dpkg.log* | head -n1 | awk '{print $1}'`
echo "Hostname: " `hostname`
echo "Uptime: " `uptime -p | cut -c 4-`
echo "Processes running: " `ps -aux | wc -l`
echo "Users logged in: " `who --count | cut -d '=' -f 2 | tail -n1`
echo '--- Network ---'
for i in `ifconfig | cut -d ' ' -f1| tr "\n" ' '`
do
  ip_a=`ip -o -4 addr list $i | awk '{print $4}'`
  echo "$i:" ${ip_a:--}
done
exit 0
