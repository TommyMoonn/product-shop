USE master
GO

-- Drop current database if it already exists
DROP DATABASE ProductIntro
GO

-- Create database
CREATE DATABASE ProductIntro
GO

USE ProductIntro
GO


-- =========================
-- Accounts
-- =========================
CREATE TABLE Accounts (
    account VARCHAR(20) PRIMARY KEY NOT NULL,
    pass VARCHAR(255) NOT NULL,
    lastName NVARCHAR(50) NOT NULL,
    firstName NVARCHAR(30) NOT NULL,
    birthday DATETIME,
    gender BIT DEFAULT 1,                     -- 1: male | 0: female
    phone NVARCHAR(20),                       -- Only digits, begin with 03|05|07|08|09
    status BIT NOT NULL DEFAULT 1,            -- 1: active | 0: deactivated
    roleInSystem INT NOT NULL DEFAULT 0       -- 0: Customer | 1: Admin | 2: Staff
)
GO


-- =========================
-- Categories
-- =========================
CREATE TABLE Categories (
    typeId INT PRIMARY KEY NOT NULL IDENTITY,
    categoryName NVARCHAR(100) NOT NULL,
    memo NVARCHAR(MAX) DEFAULT ''
)
GO


-- =========================
-- Products
-- =========================
CREATE TABLE Products (
    productId VARCHAR(10) PRIMARY KEY NOT NULL,
    productName NVARCHAR(500) NOT NULL,
    productImage VARCHAR(MAX) DEFAULT '',
    brief NVARCHAR(2000) DEFAULT '',
    postedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    typeId INT NOT NULL REFERENCES Categories(typeId),
    account VARCHAR(20) NOT NULL 
        FOREIGN KEY REFERENCES Accounts(account) ON UPDATE CASCADE,
    unit NVARCHAR(32) DEFAULT N'pcs',
    price INT NOT NULL DEFAULT 0,
    discount INT NOT NULL DEFAULT 0 
        CHECK (discount >= 0 AND discount <= 100)
)
GO


-- =========================
-- ProductViews
-- =========================
CREATE TABLE ProductViews (
    viewId INT PRIMARY KEY IDENTITY,
    account VARCHAR(20) NOT NULL REFERENCES Accounts(account),
    productId VARCHAR(10) NOT NULL REFERENCES Products(productId),
    viewDate DATETIME DEFAULT CURRENT_TIMESTAMP
)
GO


-- =========================
-- Cart
-- =========================
CREATE TABLE Cart (
    cartId INT PRIMARY KEY IDENTITY,
    account VARCHAR(20) UNIQUE REFERENCES Accounts(account)
)
GO


-- =========================
-- CartItems
-- =========================
CREATE TABLE CartItems (
    cartId INT NOT NULL REFERENCES Cart(cartId) ON DELETE CASCADE,
    productId VARCHAR(10) NOT NULL REFERENCES Products(productId),
    quantity INT NOT NULL DEFAULT 1,
    PRIMARY KEY (cartId, productId)
)
GO


-- =========================
-- Orders
-- =========================
CREATE TABLE Orders (
    orderId INT PRIMARY KEY IDENTITY,
    account VARCHAR(20) NOT NULL REFERENCES Accounts(account),
    orderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    orderStatus INT NOT NULL,
    customerName NVARCHAR(80) NOT NULL,
    customerPhone NVARCHAR(20) NOT NULL,
    customerAddress NVARCHAR(100) NOT NULL,
    totalValue INT NOT NULL DEFAULT 0
)
GO


-- =========================
-- OrderDetails
-- =========================
CREATE TABLE OrderDetails (
    orderId INT NOT NULL REFERENCES Orders(orderId),
    productId VARCHAR(10) NOT NULL REFERENCES Products(productId),
    price INT NOT NULL,
    quantity INT NOT NULL,
    discount INT NOT NULL DEFAULT 0 
        CHECK (discount >= 0 AND discount <= 100),
    PRIMARY KEY (orderId, productId)
)
GO


-- =========================
-- Accounts Seed Data
-- =========================

