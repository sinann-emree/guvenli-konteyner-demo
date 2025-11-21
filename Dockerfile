# --- ADIM 1: Minimal Temel İmaj ---
# Standart imaj yerine "alpine" (hafifletilmiş Linux) kullanıyoruz.
# Bu, saldırı yüzeyini %90 oranında küçültür.
FROM node:22-alpine

# --- ADIM 2: Güvenlik Ayarları ---
# Çalışma klasörünü ayarlıyoruz.
WORKDIR /app

# Önce sadece bağımlılık listesini kopyalıyoruz (Hız için).
COPY package*.json ./

# Sadece üretim için gerekli paketleri kuruyoruz (Test araçlarını almayız).
RUN npm install --production

# --- ADIM 3: Kaynak Kodları Kopyalama ---
COPY . .

# --- ADIM 4: Yetki Kısıtlama (Çok Önemli!) ---
# Konteyner varsayılan olarak "root" (süper yönetici) ile çalışır.
# Güvenlik için yetkisiz "node" kullanıcısına geçiyoruz.
USER node

# Uygulamanın portunu belirtiyoruz.
EXPOSE 3000

# Uygulamayı başlatıyoruz.
CMD ["node", "server.js"]