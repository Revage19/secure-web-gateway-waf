#!/bin/bash
RAPOR="/home/revage/secure-web-gateway-waf/hafta2_rapor.txt"
LOG="/var/log/nginx/access.log"

echo "===== CPU'ya Göre En Çok Kaynak Tüketen Süreçler =====" > $RAPOR
ps aux --sort=-%cpu | head -n 10 >> $RAPOR

echo -e "\n===== RAM'e Göre En Çok Tüketen Süreçler =====" >> $RAPOR
ps aux --sort=-%mem | head -n 10 >> $RAPOR

echo -e "\n===== Zombi Süreç Kontrolü =====" >> $RAPOR
ps aux | awk '$8 ~ /Z/ {print $0}' >> $RAPOR

echo -e "\n===== IP Adresi Analizi =====" >> $RAPOR
grep -oE "([0-9]{1,3}\.){3}[0-9]{1,3}|::1" $LOG | sort | uniq -c | sort -nr >> $RAPOR

echo -e "\n===== 4xx ve 5xx Hata Kodları =====" >> $RAPOR
awk '{print $9}' $LOG | grep -E "4[0-9]{2}|5[0-9]{2}" | sort | uniq -c | sort -nr >> $RAPOR

echo -e "\n===== En Çok İstek Yapan IP'ler =====" >> $RAPOR
awk '{print $1}' $LOG | sort | uniq -c | sort -nr >> $RAPOR

echo -e "\n===== En Çok Talep Edilen URL'ler =====" >> $RAPOR
awk -F\" '{print $2}' $LOG | awk '{print $2}' | sort | uniq -c | sort -nr >> $RAPOR

echo -e "\nRapor oluşturuldu: $RAPOR"