-- Admin
INSERT INTO Accounts
VALUES ('admin','abc',N'Nguyễn Quang',N'Hưng','1996/10/28',1,'0705101028',1,1)

-- Managers
INSERT INTO Accounts
VALUES ('manager','123',N'Nguyễn Minh',N'Quang','1996/06/12',1,'0935694223',1,2)

INSERT INTO Accounts
VALUES ('manager2','123',N'Trần Minh',N'Tuấn','1994/03/15',1,'0912345678',1,2)

INSERT INTO Accounts
VALUES ('manager3','123',N'Phạm Quốc',N'Bảo','1992/07/21',1,'0923456789',1,2)


-- Staff
INSERT INTO Accounts
VALUES ('staff','123',N'Bùi Anh',N'Khoa','1999/10/23',1,'0877371783',1,3)

INSERT INTO Accounts
VALUES ('staff2','123',N'Nguyễn Văn',N'Phúc','1998/01/11',1,'0901122334',1,3)

INSERT INTO Accounts
VALUES ('staff3','123',N'Lê Thanh',N'Nam','1997/09/09',1,'0902233445',1,3)

INSERT INTO Accounts
VALUES ('staff4','123',N'Đỗ Minh',N'Hoàng','2000/12/05',1,'0903344556',1,3)


-- Customers
INSERT INTO Accounts
VALUES ('customer','123',N'Lê Hoàng',N'Vũ','2000/04/19',1,'0878091235',1,0)

INSERT INTO Accounts
VALUES ('customer2','123',N'Ngô Thị',N'Lan','2001/05/18',0,'0911223344',1,0)

INSERT INTO Accounts
VALUES ('customer3','123',N'Võ Thành',N'Đạt','2002/08/25',1,'0912334455',1,0)

INSERT INTO Accounts
VALUES ('customer4','123',N'Phan Minh',N'Huy','1999/11/30',1,'0913445566',1,0)

INSERT INTO Accounts
VALUES ('customer5','123',N'Hoàng Gia',N'Bảo','2003/02/14',1,'0914556677',1,0)

INSERT INTO Accounts
VALUES ('customer6','123',N'Trương Khánh',N'Vy','2004/06/03',0,'0915667788',1,0)
GO


-- =========================
-- Categories Seed Data
-- =========================
INSERT INTO Categories(categoryName) VALUES (N'Dụng cụ nhà bếp')

INSERT INTO Categories(categoryName) VALUES (N'Điện gia dụng')

INSERT INTO Categories(categoryName) VALUES (N'Trang trí nội thất')

INSERT INTO Categories(categoryName) VALUES (N'Dụng cụ thể thao')

INSERT INTO Categories(categoryName) VALUES (N'Thiết bị thông minh')

INSERT INTO Categories(categoryName) VALUES (N'Quần - Áo thời trang')

GO


-- =========================
-- Kitchen Appliances
-- =========================

INSERT INTO products (productId, productName, productImage, brief, account, price, discount, typeId, unit)		
              values('SHG2303MRA', N'Bộ nồi Inox 3 đáy SUNHOUSE', '/images/sanPham/boNoiInoxSunhouse.jpg',
			          N'Quai nồi Quai inox tán đinh bọc silicon cách nhiệt, Núm cầm Núm inox bọc silicon cách nhiệt, 
					  Vung nồi Vung kính cường lực viền inox, Đáy nồi Đáy từ, sử dụng trên mọi loại bếp', 
					 'manager', 399000,10,1, N'Bộ');
go
INSERT INTO products (productId, productName, productImage, brief, account, price, discount, typeId, unit) 
              values('NAG1452', N'Nồi Áp Suất Cơ Inox Cao Cấp Nagakawa', '/images/sanPham/noiApSuatNagakawa.jpg',
			          N'Hệ thống 2 van xả, khóa nắp tuyệt đối an toàn. Hệ thống doăng an toàn và kín tuyêt đối. 
					  Chất liệu cao cấp inox 304 không gỉ, chống bám bẩn tối ưu, an toàn cho sức khỏe, dễ dàng vệ sinh.
				      Cấu trúc đáy 3 lớp, nấu chín đều, giữ nhiệt lâu, tản nhiệt tốt', 
					  'manager', 1328000,5,1, N'Bộ');
