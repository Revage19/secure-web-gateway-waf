# secure-web-gateway-waf
AKİS Proje  – Secure Web Gateway &amp; WAF yapılandırması
=======
# Secure Web Gateway & WAF – AKIS Proje 1

Bu proje, web trafiğinin güvenligini saglamak icin Secure Web Gateway ve WAF
(WEB Application Firewall) bileşenlerini temel alan bir laboratuvar calismasidir.
Linux uzerinde kullanici/grup yapisi, SGID, ACL ve en az yetki ilkesi uygulanmistir.
# Hafta iki 
Amaç; Linux üzerinde çalışan bir Nginx sunucusu için:

- Kimlik ve erişim kontrolü (kullanıcı/grup, ACL, SGID, least privilege),
- Komut satırı ile süreç (process) yönetimi,
- Nginx log’ları üzerinden metin işleme (grep, awk, sort, regex) yaparak rapor üretme
## Lisans Tercihi – Neden GNU GPL v3?

Bu projede GNU GPL v3 lisansini kullandim. Bunun sebebi projenin egitim ve guvenlik
odakli olmasi ve kodun acik kalmasini istememdir. GPL lisansi, projenin kapali kaynak
ticari bir urune direkt entegre edilmesini engeller ve yapilan gelistirmelerin acik
sekilde paylasilmasini tesvik eder. Guvenlik alaninda seffaflik ve denetlenebilirlik
onemli oldugu icin MIT yerine GPL tercih ettim.

## Dizın Yapisi

- `01-access-control/`
  - `secure-web-gateway-waf-access-control.md` → Erişim kontrolu, ACL, SGID ve kullanici/grup yapilandirmasinin aciklamasi
  - `getfacl_output.txt` → /srv/www dizini icin ACL ve izin ciktisi

## Kullanılan komutlar

```bash
sudo groupadd swg-admins
sudo useradd -m -G swg-admins gateway
sudo useradd -m -G swg-admins wafengine
sudo mkdir -p /srv/www
sudo chown root:swg-admins /srv/www
sudo chmod 2775 /srv/www
sudo setfacl -m g:swg-admins:rwx /srv/www
sudo setfacl -d -m g:swg-admins:rwx /srv/www


