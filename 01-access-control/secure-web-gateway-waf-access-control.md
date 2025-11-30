
# Secure Web Gateway & WAF – Erişim Kontrolü Yapılandırması

Bu bölümde proje kapsamında web servisinin güvenli biçimde çalışması için gerekli olan 
kullanıcı, grup, izin ve ACL ayarları yapılmıştır. Yapılandırmanın amacı, sistemde en az yetki ilkesini 
uygulamak, yetkilerin doğru şekilde sınırlandırılmasını sağlamak ve web dizinini yalnızca ilgili grup üyeleri 
tarafından yönetilebilir hale getirmektir.

---

## 1. Grup ve Kullanıcıların Oluşturulması

Proje için özel bir yönetim grubu oluşturulmuştur:

```
sudo groupadd swg-admins
```

Ardından bu gruba bağlı iki kullanıcı eklenmiştir:

```
sudo useradd -m -G swg-admins gateway
sudo useradd -m -G swg-admins wafengine
```

Bu kullanıcılar yalnızca proje kapsamında belirlenen görevleri yerine getirebilmesi için izole edilmiştir.

---

## 2. Web Dizininin Oluşturulması ve Sahiplik Ayarları

Web içeriğinin yönetileceği dizin oluşturulmuştur:

```
sudo mkdir -p /srv/www
```

Dizinin sahibi root, grup ise swg-admins olarak ayarlanmıştır:

```
sudo chown root:swg-admins /srv/www
```

Bu ayar sayesinde dizin, sistem yöneticisi tarafından kontrol edilirken yazma yetkisi yalnızca ilgili gruba verilmiştir.

---

## 3. SGID Bitinin Aktifleştirilmesi

Dizin üzerinde SGID (Set Group ID) biti aktif edilmiştir:

```
sudo chmod 2775 /srv/www
```

Bu işlem, dizin içinde oluşturulan tüm dosya ve klasörlerin otomatik olarak swg-admins grubuna ait olmasını sağlar. 
Yetkilerin tutarlı şekilde devam etmesi için SGID kritik öneme sahiptir.

---

## 4. ACL İzinlerinin Uygulanması

Grubun yazma yetkisine sahip olması, diğer tüm kullanıcıların ise dizine erişiminin kapatılması için ACL 
kuralları uygulanmıştır:

```
sudo setfacl -m g:swg-admins:rwx /srv/www
sudo setfacl -d -m g:swg-admins:rwx /srv/www
sudo setfacl -m m:rwx /srv/www
sudo setfacl -d -m m:rwx /srv/www
sudo setfacl -d -m other:--- /srv/www
```

Bu kurallar, hem mevcut dizin için hem de dizin içinde sonradan oluşturulacak öğeler için geçerli olacak şekilde 
tanımlanmıştır.

---

## 5. Yapılandırmanın Doğrulanması

Aşağıdaki komut ile ACL ve SGID yapılandırmaları doğrulanmıştır:

```
getfacl /srv/www
```

Bu komutun çıktısı ödeve dosya olarak eklenmiştir.

---

## Sonuç

Bu yapılandırmalar sonucunda web dizini üzerinde yalnızca ilgili grubun tam yetkiye sahip olması sağlanmış, diğer 
kullanıcıların erişimi tamamen engellenmiştir. SGID ve ACL kurulumları, en az yetki ilkesine uygun şekilde 
uygulanmış ve proje gereksinimleri tam olarak karşılanmıştır.
