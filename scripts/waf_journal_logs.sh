#!/bin/bash

# AKİS Proje 1 - WAF / Nginx odaklı journalctl log scripti
# Bu script, projeyle doğrudan ilişkili logları tek bir rapor dosyasında toplar.

RAPOR="waf_journal_rapor.txt"

echo "===== WAF / NGINX JOURNALCTL LOG RAPORU =====" > "$RAPOR"
echo "Bu rapor Nginx, SSH ve (varsa) UFW servis loglarını ve kısa bir kernel özetini içerir." >> "$RAPOR"
echo "" >> "$RAPOR"

############################################
# 1) NGINX SERVİS LOGLARI
############################################
echo "===== [1] NGINX Servis Logları (journalctl -u nginx --since \"today\") =====" >> "$RAPOR"
echo "Nginx web sunucusunun systemd üzerinden başlatılması, durması ve olası hataları." >> "$RAPOR"
echo "" >> "$RAPOR"

journalctl -u nginx --since "today" --no-pager >> "$RAPOR"
echo "" >> "$RAPOR"

############################################
# 2) SSH SERVİS LOGLARI
############################################
echo "===== [2] SSH Servis Logları (journalctl -u ssh / sshd --since \"today\") =====" >> "$RAPOR"
echo "Sunucuya yapılan uzak bağlantı denemeleri, başarılı/başarısız girişler." >> "$RAPOR"
echo "" >> "$RAPOR"

journalctl -u ssh --since "today" --no-pager 2>/dev/null >> "$RAPOR"
journalctl -u sshd --since "today" --no-pager 2>/dev/null >> "$RAPOR"
echo "" >> "$RAPOR"

############################################
# 3) UFW GÜVENLİK DUVARI LOGLARI (VARSA)
############################################
echo "===== [3] UFW Güvenlik Duvarı Logları (journalctl -u ufw --since \"today\") =====" >> "$RAPOR"
echo "Ağ seviyesinde engellenen bağlantılar ve firewall olayları." >> "$RAPOR"
echo "" >> "$RAPOR"

journalctl -u ufw --since "today" --no-pager 2>/dev/null >> "$RAPOR"
echo "" >> "$RAPOR"

############################################
# 4) KERNEL KRİTİK ÖZET (REFERENCE AMAÇLI)
############################################
echo "===== [4] Kernel Kritik Uyarı Özeti (journalctl -k -p 3..4 --since \"today\" | tail) =====" >> "$RAPOR"
echo "Donanım / sanallaştırma ile ilgili kritik uyarılar (projeye dolaylı etki edebilecek sistem durumları)." >> "$RAPOR"
echo "" >> "$RAPOR"

journalctl -k -p 3..4 --since "today" --no-pager | tail -n 40 >> "$RAPOR"
echo "" >> "$RAPOR"

echo "Rapor oluşturuldu: $(realpath "$RAPOR")" >> "$RAPOR"
echo "Rapor oluşturuldu: $(realpath "$RAPOR")"