go
INSERT INTO products (productId, productName, productImage, brief, account, price, discount, typeId, unit)  
              values('SHG2303TEF', N'Combo 2 Chảo chiên chống dính đáy Tefal', '/images/sanPham/chaoChienTefal.jpg',
			          N'LỚP PHỦ TITANIUM nonstick Bền chắc với hơn 16,000 lần chà nhám, mang lại khả năng chống dính tuyệt vời và độ bền vượt trội, 
					    có thể sử dụng ít dầu khi nấu ăn. Bên ngoài được phủ sơn chống dính, dễ dàng làm sạch. CÔNG NGHỆ THERMO-SPOT 
						Báo nhiệt thông minh, cho biết nhiệt độ lý tưởng để nấu ăn ngon.', 
					   'admin', 709000,0,1,N'Bộ');
go
INSERT INTO products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES
('SUNHAOD001', N'Bộ nồi Anod Sunhouse cao cấp', '/images/sanPham/boNoiAnodSunhouse.jpg',
N'Bộ nồi anod Sunhouse cao cấp với lớp phủ chống dính bền bỉ, truyền nhiệt nhanh và đều. 
Thiết kế hiện đại, phù hợp với mọi loại bếp.', 
'manager', 599000, 5, 1, N'Bộ');
GO
INSERT INTO products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES
('FIVESTAR01', N'Bộ nồi Inox Fivestar Standard', '/images/sanPham/boNoiInoxFivestarStandard.jpg',
N'Bộ nồi inox Fivestar với đáy từ 3 lớp, truyền nhiệt tốt, bền đẹp theo thời gian. 
Phù hợp với mọi loại bếp từ, bếp gas.', 
'admin', 689000, 0, 1, N'Bộ');
GO


-- =========================
-- Home Decor
-- =========================

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('4062373305', N'Ghế thư giãn', '/images/sanPham/gheThuGian.jpg',
        N'Ghế làm chất liệu cao cấp, chắc chắn. Dùng ở văn phòng, đi dã ngoại, ở nhà.
Dễ dàng gấp gọn, nằm cực sướng, giúp thư giãn lưng sau mỗi ngày làm việc',
        'admin', 699000, 10, 3, N'Cái');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('8868354221', N'Bàn Trà Sofa Phong Cách Bắc Âu - IGEA', '/images/sanPham/banTraSofaIGEA.jpg',
        N'Mặt bàn sản xuất từ gỗ MDF phủ melamin cao cấp chống xước chống nước. Chân bàn từ gỗ sồi vân đẹp.
Kích thước: rộng 50cm, dài 90cm, cao 42cm. Màu sắc: Trắng. Phong cách: Hiện đại',
        'manager', 290000, 5, 3, N'Cái');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('2759614408', N'Giá để giày - Kệ giày dép 7 tầng', '/images/sanPham/keGiaDeGiay.jpg',
        N'Tủ giày gỗ lắp ráp 7 tầng thiết kế nhỏ gọn, dễ tháo lắp và tiết kiệm diện tích.
Khung gỗ melamine chống nước, chịu lực tốt, chứa khoảng 12 đôi giày và có ngăn kéo nhỏ.',
        'admin', 439000, 10, 3, N'Cái');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('5746333511', N'Kệ tivi phong cách Bắc Âu T350-1', '/images/sanPham/keTiviPhongCachBacAu.png',
        N'Thiết kế đơn giản, hiện đại. Có thể dùng làm kệ tivi hoặc kệ trang trí.
Kích thước: 178x30x36cm. Chất liệu: gỗ MDF phủ melamin chống xước chống nước.',
        'admin', 569000, 0, 3, N'Bộ');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('SOFAGOC001', N'Sofa góc phòng khách hiện đại', '/images/sanPham/sofaGocPhongKhach.png',
        N'Sofa góc bọc nỉ cao cấp, khung gỗ chắc chắn, mang lại không gian sang trọng và thoải mái.',
        'manager', 4590000, 10, 3, N'Bộ');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('KEMY001', N'Kệ mỹ phẩm trang điểm đa năng', '/images/sanPham/keMyPhamTrangDiem.jpg',
        N'Kệ đựng mỹ phẩm nhiều ngăn giúp sắp xếp gọn gàng đồ trang điểm, thiết kế nhỏ gọn.',
        'admin', 189000, 0, 3, N'Cái');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('DELAMP01', N'Đèn ngủ để bàn phong cách Bắc Âu', '/images/sanPham/denNguBacAu.jpg',
        N'Đèn ngủ thiết kế phong cách Bắc Âu hiện đại, ánh sáng dịu nhẹ tạo cảm giác ấm áp.
Phù hợp đặt trong phòng ngủ hoặc phòng khách.',
        'admin', 189000, 5, 3, N'Cái');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('DECRACK01', N'Kệ treo tường trang trí đa năng', '/images/sanPham/keTreoTuongTrangTri.jpg',
        N'Kệ treo tường giúp trang trí và lưu trữ đồ dùng nhỏ gọn.
Thiết kế hiện đại, dễ lắp đặt và tiết kiệm không gian.',
        'manager', 159000, 0, 3, N'Cái');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('DECCARPET1', N'Thảm trải sàn phòng khách cao cấp', '/images/sanPham/thamTraiSanPhongKhach.jpg',
        N'Thảm trải sàn mềm mại, chống trượt và tạo điểm nhấn cho không gian phòng khách.
Chất liệu sợi tổng hợp bền đẹp.',
        'admin', 399000, 10, 3, N'Cái');
