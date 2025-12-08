# Secure Web Gateway & WAF – AKİS Proje 1

Bu repo, **Açık Kaynak İşletim Sistemleri (AKİS)** dersi kapsamında geliştirilen  
**“Secure Web Gateway & WAF (Web Application Firewall)”** projesinin kaynak kodlarını ve dokümantasyonunu içerir.

Projenin amacı; Linux üzerinde çalışan bir **Nginx** sunucusu için:

- Kimlik ve erişim kontrolü (kullanıcı / grup, ACL, SGID, least privilege),
- Komut satırı ile süreç (process) yönetimi,
- Nginx access log’ları üzerinden **metin işleme pipeline’ı** ile rapor üretme,
- `journalctl` kullanarak Nginx / SSH / UFW / kernel log’larından **güvenlik odaklı özet** çıkarma

adımlarını **hafta hafta** uygulamaktır.

---

## 🎯 Amaç ve Kapsam

Bu proje ile:

- Basit bir web sunucusundan ziyade, **güvenlik odaklı bir “Secure Web Gateway / WAF” bileşeni** tasarlamak,
- Linux yetki sistemi (kullanıcı, grup, ACL, SGID) kullanarak **least privilege** prensibini uygulamak,
- `ps`, `awk`, `grep`, `sort`, `uniq`, `regex` gibi araçlarla **process ve log analizi** yapmak,
- `journalctl` üzerinden servis ve kernel log’larını okuyup **güvenlikle ilişkili olanları seçerek** raporlamak hedeflenmiştir.

---

## 🧩 Sistem Gereksinimleri

- Ubuntu 24.04 (veya systemd kullanan benzer bir Linux dağıtımı)
- Nginx
- systemd (journalctl)
- Bash shell
- (Opsiyonel) UFW (Uncomplicated Firewall)

---

## 📂 Dizin Yapısı

```text
secure-web-gateway-waf/
├── 01-access-control/
│   ├── secure-web-gateway-waf-access-control.md
│   └── getfacl_output.txt
├── scripts/
│   ├── run.sh
│   └── waf_journal_logs.sh
├── hafta2_rapor.txt
├── hafta2_journalctl_rapor.txt  (script çalışınca oluşur)
├── LICENSE
└── README.md

---

## kullanılan komutlar
sudo groupadd swg-admins
sudo useradd -m -G swg-admins gateway
sudo useradd -m -G swg-admins wafengine
sudo mkdir -p /srv/www
sudo chown root:swg-admins /srv/www
sudo chmod 2775 /srv/www
sudo setfacl -m g:swg-admins:rwx /srv/www
sudo setfacl -d -m g:swg-admins:rwx /srv/www
LOG="/var/log/nginx/access.log"

