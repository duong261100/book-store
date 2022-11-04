-- --------------------------------------------------------------------------------
--  Program Name:   book_store.sql
--  Creation Date:  03/10/2022
-- --------------------------------------------------------------------------------

DROP DATABASE IF EXISTS `book_store`;
CREATE DATABASE `book_store`;
USE `book_store`;

-- ------------------------------------------------------------------
-- Create USER table.
-- ------------------------------------------------------------------

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  `email` VARCHAR(50) NOT NULL UNIQUE,
  `password` TEXT NOT NULL,
  `fullname` VARCHAR(50),
  `address` VARCHAR(200),
  `image` TEXT,
  `is_activate` BOOLEAN NOT NULL DEFAULT 0,
  `is_admin` BOOLEAN NOT NULL DEFAULT 0,
  `refresh_token` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ------------------------------------------------------------------
-- Create AUTHOR table.
-- ------------------------------------------------------------------

DROP TABLE IF EXISTS `author`;
CREATE TABLE `author` (
  `author_id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `image` TEXT,
  `description` TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ------------------------------------------------------------------
-- Create PUBLISHER table.
-- ------------------------------------------------------------------

DROP TABLE IF EXISTS `publisher`;
CREATE TABLE `publisher` (
  `publisher_id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ------------------------------------------------------------------
-- Create LANGUAGE table.
-- ------------------------------------------------------------------

DROP TABLE IF EXISTS `language`;
CREATE TABLE `language` (
  `language_id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  `language_name` VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ------------------------------------------------------------------
-- Create BOOK table.
-- ------------------------------------------------------------------

DROP TABLE IF EXISTS `book`;
CREATE TABLE `book` (
  `book_id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  `author_id` INT UNSIGNED,
  `publisher_id` INT UNSIGNED,
  `language_id` INT UNSIGNED,
  `title` VARCHAR(200),
  `image` TEXT,
  `price` DECIMAL NOT NULL DEFAULT 0,
  `stock` INT UNSIGNED NOT NULL DEFAULT 0,
  `rating` FLOAT(2, 1) UNSIGNED DEFAULT 0,
  `rating_count` INT UNSIGNED DEFAULT 0,
  `description` TEXT,
  `publication_date` DATE,
  CONSTRAINT `book_fk1` FOREIGN KEY (author_id) REFERENCES `author` (author_id),
  CONSTRAINT `book_fk2` FOREIGN KEY (publisher_id) REFERENCES `publisher` (publisher_id),
  CONSTRAINT `book_fk3` FOREIGN KEY (language_id) REFERENCES `language` (language_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ------------------------------------------------------------------
-- Create CATEGORY table.
-- ------------------------------------------------------------------

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `category_id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ------------------------------------------------------------------
-- Create BOOK_CATEGORY table.
-- ------------------------------------------------------------------

DROP TABLE IF EXISTS `book_category`;
CREATE TABLE `book_category` (
  `book_id` INT UNSIGNED,
  `category_id` INT UNSIGNED,
  PRIMARY KEY (book_id, category_id),
  CONSTRAINT `book_category_fk1` FOREIGN KEY (book_id) REFERENCES `book` (book_id),
  CONSTRAINT `book_category_fk2` FOREIGN KEY (category_id) REFERENCES `category` (category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ------------------------------------------------------------------
-- Create RATING table.
-- ------------------------------------------------------------------

DROP TABLE IF EXISTS `rating`;
CREATE TABLE `rating` (
  `user_id` INT UNSIGNED,
  `book_id` INT UNSIGNED,
  `rating` INT UNSIGNED NOT NULL,
  `review` TEXT,
  `date_time` DATETIME DEFAULT (CURRENT_TIMESTAMP),
  PRIMARY KEY (user_id, book_id),
  CONSTRAINT `rating_fk1` FOREIGN KEY (user_id) REFERENCES `user` (user_id),
  CONSTRAINT `rating_fk2` FOREIGN KEY (book_id) REFERENCES `book` (book_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ------------------------------------------------------------------
-- Create STATUS table.
-- ------------------------------------------------------------------

DROP TABLE IF EXISTS `status`;
CREATE TABLE `status` (
  `status_id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ------------------------------------------------------------------
-- Create ORDER table.
-- ------------------------------------------------------------------

DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `order_id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  `user_id` INT UNSIGNED,
  `order_date` DATE DEFAULT (CURRENT_DATE),
  `description` TEXT,
  `status_id` INT UNSIGNED,
  CONSTRAINT `order_fk1` FOREIGN KEY (user_id) REFERENCES `user` (user_id),
  CONSTRAINT `order_fk2` FOREIGN KEY (status_id) REFERENCES `status` (status_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ------------------------------------------------------------------
-- Create ORDER_DETAIL table.
-- ------------------------------------------------------------------

DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail` (
  `order_id` INT UNSIGNED,
  `book_id` INT UNSIGNED,
  `quantity` INT UNSIGNED,
  PRIMARY KEY (order_id, book_id),
  CONSTRAINT `order_detail_fk1` FOREIGN KEY (order_id) REFERENCES `order` (order_id),
  CONSTRAINT `order_detail_fk2` FOREIGN KEY (book_id) REFERENCES `book` (book_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ------------------------------------------------------------------
-- Create trigger AFTER_RATING_BOOK.
-- ------------------------------------------------------------------

DROP TRIGGER IF EXISTS after_rating_insert;
CREATE TRIGGER after_rating_insert
AFTER INSERT ON rating
FOR EACH ROW
	UPDATE book
	SET
		rating = (book.rating * book.rating_count + NEW.rating) / (book.rating_count + 1),
        rating_count = rating_count + 1
	WHERE
		book.book_id = NEW.book_id;


-- ------------------------------------------------------------------
-- Seed USER table.
-- ------------------------------------------------------------------

INSERT INTO `user` (`email`, `password`, `fullname`, `address`, `image`, `refresh_token`)
	VALUES ("vubinhduong2611@gmail.com", "$2b$08$CePHGSUr2OErGEx8h/iDFu0DN9McneVhs/whHtMBID1snc2xTFG7W", "123456", "Số nhà 15H, ngách 5 ngõ 22 Lương Khánh Thiện, Hoàng Mai, Hà Nội", "https://firebasestorage.googleapis.com/v0/b/book-store-41a6b.appspot.com/o/1667201591386.121043192_985746461943784_7600699231661987854_n?alt=media&token=b84d74d5-e56e-42fc-a2ce-b496e742577c", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IjEyMzQ1NiIsImlhdCI6MTY2NjAwMDAxNX0.3RZcUmTvJTmi5kzxt8RaRgYxsE7xUJnDvl2nnlm57fk");
INSERT INTO user (`email`, `password`, `fullname`, `address`, `is_activate`, `is_admin`, `image`, `refresh_token`)
	VALUES ("admin@gmail.com", "$2b$08$pPm48hDMbGjaPlybTF4i.ekE1lj/gsKBZzdDKZSQDnjkjYyX.9Qmu", "Vũ Bình Dương", "Số nhà 15H, ngách 5 ngõ 22 Lương Khánh Thiện, Hoàng Mai, Hà Nội", 1, 1,"https://storage.googleapis.com/book-store-41a6b.appspot.com/1667411193998.received_440005004124467?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=Eu%2FxUco%2B9FEZLomFaQGSH7Zon1udq7cKioUbRmgabiBvwiNWRJBJkdDFThMN3wlb5JnHVtFZiTygNzutfxyumJ3ahXAUcX5aTi1phd9nRPlf%2FiSPVbjRyu3jBberbZCfnrUrZ3jA%2FY8KRQx8o5jgPPpVF2suUs7e%2B4V%2FSXJ8jEBuOY25%2FzEoz%2BX7aCMQoQAy3YMXTGb1AKCpx%2BEAX3w0fxGz%2FLCU3IQChYC8XHd0sFOemrBueCWzz8rbhKNdmHM9%2FYCUlr17Mu8pWN2nExr0EBJXL%2F6s6%2F2iRWr1r7VPctnEiQrsgFihHDdEi6%2Fjcz9PBM1qkqU79eeGzHvhGa9JTA%3D%3D", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTY2NzQxMDA4Nn0.rYGayu_wLV1QSH8HLrNm3i2Q47uOX3NWQ-j893Aqz8s");
INSERT INTO user (`email`, `password`, `fullname`, `address`, `is_activate`, `image`, `refresh_token`)
	VALUES ("user@gmail.com", "$2b$08$ObWUNe2sBugSvMj0gDh3D.rNsbidC2tsBh9t6kL1Ll1FxCuM5tUfm", "Dương 123", "Số nhà 15H, ngách 5 ngõ 22 Lương Khánh Thiện, Hoàng Mai, Hà Nội", 1, "https://storage.googleapis.com/book-store-41a6b.appspot.com/1667411293360.post-image-1?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=rqfkHCI18Kd4GPAct0QXw%2BiaN3h8cpTt1I32idOzQQh%2FE8NUGFsi3TJwXGyfMlXlZjRLASDosr5w7hfsdVJRaBnKV1EEg4QUFBUh2FiOt5TP1b1xeSI2zOBNWb4ygPoXEYhMrybTWbjfLzowSg9UFLJnTthb8C0uPhuLb5xqWmvtGC5f4PGpnwWZGNjwBuePuiLCDptAccVRrIIrZjtzJyWDiA61sdRMoGIFb5TsI3gNQLKiUgmVRIH7VZLUbZpRFi5c7MaPaRsXYwg6UkUTJUngYjxdHT7jnoNMc9RDPXBX%2BU8M%2B9lreBlxXN0LO6mdNv7tG%2F5MykEiySd3GLB8YQ%3D%3D", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InVzZXJAZ21haWwuY29tIiwiaWF0IjoxNjY3NDEwMDU1fQ.4NA9PPRRKMwliZWm3z0SmJcZr5P8yqCY5QZFCW1ZF3U");

-- ------------------------------------------------------------------
-- Seed AUTHOR table.
-- ------------------------------------------------------------------
    
INSERT INTO `author` (`name`, `image`, `description`)
	VALUES ("Riku Onda", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666860355833.author-1?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=B7rsax4di5LdjMWDTIdhveTVBkXQ2QiAJRmfMDZ4nL3KPY5I47aanWLCqPINSO%2F2L8cK9N6wQjPVMO2Lq%2BMyQXDtiTkAwDZ32uwgELEgl3B9m3jWqQk4FA02wE6e7wyWoj22dFJ85C48Ousqz0YESzeFfFaJS4ewbPPZGBfsM5EMoo2VzD4jG7JYvl43BQ1bHSuit9tAlUoxjfAW%2FJWi4x0Hu%2Fgwg45EVHNE9f09QR66ojTldha2%2F53RgAjguYL9Xv%2FGC60nVfayYqvoLFRP8vfLsTB0NRxbDSxrqNy1xPA7kTYgclD4i4gDBXnZxGQ28XEAnBG4YX7SzIHIvfcxjQ%3D%3D", "Sinh năm 1964. Năm 1992, ra mắt tác phẩm đầu tay mang tên Rokubanme no sayoko. Năm 2005, đạt Giải thưởng Văn học Yoshikawa Eiji lần thứ 26 dành cho nhà văn triển vọng và Giải thưởng Honya lần thứ 2 với tác phẩm Yoru no picnic (Huy Hoàng dự kiến xuất bản năm 2022). Năm 2006, đạt Giải thưởng của Hiệp hội trinh thám Nhật Bản lần thứ 59 với tác phẩm Eugenia. Năm 2007, đạt Giải thưởng Yamamoto Shugoro lần thứ 20 với tác phẩm Nakaniwa no dekigoto.");
INSERT INTO `author` (`name`, `image`, `description`)
	VALUES ("Nguyễn Nhật Ánh", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666860568880.author-2?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=VWxbKNqAp%2BwC%2BaaoQwNc0MeBJrhF0FxUf4hTMO4C%2Fcv6NBUNClIkMkZIN5oKM%2Fpp94ezl0iMDh8eDgYNlJCAq9Y2wPBDWUcMcE7xWkTxwQqogWyJppGnwppcqVICbXw7HHEmeqBzJgXf%2BPRDIrRSO7RqL%2BNBGGd7VU4Ofe47bTqDgjrp00OxaXyL6gjhZoZAZ3Iu3NrAt%2B2dx3bBDcfSSSfYsup4%2BKgvKhkdGMDtTkDVhl3WEjRDC2%2BQjxSAUfIew9Dukf%2B9Ta%2BZgDu4pnJtOMEgrld%2BFIyEcD3y01nM5gXBw1VMH8F%2B5FPQMXYNQByrIieyFSsIP7SzfE5zAjK7wA%3D%3D", "Nguyễn Nhật Ánh (sinh ngày 7 tháng 5 năm 1955) là một nhà văn người Việt. Ông được biết đến qua nhiều tác phẩm văn học về đề tài tuổi mới lớn, các tác phẩm của ông rất được độc giả ưa chuộng và nhiều tác phẩm đã được chuyển thể thành phim. Ông lần lượt viết về sân khấu, phụ trách mục tiểu phẩm, phụ trách trang thiếu nhi và hiện nay là bình luận viên thể thao trên báo Sài Gòn Giải phóng Chủ nhật với bút danh Chu Đình Ngạn. Ngoài ra, ông còn có những bút danh khác như Anh Bồ Câu, Lê Duy Cật, Đông Phương Sóc, Sóc Phương Đông,...");
INSERT INTO `author` (`name`, `image`, `description`)
	VALUES ("Trang Hạ", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666860600942.author-3?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=J7k3iwqv%2FMzJ%2FiMqwQaFvYOg6WDcG4I7c3Xg1sBYeyRPVZMQGwJA6stB%2BtrHVKzyFoF0pdtH8x3JY5Xb7Cpe9qyDufK2ySaUi0KOBxJ%2BfP9QTDs8B0%2B5Pd37v78hQJ9nKycJoiTjowAYrt%2FH7%2FxBSNnZlSXlReBLR495ptBjyTvzHQOlEZbHXvTWfuGoPPzBSibxlso1XTprMl9Z92ZL70GnUXRXkWGNxsfweJ%2BUETBy%2Byu0SfDOcGBT4FP9rwIZYtnQoJKoo6kHna384hguxOwolay%2FC2tplHQtCO4O%2FUVLXBPGSr3b8vqEEkbmn%2F8DlsplaL0pwYP79MSgqgJU8g%3D%3D", "Nhà văn Trang Hạ, tên thật là Hạ Trịnh Minh Trang. Sinh ngày 30 tháng 11 năm 1975 tại Hà Nội - Việt Nam. Cô từng là bút trưởng thế hệ đầu của Hội bút Hương đầu mùa của báo Hoa học trò vào những năm đầu của thập niên 1990. Từ lúc đi học, cô đã bộc lộ rõ là một cô gái có tài viết văn tốt cùng với góc nhìn nhận, đánh giá quan điểm tinh tế và nhạy bén. Cô là một cây bút nữ viết truyện ngắn và dịch truyện nổi đình đám ở Hà Nội. Với phông văn hoá tiếng Trung dày dặn, sự am hiểu sâu sắc nền văn hóa Trung hoa và được tiếp cận với đất nước Trung quốc trong một thời gian dài nên những tác phẩm của Trang Hạ mấy năm gần đây thường tạo nên 'kỉ lục' về hiện tượng xuất bản.");
INSERT INTO `author` (`name`, `image`, `description`)
	VALUES ("Anh Khang", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666860677637.author-4?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=dmHjhxihMqpeQVko2%2B9ofniyhvfyVP0rbeVskYu0gI3%2BjZYci5%2FC2JaZv0EEwGQoBsF4LZvgyeMQTUz5WSDoM7oVudzAupTEzpVLcTc0xrR30ulHglNXhfFQ9W5b3kbqKUTBDdcyDWNm1CeSwwJ2fUWpGoSbF6Q31wvhBiHftyTfkD8hHTqpcrnWl66kwVxcsKgKH4jabImGDHx26l4uOg6KCBUVZ5Rp0QCpIFohSSWRsi635DrOk%2BlTzm%2FjfBkgxs0Kjb89WJfdXIqptPH7LT5IXoWpgz0fIAKeeWAcfVnd6BxILw3CvULDXLLkQb6vRMyfwPVHL6KBS9fvznJ0Qw%3D%3D", "Anh Khang tên đầy đủ là Quách Lê Anh Khang. Sinh ngày 11/8/1987. Là cử nhân khoa Báo chí và Truyền thông - Đại học Khoa học Xã hội và Nhân văn Tp. Hồ Chí Minh. Năm 2012, Anh Khang ra mắt tác phẩm đầu tay - Tản văn Ngày trôi về phía cũ. Đến 2013 đã được tái bản lần thứ 4 với tổng số hơn 20,000 ấn bản. Đây có thể coi là một tiếng vang đối với nhà văn trẻ như Anh Khang khi ra mắt đứa con tinh thần đầu tiên.");
INSERT INTO `author` (`name`, `image`, `description`)
	VALUES ("J. R. R. Tolkien", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666860703962.author-5?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=WgqXZ%2BTr71gnJUxb5vc31UrXV6%2BkiufVrDLey6HQlD901E5pf%2B63CZ30heLT2XWY1stuUfngzwMza4T2VnBcuFSn89m24ga%2FTki34pogWkuxt%2F3fT0FFEm%2BbWP04kVrYiKnUhyR%2FT4XMIHjbl9GNeaapdNZ2OtDEB2A0A0zBE0PNRMJZEFt1TveU4FurE0vY9x2C6PWchWFDvqK%2BDAgZhT1X7KSEQGlBR3lfcw7RFoSXFORZzPdimRebqCuUSwnuejfF3Zyj8WeBxTAj2g45dp6o5bHlxJUUFn5bYoGdOKiBXPfn8xEh9T%2FejECfr9o6O3s4TC4z6FjYo2IL%2B3ixXw%3D%3D", "John Ronald Reuel Tolkien, một nhà ngữ văn, tiểu thuyết gia, và giáo sư người Anh, được công chúng biết đến nhiều nhất qua các tác phẩm The Hobbit và Chúa tể những chiếc nhẫn (The Lord of the Rings). Ông giảng dạy về ngôn ngữ Anglo-Saxon tại đại học Oxford từ những năm 1925 đến 1945, và sau đó ông giữ ghế Giáo sư Merton đầu ngành ngôn ngữ và văn học Anh cũng tại Oxford từ 1945 đến 1959. Tolkien là bạn thân của C. S. Lewi – tác giả của bộ truyện Biên niên sử Narnia (The Chronicles of Narnia), cả hai cùng là thành viên của nhóm văn sĩ nổi tiếng Inklings. Ông được Nữ hoàng Elizabeth II phong tước CBE (Commander of the Order of the British Empire) năm 1972.");
INSERT INTO `author` (`name`, `image`, `description`)
	VALUES ("Nguyễn Ngọc Tư", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666860784422.author-6?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=srrKB2CEpTIJj4sMSoEYmV%2Fock1QYHuHKESFSzeAZupOd7XXzTSCWrkWH%2FV35%2Bg67piE5VJStfaYoPu1ZCB9GGMSghWas1jh4hWPBGNPUHpOxDUbPHBy9cm0c8j%2FsgXs6rtWWMY5W771g4AsJpMH6JopksTuW%2BhNqBxTuDZlX9m70LI058uuFIjWdHQsSpLvbNxk5VP7oLigFD4WmhvzTFwEdSb88GMrtD2cBaLLHfBkqbnQgDp%2BTIzYwUWFBc30yqUN4EDeCTeuANrNaMRLYjo9wJPcrLWxaTdjJ%2BdMWyATlgHo83u4wogCdrLuiLV9aMtkdIVi%2Btawb4aHJYjkcw%3D%3D", "Nguyễn Ngọc Tư sinh năm 1976 tại Đầm Dơi, Cà Mau. Là nữ nhà văn trẻ của Hội nhà văn Việt Nam. Với niềm đam mê viết lách, chị miệt mài viết như một cách giải tỏa và thể nghiệm, chị biết rằng chị muốn viết về những điều gần gũi nhất xung quanh cuộc sống của mình. Giọng văn chị đậm chất Nam bộ, là giọng kể mềm mại mà sâu cay về những cuộc đời éo le, những số phận chìm nổi. Cái chất miền quê sông nước ngấm vào các tác phẩm, thấm đẫm cái tình của làng, của đất, của những con người chân chất hồn hậu nhưng ít nhiều gặp những bất hạnh.");
INSERT INTO `author` (`name`, `image`, `description`)
	VALUES ("Tô Hoài", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666860804365.author-7?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=kL6Q979pDHjEvpalzRGGwlMV1WQXxjnToDLZkxPfAqYnizTciOtpA9%2B85QaRiGMZWyFXwYs%2BOhnYs1Wr%2B3bksfFob97SF7wuNNb8CGG7bNqpBNOgY567aoRoLIJfGfhAs1lCaE1nmAkiHxAPjeTotsA2qtjvIOiwWc%2Ff3nbI4gifCybNi7ZGAVy0Yr6V0l%2B%2Fd3JR7USrihvVTOjbTCKJziCH1bqE4Y4OUIbZHs2YgD8Zbt0bEugswDlymcrvYSNv07kH4UiNFKvVU0oUJayicP7Nxrol6FxQHLPExTaOO9aSjGlPpuISq4GUfUJ0bP2nBlm8Buui2Hrx1e9tsIEkkQ%3D%3D", "Tô Hoài (tên khai sinh: Nguyễn Sen; 27 tháng 9 năm 1920 – 6 tháng 7 năm 2014) là một nhà văn Việt Nam. Một số tác phẩm đề tài thiếu nhi của ông được dịch ra ngoại ngữ. Ông được nhà nước Việt Nam trao tặng Giải thưởng Hồ Chí Minh về Văn học - Nghệ thuật Đợt 1 (1996) cho các tác phẩm: Xóm giếng, Nhà nghèo, O chuột, Dế mèn phiêu lưu ký, Núi Cứu quốc, Truyện Tây Bắc, Mười năm, Xuống làng, Vỡ tỉnh, Tào lường, Họ Giàng ở Phìn Sa, Miền Tây, Vợ chồng A Phủ, Tuổi trẻ Hoàng Văn Thụ.");
INSERT INTO `author` (`name`, `image`, `description`)
	VALUES ("Nguyên Hồng", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666860827525.author-8?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=l66AaVxK3WlVqCl6Kmk3rx4QYLIfFZLv83EIXP72wOsvPBrlMLiNCmvWCQev8bdO5hj6uYSrIeGb5yyZtOU2wwPo402WyeZiWr67CgYHUlkz04aUNQKoXP0%2FJlJjlruBX48zoO9GAkPU9ltYFnTNvdtMfjlgcXqH3Iup4JZTu15%2BA10j5VhCbcTMa6mzcxiAUBloajQnZd6fggmdntVx%2BSHX1ZsBFg5azTUUHpI1Kf7hLN7y0n8bF2fqX2Wghtdtu97SKl8GKoHvNUq%2F8JCep%2F33lKDJRwSDDVZiEzCX1vaPQ7Auy2%2Fe5PnXdH9jZOirdXSdpWkhb0uJoEmcKMwe4w%3D%3D", "Tên thật của ông là Nguyễn Nguyên Hồng, sinh ngày 5 tháng 11 năm 1918 tại Vụ Bản, Nam Định. Sinh trưởng trong một gia đình nghèo, mồ côi cha, ông từ nhỏ theo mẹ ra Hải Phòng kiếm sống trong các xóm chợ nghèo. Nguyên Hồng ham đọc sách từ nhỏ. Ông thường dành tiền thuê sách để đọc và dường như đọc hết những quyển sách mình thích ở cửa hàng cho thuê sách tại Nam Định. Loại sách Nguyên Hồng thích thuở nhỏ là truyện lịch sử Trung Hoa, trong đó những nhân vật có khí phách ngang tàng, trung dũng, những hảo hán chiếm cảm tình của ông nhiều nhất.");
INSERT INTO `author` (`name`, `image`, `description`)
	VALUES ("Nguyên Ngọc", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666860846388.author-9?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=p3lmbCLOy12RFJW7fPM78rsdyN%2Brf2%2BuVUyEJcK6pqx8R3TgD0NvCwQqZIYnRuko%2FfmZ5jhxRmBIfyoUBm8ktwPlM2T3iXTYkNhBVfZalr98C2t7ln8vfamwX2QwQyKvDFe0%2BCuVCR%2B1c%2F1boHByI6G7v4KR9hHiXoHiJdpX%2B9jduZzfzPS8wgrWFnUNuT51iw847pMXtKp0Dv%2BtgSE%2B9ueUyaCJc67NpWHKqLhmQW%2FkXxkqfekW9zfwYK3uHDoVV%2BYem2doqDMNE%2BwdPIAi1lBrm0B1DsZBLSMhDdEAWmZEVU7L6EFoCgKFAv6kiAv5dBANcAD52FTwARqhRGrI3g%3D%3D", "Nguyên Ngọc là bút danh của Nguyễn Văn Báu (ngoài ra ông còn có bút danh Nguyễn Trung Thành), sinh năm 1932 tại xã Bình Triều, huyện Thăng Bình, tỉnh Quảng Nam. Ông là nhà văn, nhà báo, dịch giả, nhà nghiên cứu văn hóa có bề dày và chiều sâu sáng tác cũng như thái độ làm việc nghiêm túc trong nghệ thuật");
INSERT INTO `author` (`name`, `image`, `description`)
	VALUES ("J. K. Rowling", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666860864898.author-10?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=S0jakgwne63GP4h0JHgR5V2UNlvtFh6VTBK0tjbyBxL4V8aRtYDdCPPGR1zBGvzxnUvnPGdNHkYtayDTwn4aq5qu7RTtjbRQ418354YsUEx%2B6zCxxzuQQvkpzZFx9TmsJrhrAp9NDJVaIPdig9MlZjrLzBO1QqMzVstOAQM7EZR4n%2FxFUjCVSgYfu3tDkzIWncTOW%2BYibDyCYpvEP7T9P%2FriJ1JCnpV7wX8vztQW6ptyeV5jf80KnnobTdQfSzMWFtrfADmzG3TL1orawDvotYN8WEnBXZhgsxMKGUEPVAaveSqo0L4t5R9WcoQheqDXfVVNiodkcg6eWd40LSjo8Q%3D%3D", "J.K. Rowling là tác giả của bộ tiểu thuyết Harry Potter, đã đạt nhiều giải thưởng và có con số phát hành kỷ lục. Bộ sách được bạn đọc trên khắp thế giới yêu chuộng, đã bán được hơn 500 triệu bản, được dịch sang 80 thứ tiếng và dựng thành tám tập phim bom tấn. Bà đã viết ba ngoại truyện vì mục đích từ thiện: Quidditch qua các thời kỳ, Những sinh vật huyền bí và nơi tìm ra chúng (để hỗ trợ cho quỹ Comic Relief và Lumos), và Những câu chuyện của Beedle người hát rong (hỗ trợ cho quỹ Lumos), cũng như kịch bản phim những sinh vật huyền bí và nơi tìm ra chúng, khởi đầu cho loạt phim năm sau được viết bởi chính tác giả truyện gốc.");


-- ------------------------------------------------------------------
-- Seed PUBLISHER table.
-- ------------------------------------------------------------------

INSERT INTO `publisher` (`name`)
	VALUES ("NXB Harper Collins");
INSERT INTO `publisher` (`name`)
	VALUES ("NXB Trẻ");
INSERT INTO `publisher` (`name`)
	VALUES ("NXB Kim Đồng");
INSERT INTO `publisher` (`name`)
	VALUES ("NXB Phụ Nữ Việt Nam");
INSERT INTO `publisher` (`name`)
	VALUES ("NXB Hội Nhà Văn");


-- ------------------------------------------------------------------
-- Seed LANGUAGE table.
-- ------------------------------------------------------------------

INSERT INTO `language` (`language_name`)
	VALUES ("Tiếng Việt");
INSERT INTO `language` (`language_name`)
	VALUES ("Tiếng Anh");
INSERT INTO `language` (`language_name`)
	VALUES ("Tiếng Nhật");
INSERT INTO `language` (`language_name`)
	VALUES ("Tiếng Trung");


-- ------------------------------------------------------------------
-- Seed BOOK table.
-- ------------------------------------------------------------------

INSERT INTO `book` (`author_id`, `publisher_id`, `language_id`, `title`, `image`, `price`, `stock`, `description`, `publication_date`)
	VALUES (5, 1, 1, "The Lord of the Rings #1: The Fellowship of the Ring", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666861780801.book-1?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=Al5wEGvxiArtzhyRhWF78Jk7qnYDoe3uB%2F5GOkJsNgLI3rZFbEzOGo3mPs2Jj0yGJ62uZpE5zMe1tROE6TeKCesKAi21s2u7YfuoswB9mxgkTtLQima2znyv9N9X%2FeuVc4ehszpzBwkz%2F1TnzOtSc%2FsHN5tFd9sWRBNjerijU5l2uh22%2FZANF1fdhw6TH14%2BhXyo7l%2BbQ07xt%2Bm4vXKWmwg4z6w4RoM55ZfIf3DgVnSzWt%2FloiuW%2BRetKlXISDCnbU5zzgj1BDdyA8iF0TnOeXPHxQeFJlfS0hSuZXolFGAWHMDoRni8cwwweInI86%2Foe44BNnwOgjlG5w9h2i0Bqw%3D%3D", 134000, 37, "In a sleepy village in the Shire, a young hobbit is entrusted with an immense task. He must make a perilous journey across Middle-earth to the Cracks of Doom, there to destroy the Ruling Ring of Power – the only thing that prevents the Dark Lord Sauron’s evil dominion. Thus begins J. R. R. Tolkien’s classic tale of adventure, which continues in The Two Towers and The Return of the King.", '2021-9-24');
INSERT INTO `book` (`author_id`, `publisher_id`, `language_id`, `title`, `image`, `price`, `stock`,  `description`, `publication_date`)
	VALUES (1, 4, 1, "Ong Mật Và Sấm Rền", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666861806954.book-2?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=DTuobMNX6Rk1v5qxhUMwf1ganWMMmPrHqzR%2FHuwJshqULVPt5nTHcyprzySMLlv6HtD5M9gJbRKxtBRKUdGfmX%2F3mi3D8qQNvpubJUql22bvWRPzjiD%2BBg7f%2FqiSu8I4RVbeslMg5dCMxpnohAqdG3MJKj5xIlvlIGD1AQYM5PwLM7pjx6qw1L2rgfroVWNejVLGv6TnKQOpRp0PZcnJUKBy2GjsvG49KzAFRrDy%2F1KAGgUqPpyO4pYgIK8xkEnS%2BSDRzJ7VbdX1nuyeeiu0haSIzvIB7PIavrPw9OcFiI1mYsH2hgOTmcI6E2deLgFW1gHMB0uUyCLi%2Ff122ZUNqw%3D%3D", 252000, 42, "Được xây dựng ý tưởng, thu thập thông tin trong 10 năm và chắp bút trong 7 năm, Ong Mật Và Sấm Rền là cuốn tiểu thuyết thanh xuân lấy bối cảnh Cuộc thi Piano Quốc tế Yoshigae, khắc họa tài năng, số phận và âm nhạc của con người. Hội diễn Piano quốc tế Yoshigae diễn ra mỗi ba năm một lần, năm nay đã sang lần thứ sáu và là một hội diễn vô cùng danh tiếng. Tham gia cuộc thi này đều là những tài năng âm nhạc thật sự, nhưng họ lại đến đây với những mục tiêu khác nhau. Có người chọn đây là bước ngoặt quan trọng, một cú nhảy vọt trong sự nghiệp, có người lại ôm hi vọng làm bừng cháy lên niềm đam mê đang dần lụi tàn, lại có người chọn đây là dấu chấm hết cho niềm đam mê âm nhạc, một lần tỏa sáng rồi từ bỏ tất cả.", '2022-9-24');
INSERT INTO `book` (`author_id`, `publisher_id`, `language_id`, `title`, `image`, `price`, `stock`,  `description`, `publication_date`)
	VALUES (2, 2, 1, "Có Hai Con Mèo Ngồi Bên Cửa Sổ", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666861823023.book-3?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=rGQIIcyZGNsk56ySpRfRm5pqdVx9nlSlgCnhqOo6vCzsvg%2FVRC8lSRsU4wlwtqKCadSoSc2LALLTB%2FLQDzTyAo1MNxk9p5mqUU%2BamrW76HALnjzCjCwNy321T9OfJgG%2B%2FSuOoAiOAHo%2FJR%2B8X1%2FeDI%2BkfFRDHOOWt7f2lfe%2B7UCpSiry7aSiqmMaY4Hs5C8ofjL5LBZdrx%2FpuJJoMoBgAFU2t%2FIjxaEYWAE8HZo08yXHO44RsTK4GW5PzkJSyJkPmYiI1GLKGKj7R5dCewMRViJ9tvo%2BBWAODKfsRSseFY%2B1YiX43dYukoaium00zc8B1Gf10yOLfvEiATej9r5gtw%3D%3D", 80000, 17, "CÓ HAI CON MÈO NGỒI BÊN CỬA SỔ là tác phẩm đầu tiên của nhà văn Nguyễn Nhật Ánh viết theo thể loại đồng thoại. Đặc biệt hơn nữa là viết về tình bạn của hai loài vốn là thù địch của nhau mèo và chuột. Đó là tình bạn giữa mèo Gấu và chuột Tí Hon. Cuốn truyện mỏng mảnh vừa phải, hình vẽ của họa sĩ Hoàng Tường sinh động đến từng nét nũng nịu hay kiêu căng của nàng mèo người yêu mèo Gấu, câu chuyện thì hấp dẫn duyên dáng điểm những bài thơ tình lãng mạn nao lòng song đọc to lên thì khiến cười hinh hích…", '2020-9-24');
INSERT INTO `book` (`author_id`, `publisher_id`, `language_id`, `title`, `image`, `price`, `stock`,  `description`, `publication_date`)
	VALUES (3, 4, 1, "Chồng Xứ Lạ", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666861847708.book-4?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=N2yGsujdfmVBKF07eN93nsfht53aBPssK%2B3OH2pvCUjhvtnMWVsBsHpGYYjeW63Jz2hOd7EMGdrPuxAOaoZp5DTjICNkYiE0CyBBfVmJp9sKCPob1EuRq3uHQuYrYpp5pl6Nj4LqvbQoDq%2FiTx2B757ZhwPoDZPJlMileOEie07yT53a2F46b5HatfoqT3j2ZiExBToN41IWyZWmdEZIZLBGrd%2FB95ZH0%2BRamcvN3%2Bfqb1yyUIjNlhuktynqA35cEYr9ptkrtRaNKiZSRQXBIYE6g8XTYFoDP9GOaCIfvn6C1xwGbYX5gGfhIFpfqZTrhcY5LRIc%2BI4XaJrh5DTw4A%3D%3D", 51000, 0, "Chồng Xứ Lạ là tiểu thuyết có thật, không hư cấu. Cuốn tiểu thuyết đã vẽ nên bức tranh đa sắc màu về những người phụ nữ Việt Nam đi lấy chồng Đài Loan. Họ phải chịu biết bao cay nghiệt cuộc đời, bẩy năm sống và làm việc tại Đài Loan, nhà văn Trang Hạ đã có góc nhìn thực tế về thân phận những cô dâu Việt nơi đây. Đó là những trang viết thấm đẫm chất liệu cuộc sống, giàu giá trị nhân văn sâu sắc.", '2020-3-24');
INSERT INTO `book` (`author_id`, `publisher_id`, `language_id`, `title`, `image`, `price`, `stock`,  `description`, `publication_date`)
	VALUES (4, 5, 1, "Đường hai ngả - Người thương thành lạ", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666861865307.book-5?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=h4g0hhXbmwAppojdSsMVETKyspqa3eymLnBdjZyeRWakCL5c2uxFxI2%2FSs9KLQsE3tSJVT7%2FE7Zrl1Q4JnarHJj2o5Qd2Q74bGaeumplBWVbkFsZOeKRu5D5qZs4MIMn69D4DQOK6cGmwjyXo5TFGLwO%2Fuh4aeuayqFGqdI4R2U0fahwDxbMWBUG0bbpI62KGrkjXx59K3f2IU0jykk3XjwPW7Elxt9OvLFtMFHlWKPnf7CweYW6aQBsoZRMopjnQ0k5KQKjtLj43djd6hN9beILWsYeftAPWFQAaXyX%2BpaKtL72JTwOSVhQS3s54n1UzhHrCnYPz%2Ft5FvQbmJe%2BHw%3D%3D", 58000, 1, "Nếu như với Ngày trôi về phía cũ, Anh Khang kể chuyện chính mình để nói thay lòng những người đồng cảnh ngộ, thì với Đường hai ngả, người thương thành lạ, anh lại kể chuyện của thiên hạ để nói hộ lòng mình. Và dù là chuyện người hay chuyện mình, thì đều là những chuyện buồn của những mối tình lưng chừng giữa níu kéo - bỏ buông.", '2021-3-24');    
INSERT INTO `book` (`author_id`, `publisher_id`, `language_id`, `title`, `image`, `price`, `stock`,  `description`, `publication_date`)
	VALUES (6, 2, 2, "Endless Field", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666861886395.book-6?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=R6OWjAlS%2FXHqHSdsEzMCq5DRHYDLOXn6CPosN7vx5TmO4xQn3dMiOpMsyGR8zIcUsG7oiNzFJHEwfqgpWW%2Fycu4oGCdGu9FbY4ZYoMXjPiJpEyxQq1%2FDbRudHGqoXfYWbOIhGPHPdPkFZw9lB95X0JC%2BQ9hzTP67nPLBJ0SyzycKhl18zXJ3N3%2F3FF62rbGviBSAYJ3B4wC4n8JYjCsnDX0zwZ9CSPP%2BwC5aRNEQZal%2BqDFTK0H4SxRegmUna3xmej6D1zo80IgOBUysU7xx6Svsmt4aW6VJqLrgcHPByshdujL%2FSFqPX81ed5vbeDhHXFMdPvw%2F83uUz8pj5Q8YeQ%3D%3D", 135000, 14, "Endless Field is a tale of Mekong Delta natives, marking Nguyễn Ngọc Tư’s perceptive insight and sympathy for farmers (and people in general). Love, revenge, nostalgia, regret, and exposure of dark corners of souls permeate the whole story, the characters being thus more real. Endless Field, made into the 2010 film titled The Floating Lives, has already been translated and published in Korea, China, France, Germany, and Sweden, where it has received much praise.", '2021-7-24');    
INSERT INTO `book` (`author_id`, `publisher_id`, `language_id`, `title`, `image`, `price`, `stock`,  `description`, `publication_date`)
	VALUES (6, 2, 1, "Gáy Người Thì Lạnh", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666861919960.book-7?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=cJmgY00Iibs3FAO1gIX53cI5O0NyxRnJcb%2FSKDSi9Itof%2BcTVuiNzpMBYUeBwOuIDP3qCnDyCruUSJIWvMx7G8kC%2FVm5X1DYtHeSdsuwN9pxL%2FB3zpmya%2B5UmJsvo%2BMK8gLOuXBWB%2Bq3sKdcKaLz8xC69MrJP6lRI6sRf7oRgjNPTQz9C%2BKb56SusWsbiHUj9GWly5qGRaLDYN6ERKJ54iUAHv2ON%2F%2Bo6d3wmHy406s0vq2rlaDUEZVGlhu3AHk9We3%2FLogl8Orusmq3CsEExnh0k8Ngz3deBr2lS%2B1VwaGC0HINBkqm8HnO4C8%2FY1d2UcRir1xSb0tcmyAyD3ZG5Q%3D%3D", 80000, 23, "Quá khứ là kỷ niệm ấm áp, còn tương lai là những khát khao. Giữa hai miền thời gian đó, những chuyến dong ruổi, dù ngắn, qua ngóc ngách của làng quê hiện tại, đã giúp nhà văn viết nên những chi tiết hiện thực gây nhói buốt. 'Gáy người thì lạnh' giống như những lời trần tình (hay tự vấn) của tác giả, đồng thời cũng là chia sẻ đến những ai mong được kết nối với tự nhiên, thèm được thở 'những thứ khí trời bên ngoài cánh cửa'.", '2022-7-24');    
INSERT INTO `book` (`author_id`, `publisher_id`, `language_id`, `title`, `image`, `price`, `stock`,  `description`, `publication_date`)
	VALUES (2, 2, 1, "Cho Tôi Xin Một Vé Đi Tuổi Thơ", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666861939035.book-8?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=cxeybbJHMAIL3%2FDeJZVTTNUCOxiU1k8vNJ29a3xQ%2Bh6ZkyxVpdVm%2BOEnSNeqnzNTF2lIQf%2FQ0IKGUJDRH%2BffLDY4FSVTmVGQlkqRr%2Fit6ojkBxK9RMinpFzxxccpSDfBkABxYwAzvlnnF5kSI%2Fpil6f8O404rpY9%2FwdnTBWOku9nP8QbFEG1orjchEK5F8hy3iHelUeqoxqEtTdDHvIiJoce1f%2FgD9MKFMkZCQihrhsJZlV0QMJS0ng9FGHLaNnj92fpQu5o%2BKQ4ns%2BfeFOiEL2InyPsmYWGB9EKS5nly6h7PFs2cXclP7qRIhLXGWlGK4tmxSGn9eZP%2BDCDO29Buw%3D%3D", 80000, 7, "Truyện Cho tôi xin một vé đi tuổi thơ là sáng tác mới nhất của nhà văn Nguyễn Nhật Ánh. Nhà văn mời người đọc lên chuyến tàu quay ngược trở lại thăm tuổi thơ và tình bạn dễ thương của 4 bạn nhỏ. Những trò chơi dễ thương thời bé, tính cách thật thà, thẳng thắn một cách thông minh và dại dột, những ước mơ tự do trong lòng… khiến cuốn sách có thể làm các bậc phụ huynh lo lắng rồi thở phào. Không chỉ thích hợp với người đọc trẻ, cuốn sách còn có thể hấp dẫn và thực sự có ích cho người lớn trong quan hệ với con mình.", '2022-8-24');    
INSERT INTO `book` (`author_id`, `publisher_id`, `language_id`, `title`, `image`, `price`, `stock`,  `description`, `publication_date`)
	VALUES (2, 2, 1, "Tôi Thấy Hoa Vàng Trên Cỏ Xanh", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666861960123.book-9?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=W%2FsHIofY5RGULbSlB%2FSaeMlaK0fTbsJroikhVgRTgvTtVEwQBMJ%2FONvJNxM2cRdwdzzhp1k7EnUNSVqQm5IgLcLkXpNqUC5BCuQnRZ4mqSBrqviLj%2Fcb47Co82%2FmPo2N%2FdwVhdFOM63VQc%2FT1OFlu5lueQDFWjMn6jrIZBHrSTRyqclHqc5fsaj95LX7513Nf3op90sqY5aKDyy0kXgwoVgaLj5o2fFeCqfL%2FXd%2B%2BJb18rQQl8yatgiPk%2B1Ky5%2FdUE1cMBhfQYGfoa7P%2BoqKfOkuh%2BJcDdicBAIgeX2PNuHU8MLMfSygCwcOrvtMJzSgO%2B0wwTFt1xDBb7JYdjwQxw%3D%3D", 82000, 47, "Những câu chuyện nhỏ xảy ra ở một ngôi làng nhỏ: chuyện người, chuyện cóc, chuyện ma, chuyện công chúa và hoàng tử , rồi chuyện đói ăn, cháy nhà, lụt lội,... Bối cảnh là trường học, nhà trong xóm, bãi tha ma. Dẫn chuyện là cậu bé 15 tuổi tên Thiều. Thiều có chú ruột là chú Đàn, có bạn thân là cô bé Mận. Nhưng nhân vật đáng yêu nhất lại là Tường, em trai Thiều, một cậu bé học không giỏi. Thiều, Tường và những đứa trẻ sống trong cùng một làng, học cùng một trường, có biết bao chuyện chung. Chúng nô đùa, cãi cọ rồi yêu thương nhau, cùng lớn lên theo năm tháng, trải qua bao sự kiện biến cố của cuộc đời.", '2012-8-24');    
INSERT INTO `book` (`author_id`, `publisher_id`, `language_id`, `title`, `image`, `price`, `stock`,  `description`, `publication_date`)
	VALUES (7, 3, 1, "Dế Mèn Phiêu Lưu Ký", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666861985355.book-10?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=aJA8I%2FiYEHjaxYW0s0Nk4BsIMTyz6BHvCq9rMUqnV39f8%2B%2B%2FV%2FYgEE5yjHdZuSEXIokKtrXcZgSQB0BuIkjBVYY1yvG23KTV0nI%2FAahhzhiM63b37beA03s1daLOhzFrNpkGl7cqxc7qehqQuR%2Be8%2FNfIIFA9GYC2glPyVNP8aoKQbDggu%2BC2n7K4RbmnjA6ue1ApW9%2BRWXSrc3YbIpaLU7WVNIk980H5KAKY3TwPXhpV%2FcR6aue5Pxe4CqPMXJY9l36ZLtnqZKeQ2cggq88IDm9smBbIVQK5Zoe7XLUpFDcBR8zjJVW9WSmuRBkuf%2BwMN6vV0xYTQXVUT1xogwADw%3D%3D", 45000, 31, "“Biết ước mơ và hành động, Dế mèn của tôi chắc chắn là bạn trung thủy với thế hệ tuổi thơ của bạn.”. “Một con dế đã từ tay ông thả ra chu du thế giới tìm những điều tốt đẹp cho loài người. Và con dế ấy đã mang tên tuổi ông đi cùng trên những chặng đường phiêu lưu đến với cộng đồng những con vật trong văn học thế giới, đến với những xứ sở thiên nhiên và văn hóa của các quốc gia khác. Dế Mèn Tô Hoài đã lại sinh ra Tô Hoài Dế Mèn, một nhà văn trẻ mãi không già trong văn chương...”", '2012-1-24');    
INSERT INTO `book` (`author_id`, `publisher_id`, `language_id`, `title`, `image`, `price`, `stock`,  `description`, `publication_date`)
	VALUES (7, 3, 1, "Ngọn Cờ Lau", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666862006105.book-11?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=ie2zhCIoK%2FWkyomc8YG%2Fh9FwSZewRqy46FrBOgrDpEaLDKi6K6lelpsWSU0UZrJqRcxzx321I5QSssvdAQZx13qB%2BdMcMoVLL6l6jOVabAnPFde%2Bfsf8WKFmwX1cKIxyzsLZuhX48cUGHeFHZfcavCr8T%2FflXA9%2BvClozeCshlNSX8ReYGwgV3qOBVkvigacOosNdSchfWrNlYQ8rSD0SxrFeZJX2RpLQrQ%2BYp%2Bk5ArDCkitrUc%2F4cdhElSwJAwpib42TNgu69h83EhscXSz3blU3aav2Rf0trcy1Vw7wVyk0EGsGpMz3W9H0yX4jIbI8UvDPkhbDH0LTg6DzRShhw%3D%3D", 81000, 11, "“Bộ Lĩnh mồ côi cha từ thuở nhỏ. Quan Thứ sử châu Hoan là Đinh Công Trứ − người sinh ra Bộ Lĩnh − mất đi, thì Bộ Lĩnh theo mẹ là Đàm Thị về Đại Hoàng ở với ông ngoại là Đàm Viên Ngoại. Cho đến năm Bộ Lĩnh lên mười hai tuổi thì Đàm Viên Ngoại cũng mất. Hai mẹ con phải đem nhau về Đại Hữu là quê hương của ông Đinh Công Trứ.” Mời các em cùng đọc truyện để xem cậu bé mồ côi Đinh Bộ Lĩnh khi xưa đã trải qua những năm tháng ấu thơ ra sao mà sau lại trở thành vị hoàng đế khai sáng triều đại nhà Đinh trong lịch sử nước nhà nhé!", '2012-2-24');    
INSERT INTO `book` (`author_id`, `publisher_id`, `language_id`, `title`, `image`, `price`, `stock`,  `description`, `publication_date`)
	VALUES (8, 3, 1, "Những Ngày Thơ Ấu", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666862024342.book-12?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=Cu6c06YmkkamY7pvdXo3VwKyo377%2B21%2Fp7cy1xWPsoLcEY%2F8jjgbqb5lAYKjhWCvt2UzkHKLUKa9McKgnfA%2F6ueSBepa45Ueq2gR0yVyBjJY4RMQU1hB7JJNI41qojALI0vGwDI01ICFklaHoErB8nCREpJbkzH2YO2k0FkR0fAdZzCE%2FD31rxzjZif1motxsicP62xNNfOCgLUPLwJhsJioRpft%2BJlVXyoGWU69gq7%2BlhMX8eCHPNVtf8%2F5I18SnFZ%2Bo3CBG%2FLQKmiUvfAGrTZ%2FAm%2FOer3I51cUFeUrOuPXSXNS7N3VQ7fQiQ4Y24WZvjPwoNSCq%2BXXf3GXPKXwGA%3D%3D", 31500, 27, "Người ta hay giấu giếm và che đậy sự thật, nhất là sự đáng buồn trong gia đình. Có lợi ích gì không? Những ngày thơ ấu mà Nguyên Hồng kể lại , tôi không muốn biết là có nên hay không, tôi chỉ thấy trong những kỉ niệm cứ đau đớn ấy sự rung động cực điểm của một tâm hồn trẻ dại, lạc loài trong những lề lối khắc nghiệt của một gia đình sắp tàn. Trên những trang mà Nguyên Hồng viết ra đây, chúng ta thấy nổi lên hình ảnh một người mẹ chịu khổ và âu yếm, một người mẹ hiền từ mà tác giả nói đến với tất cả tình yêu tha thiết của con người.", '2012-2-24');    
INSERT INTO `book` (`author_id`, `publisher_id`, `language_id`, `title`, `image`, `price`, `stock`,  `description`, `publication_date`)
	VALUES (2, 2, 1, "Bồ Câu Không Đưa Thư", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666862100334.book-13?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=mYfiiJL9ESiT8e2XMI0g5DvjeM2IrBdqfUlGBx4O0Xts0q9WBgydzsimX5mTx1SUcuCU59%2B4hD11Yp4DEaHTtEOwJxcgUCRo%2Brd5R3YfWUHs4FsKDpMfg8gTHDd6EeFpdGMOEzmLbe07OOkyPDEqwBQQ%2Bivcq1qc3r5ZQ5E0unVsMe%2Fl9ZnAB7OrXUzWflyQhsNkfzM%2FMuX66T8Hl3fda5AD5L%2F2zf0FOtLWBYHa6E0Fpfp6gLlO36NhM1K4BY18GQNBECaPPx00iXZOZqefgd%2FtaP6RgLyiNG0eQlh0lPeXKipcqak5LCiOJiGL4xcHrUMLsow1npB5o5VxY6F0hg%3D%3D", 38000, 8, "Câu chuyện bắt đầu từ lá thư làm quen để trong học bàn của Thục, trong bộ ba Xuyến, Thục, Cúc Hương. Lá thư chân tình đã thu hút sự tò mò của bộ ba, và họ bị cuốn hút vào trò chơi với người giấu mặt, dần hồi kéo theo Phán củi, anh chàng xấu xí vụng về của lớp làm quân sư và giúp xướng họa thơ. Cuộc truy tìm dẫn mọi người đến nhiều hiểu lầm tai hại và cả những bất ngờ thú vị. Và điều bất ngờ cuối cùng đã được phát hiện quá muộn. Vì sao? Xin để cho bạn đọc tự khám phá.", '2022-2-24');    
INSERT INTO `book` (`author_id`, `publisher_id`, `language_id`, `title`, `image`, `price`, `stock`,  `description`, `publication_date`)
	VALUES (9, 4, 1, "Các Bạn Tôi Ở Trên Đấy", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666862116269.book-14?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=gqwbPDG08AlwM23XB4kDFBmuNIAG7YYRBrfCL3O0SDptAZ77hcyqHG0mpIkvQ%2FVs7USLPaEzjvmeecPYQTpNjg8MrcYsy9236gSJrQRf5njdTfRMVKxNxt%2BbyfAaLUHeIvykRJI9dHz9kMMOT7Ow2jSj5QSGzs1svbGaE%2BZM33bYxvXlKTLITC0E%2FqfuJ1H20hO18vWqfXH0XsJWSMZshJ9QkLC3yeN29HyZwA51W1LcerRlPD%2FQQQfLgkd7qhzPOY356YbC%2FTYIcBJSWgUvzyKXJ06oFBTUXDwlrScEOVTc52kr1b3%2BwrBjjINtomwBOu0k%2B5YbuQEkOam%2F%2F5W6gQ%3D%3D", 139000, 24, "Sách gồm những bút ký về Tây Nguyên: thiên nhiên, con người, văn hóa và Rừng… tất cả đều độc đáo, được khắc họa rõ nét, chạm đến tầng sâu nhất. Với nhà văn Nguyên Ngọc – người đã gắn bó nửa đời với Tây Nguyên, người đã từng ăn ngủ, sống chết với dân làng – thì những gì hiện ra trên từng trang sách, chính là tái hiện lại đời sống của những tộc người Tây Nguyên, tái hiện lại đời sống của đất rừng Tây Nguyên đại ngàn mà “thâm trầm và huyền diệu”.Qua mỗi trang sách, hiển hiện trước mắt người đọc là con người và vùng đất kết dính nhau bằng men say âm thanh cồng chiêng, bằng âm hưởng đàn đá ngàn năm. Người con của núirừng bên cạnh bếp lửa, người con của núi rừng cùngđiệu múa bên ghè rượu cần… họ có nếp đối đãi chân chất, nhân văn không lẫn vào đâu được: “Không bán, nhưng mà cho”. Nhà văn Nguyên Ngọc vô cùng khéo léo “tinh chế” để giữ nguyên “linh hồn” của đời sống Tây Nguyên.", '2022-7-24');    
INSERT INTO `book` (`author_id`, `publisher_id`, `language_id`, `title`, `image`, `price`, `stock`,  `description`, `publication_date`)
	VALUES (10, 1, 1, "Harry Potter Và Phòng Chứa Bí Mật", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666862133831.book-15?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=BKoXYIRU8O%2B91VeelICDg8UH8i4q%2FPvosHKrRQseWmyj9wDjNnC9yfyVWdiRFJNT2LlFqKw3447FgPKfebDWBfqcaoB4yL99QynnZCQF0odHV6FRJEYp6c2ZMRxfvaUqwwpDMgyGOfeRp7W4aRm8ce18Qohy5YUYKgDT62DYG47LvQ2ZZnMNzf7HNaxzAnyTu53iT0PJ1wvdzB8ZbRIKxrUMSvDcTJnd%2BEOTJ%2BSXrCH%2F5kb680BITsRMlWGMhjQVfQrWxuxFE4J8r9npeZocxFS%2FKwo6z6yVNxhOKnJ6pGPsD8jPQNlYeub%2F8hln30uEL22kf92SWVedmybCq06lmQ%3D%3D", 170000, 14, "Harry khổ sở mong ngóng cho kì nghỉ hè kinh khủng với gia đình Dursley kết thúc. Nhưng một con gia tinh bé nhỏ tội nghiệp đã cảnh báo cho Harry biết về mối nguy hiểm chết người đang chờ cậu ở trường Hogwarts. Trở lại trường học, Harry nghe một tin đồn đang lan truyền về phòng chứa bí mật, nơi cất giữ những bí ẩn đáng sợ dành cho giới phù thủy có nguồn gốc Muggle. Có kẻ nào đó đang phù phép làm tê liệt mọi người, khiến họ gần như đã chết, và một lời cảnh báo kinh hoàng được tìm thấy trên bức tường. Mối nghi ngờ hàng đầu – và luôn luôn sai lầm – là Harry. Nhưng một việc còn đen tối hơn thế đã được hé mở.", '2022-3-24');    
INSERT INTO `book` (`author_id`, `publisher_id`, `language_id`, `title`, `image`, `price`, `stock`,  `description`, `publication_date`)
	VALUES (10, 1, 1, "Harry Potter Và Chiếc Cốc Lửa", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666862149303.book-16?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=Mj87SMd77kQJe38YhBuFgnJecSYbklIfEXb1nXPSjaC8LuDu2xzbyMAzGbxMl5A2%2Bpl%2BZ1ps%2BLaE15RUn5jiWFShDh8rxr30Nn0%2B5%2BcdTO0OGP8lZQVeGXFiYSjpx0FG4A3bM9Lfnvut40zrIqrTD1z7fFmj7X3OoQJ3n9tdl4qEuE59sTepsbvNGMpJOAndWcLj8c7UW9Hu3vs18qkRgU79mbv0aafaMnXYWt6fYUBvv4Z5dOG1gcwIx0HsG6OVvLr%2BjEA%2B8Jb9uK%2BOAlPLd9GUTddq1hLQJBCUQnHOQYmCQlu0OIy7ndMVFqOqrfljKCZVDaKtTPlEVLrpYn9%2B9Q%3D%3D", 310000, 31, "Khi giải Quidditch Thế giới bị cắt ngang bởi những kẻ ủng hộ Chúa tể Voldemort và sự trở lại của Dấu hiệu hắc ám khủng khiếp, Harry ý thức được rõ ràng rằng, Chúa tể Voldemort đang ngày càng mạnh hơn. Và để trở lại thế giới phép thuật, Chúa tể hắc ám cần phải đánh bại kẻ duy nhất sống sót từ lời nguyền chết chóc của hắn - Harry Potter. Vì lẽ đó, khi Harry bị buộc phải bước vào giải đấu Tam Pháp thuật uy tín nhưng nguy hiểm, cậu nhận ra rằng trên cả chiến thắng, cậu phải giữ được mạng sống của mình.", '2021-3-24');    
INSERT INTO `book` (`author_id`, `publisher_id`, `language_id`, `title`, `image`, `price`, `stock`,  `description`, `publication_date`)
	VALUES (10, 1, 1, "Harry Potter Và Hòn Đá Phù Thủy", "https://storage.googleapis.com/book-store-41a6b.appspot.com/1666862163514.book-17?GoogleAccessId=firebase-adminsdk-1lna4%40book-store-41a6b.iam.gserviceaccount.com&Expires=1893430800&Signature=GGcRCVMPSFbigo7j757pysop6hJgnbu1Z1eWHhg%2FnLXN4eSKYfcU84vs5vwl396ryO1Lc6i7D2lC32hOSew5%2BVnrIY9D1BWIB8rDxOt%2BqxoMqIkM51yCLFDfSjK9DdWGfZ64TsdtFyESheDVSxlYHBpsQdex4J2A%2FWmBDf2d11vGdswEQhJ4QGK07Feo6lrRNiCMfwwSX1BWfctpU0vsC1Jjiz03ysvdiwDxE6B%2FaIPKSwYetE1RGaguxuwfJnJdUmixOICQa15VXCAPsvZBLeLqZX%2F5DabpY5ZE86vNWT43x8RlMu2pEJB7xf9rchzopoyKiB8LzCSfo8bBicdJCQ%3D%3D", 150000, 3, "Khi một lá thư được gởi đến cho cậu bé Harry Potter bình thường và bất hạnh, cậu khám phá ra một bí mật đã được che giấu suốt cả một thập kỉ. Cha mẹ cậu chính là phù thủy và cả hai đã bị lời nguyền của Chúa tể Hắc ám giết hại khi Harry mới chỉ là một đứa trẻ, và bằng cách nào đó, cậu đã giữ được mạng sống của mình. Thoát khỏi những người giám hộ Muggle không thể chịu đựng nổi để nhập học vào trường Hogwarts, một trường đào tạo phù thủy với những bóng ma và phép thuật, Harry tình cờ dấn thân vào một cuộc phiêu lưu đầy gai góc khi cậu phát hiện ra một con chó ba đầu", '2021-1-24');    


-- ------------------------------------------------------------------
-- Seed CATEGORY table.
-- ------------------------------------------------------------------

INSERT INTO `category` (`name`)
	VALUES ("Light novel");
INSERT INTO `category` (`name`)
	VALUES ("Short story");
INSERT INTO `category` (`name`)
	VALUES ("Manga");
INSERT INTO `category` (`name`)
	VALUES ("Romance");
INSERT INTO `category` (`name`)
	VALUES ("Horror");
INSERT INTO `category` (`name`)
	VALUES ("Adventure");
INSERT INTO `category` (`name`)
	VALUES ("Action");
INSERT INTO `category` (`name`)
	VALUES ("Sci-fi");
INSERT INTO `category` (`name`)
	VALUES ("Fantasy");
INSERT INTO `category` (`name`)
	VALUES ("Historical");
INSERT INTO `category` (`name`)
	VALUES ("Economical");
INSERT INTO `category` (`name`)
	VALUES ("Psychological");
INSERT INTO `category` (`name`)
	VALUES ("Comedy");
INSERT INTO `category` (`name`)
	VALUES ("Children");
INSERT INTO `category` (`name`)
	VALUES ("School-life");
INSERT INTO `category` (`name`)
	VALUES ("Mystery");
INSERT INTO `category` (`name`)
	VALUES ("Thriller");


-- ------------------------------------------------------------------
-- Seed BOOK_CATEGORY table.
-- ------------------------------------------------------------------

INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('1', '1');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('1', '6');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('1', '7');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('1', '9');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('1', '16');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('2', '1');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('2', '4');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('3', '2');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('3', '4');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('4', '2');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('5', '1');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('5', '4');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('5', '5');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('6', '1');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('6', '10');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('6', '12');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('7', '2');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('7', '12');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('8', '2');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('8', '14');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('9', '2');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('9', '4');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('9', '12');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('9', '15');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('10', '2');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('10', '6');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('10', '7');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('10', '9');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('10', '13');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('10', '16');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('11', '2');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('11', '10');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('11', '17');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('12', '1');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('12', '10');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('13', '1');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('13', '4');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('13', '13');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('13', '15');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('14', '1');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('13', '10');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('13', '12');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('14', '16');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('14', '17');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('15', '1');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('15', '6');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('15', '7');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('15', '13');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('15', '14');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('15', '15');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('16', '1');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('16', '6');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('16', '7');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('16', '13');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('16', '14');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('16', '15');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('16', '16');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('17', '1');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('17', '2');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('17', '3');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('17', '4');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('17', '5');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('17', '6');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('17', '7');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('17', '8');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('17', '9');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('17', '10');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('17', '11');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('17', '12');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('17', '13');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('17', '14');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('17', '15');
    INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('17', '16');
INSERT INTO `book_category` (`book_id`, `category_id`)
	VALUES ('17', '17');
    

-- ------------------------------------------------------------------
-- Seed CATEGORY table.
-- ------------------------------------------------------------------

INSERT INTO `rating` (`user_id`, `book_id`, `rating`, `review`)
	VALUES (1, 1, 5, "Sách mới còn nguyên seal,tuy bìa mềm nhưng cầm rất chắc chắn. Hi vọng ngày nào đó sẽ ra bản bìa cứng. Nội dung hay,gần gũi quen thuộc. Nên đọc các bạn ạ. Giao hàng nhanh,đóng gói ổn");
INSERT INTO `rating` (`user_id`, `book_id`, `rating`, `review`)
	VALUES (1, 2, 4, "Sách của bác Ánh thật sự không có gì để chê cả ❤️❤️");
INSERT INTO `rating` (`user_id`, `book_id`, `rating`, `review`)
	VALUES (1, 3, 3, "Chắc chưa hợp cho bé 10 tuổi con mình. Bé đọc xong nói cảm thấy tụt mood so với phim và bài hát");
INSERT INTO `rating` (`user_id`, `book_id`, `rating`, `review`)
	VALUES (1, 4, 4, "Những câu chuyện nhỏ và nhẹ nhàng ở làng quê ngèo khổ, những câu chuyện buồn khổ dưới con mắt trẻ thơ, nhưng sau bao nhiêu chuyện buồn như vậy cũng có những đốm sáng, điểm 'hoa vàng' trên một đồi cỏ xanh bao la, cũng còn những kết thúc có hạnh phúc, có vui vẻ. Con người khi bi quan cũng nên nhìn vào đó để thấy thế giới quanh mình có đầy rẫy nỗi buồn đi nữa thì cũng vẫn tồn tại những niềm vui nhỏ bé nào đó. Câu chuyện hết sức nhẹ nhàng nên nếu mong chờ những điều gì lớn lao sâu sắc hằn vào trí nhớ thì sẽ không thấy trong truyện này");
INSERT INTO `rating` (`user_id`, `book_id`, `rating`, `review`)
	VALUES (1, 5, 5, "Sách hay lắm mọi người, bìa đẹp, cứng cáp. Nội dung thì khỏi bàn hehe");
INSERT INTO `rating` (`user_id`, `book_id`, `rating`, `review`)
	VALUES (3, 6, 1, "Sách rách, bẩn, không như lúc đặt");
INSERT INTO `rating` (`user_id`, `book_id`, `rating`, `review`)
	VALUES (3, 7, 2, "Giao hàng muộn");
INSERT INTO `rating` (`user_id`, `book_id`, `rating`, `review`)
	VALUES (3, 8, 3, "Giá đắt hơn mặt bằng chung thị trường");
INSERT INTO `rating` (`user_id`, `book_id`, `rating`, `review`)
	VALUES (3, 9, 2, "");
INSERT INTO `rating` (`user_id`, `book_id`, `rating`, `review`)
	VALUES (3, 10, 1, "Sản phẩm tệ, không như trong hình");
INSERT INTO `rating` (`user_id`, `book_id`, `rating`, `review`)
	VALUES (2, 1, 3, "Một vài bình luận thêm vào cho đỡ trống");
INSERT INTO `rating` (`user_id`, `book_id`, `rating`, `review`)
	VALUES (2, 2, 3, "Một vài bình luận thêm vào cho đỡ trống");
INSERT INTO `rating` (`user_id`, `book_id`, `rating`, `review`)
	VALUES (2, 3, 3, "Một vài bình luận thêm vào cho đỡ trống");
INSERT INTO `rating` (`user_id`, `book_id`, `rating`, `review`)
	VALUES (2, 4, 3, "Một vài bình luận thêm vào cho đỡ trống");
INSERT INTO `rating` (`user_id`, `book_id`, `rating`, `review`)
	VALUES (2, 5, 3, "Một vài bình luận thêm vào cho đỡ trống");
INSERT INTO `rating` (`user_id`, `book_id`, `rating`, `review`)
	VALUES (2, 6, 3, "Một vài bình luận thêm vào cho đỡ trống");
INSERT INTO `rating` (`user_id`, `book_id`, `rating`, `review`)
	VALUES (2, 7, 3, "Một vài bình luận thêm vào cho đỡ trống");
INSERT INTO `rating` (`user_id`, `book_id`, `rating`, `review`)
	VALUES (2, 8, 3, "Một vài bình luận thêm vào cho đỡ trống");
INSERT INTO `rating` (`user_id`, `book_id`, `rating`, `review`)
	VALUES (2, 9, 3, "Một vài bình luận thêm vào cho đỡ trống");
INSERT INTO `rating` (`user_id`, `book_id`, `rating`, `review`)
	VALUES (2, 10, 3, "Một vài bình luận thêm vào cho đỡ trống");
    

-- ------------------------------------------------------------------
-- Seed STATUS table.
-- ------------------------------------------------------------------

INSERT INTO `status` (`name`)
	VALUES ("Ordered");
INSERT INTO `status` (`name`)
	VALUES ("Shipping");
INSERT INTO `status` (`name`)
	VALUES ("Shipped");
INSERT INTO `status` (`name`)
	VALUES ("Return back");


-- ------------------------------------------------------------------
-- Seed ORDER table.
-- ------------------------------------------------------------------

INSERT INTO `order` (`user_id`, `order_date`, `description`, `status_id`)
	VALUES (1, "2022-10-04", "test description", 3);
INSERT INTO `order` (`user_id`, `order_date`, `description`, `status_id`)
	VALUES (1, "2022-10-15", "test description", 2);
INSERT INTO `order` (`user_id`, `order_date`, `description`, `status_id`)
	VALUES (2, "2022-10-16", "test description", 1);
INSERT INTO `order` (`user_id`, `order_date`, `description`, `status_id`)
	VALUES (1, "2022-9-24", "test description", 4);


-- ------------------------------------------------------------------
-- Seed ORDER_DETAIL table.
-- ------------------------------------------------------------------

INSERT INTO `order_detail` (`order_id`, `book_id`, `quantity`)
	VALUES (1, 1, 1);
INSERT INTO `order_detail` (`order_id`, `book_id`, `quantity`)
	VALUES (1, 2, 1);
INSERT INTO `order_detail` (`order_id`, `book_id`, `quantity`)
	VALUES (2, 1, 1);
INSERT INTO `order_detail` (`order_id`, `book_id`, `quantity`)
	VALUES (2, 3, 1);
INSERT INTO `order_detail` (`order_id`, `book_id`, `quantity`)
	VALUES (2, 4, 1);
INSERT INTO `order_detail` (`order_id`, `book_id`, `quantity`)
	VALUES (3, 4, 2);
INSERT INTO `order_detail` (`order_id`, `book_id`, `quantity`)
	VALUES (4, 5, 2);
INSERT INTO `order_detail` (`order_id`, `book_id`, `quantity`)
	VALUES (4, 2, 2);