GO


-- =========================
-- Electrical Appliances
-- =========================

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('BK105S2VWS', N'Máy giặt Toshiba Inverter', '/images/sanPham/mayGiatToshiba.jpg',
        N'Máy giặt cửa trước Inverter Toshiba TW-BK105S2V-WS (9.5kg) với thiết kế lồng ngang hiện đại, phong cách châu Âu cùng gam màu trắng tinh tế.
Tiết kiệm điện năng với công nghệ Inverter. Khối lượng giặt: 9.5kg.',
        'manager', 7390000, 0, 2, N'Bộ');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('NAFD10AR1B', N'Máy giặt Panasonic Inverter 10.5 Kg', '/images/sanPham/mayGiatPanasonic.jpg',
        N'Công nghệ giặt Stainmaster giúp loại bỏ các vết bẩn cứng đầu và tăng hiệu quả giặt sạch quần áo.',
        'manager', 9290000, 0, 2, N'Bộ');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('NRF654GTX2', N'Tủ lạnh Panasonic Inverter 642 lít', '/images/sanPham/tuLanhPanasonic.png',
        N'Tủ lạnh 6 cửa dung tích 642 lít với mặt gương sang trọng và khay kính cường lực bền chắc.
Phù hợp cho gia đình trên 5 người, giúp sắp xếp thực phẩm tiện lợi.',
        'admin', 88990000, 0, 2, N'Bộ');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('EHE5224B-A', N'Tủ lạnh ELECTROLUX Inverter 524 Lít', '/images/sanPham/tuLanhELECTROLUX.png',
        N'Công nghệ làm mát 360° giúp duy trì nhiệt độ ổn định cho từng kệ.
Ngăn TasteLock Crisper với NutriPlus giữ trái cây và rau tươi lâu hơn.',
        'manager', 22590000, 0, 2, N'Bộ');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('AIRFRY001', N'Nồi chiên không dầu Philips 4.1L', '/images/sanPham/noiChienKhongDauPhilips.jpg',
        N'Nồi chiên không dầu dung tích 4.1L giúp chế biến món ăn ít dầu mỡ.
Công nghệ Rapid Air giúp thực phẩm chín đều và giòn.',
        'manager', 2890000, 5, 2, N'Bộ');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('BLENDER001', N'Máy xay sinh tố đa năng Panasonic', '/images/sanPham/mayXaySinhToPanasonic.jpg',
        N'Máy xay sinh tố công suất mạnh mẽ giúp xay nhuyễn trái cây, đá và thực phẩm.
Thiết kế nhỏ gọn, dễ vệ sinh.',
        'admin', 690000, 0, 2, N'Bộ');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('RICECOOK01', N'Nồi cơm điện tử Toshiba 1.8L', '/images/sanPham/noiComDienTuToshiba.jpg',
        N'Nồi cơm điện tử dung tích 1.8L phù hợp cho gia đình 4-6 người.
Nhiều chế độ nấu thông minh giúp cơm chín đều và ngon.',
        'manager', 1490000, 0, 2, N'Bộ');
