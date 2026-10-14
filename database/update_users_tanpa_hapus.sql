-- Hanya jalankan bila database asuransi_jiwa lama sudah terpasang.
-- Tidak ada penghapusan data atau tabel lama.
USE `asuransi_jiwa`;
ALTER TABLE `users` MODIFY COLUMN `password` VARCHAR(255) DEFAULT NULL;