GO


-- =========================
-- Sports
-- =========================

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('7823080768', N'Tạ đeo chân cao cấp', '/images/sanPham/taDeoChanCaoCap.jpg',
        N'Tạ đeo chân cao cấp phiên bản 4.0 giúp nâng cao thể lực, giảm mỡ tăng cơ và tăng sức bền.
Cấu tạo: vải polyeste siêu bền chống nước, thanh tạ thép không gỉ mạ crom.
Trọng lượng: 4kg, 5kg, 6kg, 8kg... có thể điều chỉnh.',
        'manager', 315000, 0, 4, N'Bộ');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('6075086733', N'Áo thể thao Fitme Body Compression', '/images/sanPham/aoTheThaoFitness.png',
        N'Áo thể thao Body Compression Fitme dành cho luyện tập cường độ cao.
Phù hợp gym, bóng rổ, bóng đá, bóng chuyền. Chất vải co giãn tốt, ôm cơ thể.',
        'admin', 152000, 0, 4, N'Bộ');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('8640589401', N'Xà đơn treo tường', '/images/sanPham/xaDonTreoTuong.jpg',
        N'Tập xà đơn giúp phát triển cơ bắp, mở rộng vòng ngực và giảm mỡ bụng hiệu quả.
Có thể điều chỉnh độ dài để phù hợp vị trí lắp đặt.',
        'manager', 119000, 0, 4, N'Bộ');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('9024218247', N'Máy chạy bộ trên không cao cấp', '/images/sanPham/mayChayBoTrenKhong.jpg',
        N'Máy kết hợp chạy bộ, đi bộ và tập tay giúp phát triển nhiều nhóm cơ.
Bàn để chân rộng, tay cầm bọc mút tạo cảm giác thoải mái khi tập.',
        'admin', 1020000, 0, 4, N'Bộ');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('GIANTA003', N'Giàn tạ đa năng 3 vị trí', '/images/sanPham/gianTaDaNang3ViTri.jpg',
        N'Giàn tạ đa năng hỗ trợ tập ngực, tay, vai và chân.
Khung thép chắc chắn, phù hợp cho tập luyện tại nhà.',
        'manager', 2490000, 5, 4, N'Bộ');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('CHINHCOT01', N'Dụng cụ chỉnh cột sống hỗ trợ thoát vị', '/images/sanPham/chinhCotSOng_dieuChinhThoatVi.jpg',
        N'Dụng cụ kéo giãn cột sống hỗ trợ giảm đau lưng và cải thiện tư thế.
Thiết kế tiện dụng, dễ sử dụng tại nhà.',
        'admin', 325000, 0, 4, N'Cái');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('YOGAMAT001', N'Thảm tập Yoga cao cấp chống trượt', '/images/sanPham/thamTapYoga.jpg',
        N'Thảm tập yoga chất liệu TPE cao cấp, đàn hồi tốt và chống trượt hiệu quả.
Phù hợp cho yoga, pilates và các bài tập thể dục tại nhà.',
        'admin', 189000, 0, 4, N'Cái');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('DUMBBELL01', N'Tạ tay thể hình bọc cao su', '/images/sanPham/taTayTheHinh.jpg',
        N'Tạ tay thể hình bọc cao su chống trơn trượt, phù hợp cho tập gym tại nhà.
Giúp tăng cơ bắp và nâng cao sức khỏe.',
        'manager', 245000, 5, 4, N'Bộ');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('SKIPPING01', N'Dây nhảy thể dục thể thao', '/images/sanPham/dayNhayTheThao.jpg',
        N'Dây nhảy thể dục giúp đốt cháy calo nhanh chóng và tăng cường sức bền.
Thiết kế tay cầm chống trượt, dây bền chắc.',
        'admin', 69000, 0, 4, N'Cái');
GO


-- =========================
-- Fashion
-- =========================

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('6681948644', N'Váy Babydoll Kẻ Caro Phối Nơ', '/images/sanPham/vayBabadollCaro.jpg',
        N'Mẫu váy nhẹ nhàng tiểu thư cho các nàng. Thiết kế cổ tròn phối nơ, đuôi cá.
Vải đũi xốp trắng mịn, dày dặn.',
        'admin', 109000, 0, 6, N'Cái');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('1688993802', N'Áo Sơ Mi Nam Trơn Ngắn Tay', '/images/sanPham/aoSoMiNamNganTay.jpg',
        N'Áo sơ mi nam body phù hợp cho môi trường công sở.
Thiết kế trẻ trung, năng động, giúp tôn dáng và tạo vẻ lịch lãm.',
        'admin', 99000, 0, 6, N'Chiếc');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('4494738964', N'Balo Nữ Đi Học Laptop Chống Nước Ulzzang', '/images/sanPham/baloNuChongNuoc.jpg',
        N'Thiết kế hiện đại, trẻ trung và tiện dụng.
Kích thước balo: 40 x 12 x 30 cm.',
        'admin', 105000, 0, 6, N'Cái');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('9680372888', N'Giày thể thao nữ', '/images/sanPham/giayTheThaoNu.jpg',
        N'Giày thể thao cá tính, phù hợp đi chơi hoặc tập luyện.
Đế cao su êm chân chống trơn trượt. Size 35 - 39.',
        'manager', 153000, 0, 6, N'Đôi');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('8709925437', N'Giày bốt da nam cao cổ', '/images/sanPham/giayBotDaNamCaoCo.jpg',
        N'Giày da nam phong cách bụi bặm, cá tính.
Chất da tổng hợp cao cấp, thiết kế thoáng khí. Màu: Đen, Nâu.',
        'manager', 189000, 0, 6, N'Đôi');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('TSHIRT001', N'Áo thun cổ tròn thời trang', '/images/sanPham/aoThunCoTron.png',
        N'Áo thun cotton mềm mại, thoáng mát, phù hợp cho cả nam và nữ.
Thiết kế đơn giản, dễ phối đồ.',
        'manager', 79000, 0, 6, N'Cái');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('JEANSMEN01', N'Quần jeans nam slim fit', '/images/sanPham/quanJeansNamSlimfit.jpg',
        N'Quần jeans nam form slim fit trẻ trung, chất denim bền đẹp.
Phù hợp mặc đi chơi hoặc đi làm.',
        'manager', 219000, 10, 6, N'Cái');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('HANDBAG01', N'Túi xách nữ thời trang', '/images/sanPham/tuiXachNuThoiTrang.jpg',
        N'Túi xách nữ thiết kế thanh lịch, phù hợp đi làm hoặc đi chơi.
Chất liệu da tổng hợp bền đẹp.',
        'admin', 259000, 0, 6, N'Cái');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('CAPFASHION', N'Mũ lưỡi trai thời trang unisex', '/images/sanPham/muLuoiTraiThoiTrang.jpg',
        N'Mũ lưỡi trai phong cách trẻ trung, dễ phối đồ cho cả nam và nữ.
Chất vải thoáng mát, phù hợp hoạt động ngoài trời.',
        'manager', 79000, 0, 6, N'Cái');
GO


-- =========================
-- Smart Appliances
-- =========================

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('11MAX64213', N'Điện Thoại iPhone 11 Pro Max 64GB', '/images/sanPham/iPhone11_ProMax.jpg',
        N'iPhone 11 Pro Max là phiên bản cao cấp với nhiều cải tiến về hiệu năng và thiết kế.
Cụm camera sau được thiết kế mới nổi bật, mang lại khả năng chụp ảnh ấn tượng.',
        'admin', 26500000, 0, 5, N'Cái');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('10NOTEP256', N'Samsung Galaxy Note 10 Plus', '/images/sanPham/samsungGalaxyNote10Plus.jpg',
        N'Thiết kế kính cường lực Gorilla Glass 6 cao cấp với màu sắc nổi bật.
Giao diện trực quan giúp thao tác sử dụng Galaxy Note10+ trở nên dễ dàng và tiện lợi.',
        'admin', 25450000, 0, 5, N'Cái');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('XRN8012121', N'Xiaomi Redmi Note 8', '/images/sanPham/XiaomiRedmiNote8.jpg',
        N'Smartphone trang bị hệ thống 4 camera, camera chính độ phân giải 48MP
giúp chụp ảnh rõ nét và chi tiết.',
        'manager', 3750000, 0, 5, N'Cái');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('Y98HEAD802', N'Tai nghe bluetooth thể thao Y98', '/images/sanPham/TaiNgheBluetoothY98.jpg',
        N'Tai nghe bluetooth giúp nghe nhạc khi tập luyện thể thao,
tăng động lực và hiệu quả luyện tập.',
        'manager', 299000, 0, 5, N'Bộ');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('SMARTAMA01', N'Đồng hồ thông minh AMA SmartWatch', '/images/sanPham/smartWatchAMA.jpg',
        N'Đồng hồ thông minh theo dõi sức khỏe, đo nhịp tim, đếm bước chân
và hiển thị thông báo từ điện thoại.',
        'manager', 1290000, 5, 5, N'Cái');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('APPLECHRG1', N'Đế sạc không dây Apple MagSafe', '/images/sanPham/deSacKhongDayApple.jpg',
        N'Đế sạc không dây chuẩn MagSafe tương thích iPhone và AirPods.
Thiết kế nhỏ gọn, sạc nhanh và tiện lợi.',
        'admin', 890000, 0, 5, N'Cái');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('TABGXY01', N'Máy tính bảng Samsung Galaxy Tab A8', '/images/sanPham/samsungGalaxyTabA8.jpg',
        N'Máy tính bảng màn hình lớn 10.5 inch phù hợp cho học tập, làm việc và giải trí.
Pin dung lượng cao giúp sử dụng lâu dài.',
        'manager', 6890000, 5, 5, N'Cái');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('CAMERAIP01', N'Camera an ninh IP Wifi thông minh', '/images/sanPham/cameraIPWifi.jpg',
        N'Camera giám sát thông minh kết nối Wifi, hỗ trợ xem từ xa qua điện thoại.
Tích hợp chế độ ghi hình ban đêm và phát hiện chuyển động.',
        'admin', 590000, 0, 5, N'Cái');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('SPEAKER01', N'Loa bluetooth mini chống nước', '/images/sanPham/loaBluetoothMini.jpg',
        N'Loa bluetooth mini thiết kế nhỏ gọn, âm thanh mạnh mẽ.
Chuẩn chống nước IPX5 phù hợp mang theo khi đi du lịch hoặc dã ngoại.',
        'manager', 399000, 10, 5, N'Cái');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('SMARTTV001', N'Smart TV Samsung 4K 50 inch', '/images/sanPham/smartTvSamsung4K.jpg',
        N'Smart TV Samsung độ phân giải 4K UHD cho hình ảnh sắc nét và sống động.
Hỗ trợ kết nối Wifi, xem YouTube, Netflix và nhiều ứng dụng giải trí.',
        'admin', 10990000, 5, 5, N'Cái');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('ROUTERWF01', N'Router Wifi băng tần kép TP-Link', '/images/sanPham/routerWifiTPLINK.jpg',
        N'Router Wifi chuẩn AC tốc độ cao, hỗ trợ băng tần kép 2.4GHz và 5GHz.
Phù hợp cho gia đình hoặc văn phòng nhỏ.',
        'manager', 890000, 0, 5, N'Cái');
GO

INSERT INTO Products (productId, productName, productImage, brief, account, price, discount, typeId, unit)
VALUES ('POWERSMRT1', N'Ổ cắm điện thông minh điều khiển từ xa', '/images/sanPham/oCamThongMinh.jpg',
        N'Ổ cắm thông minh cho phép bật tắt thiết bị điện qua ứng dụng điện thoại.
Hỗ trợ hẹn giờ và tiết kiệm điện năng.',
        'admin', 259000, 0, 5, N'Cái');
GO