-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Май 10 2025 г., 14:12
-- Версия сервера: 10.5.17-MariaDB
-- Версия PHP: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `delivery_db`
--

-- --------------------------------------------------------

--
-- Структура таблицы `clients`
--

CREATE TABLE `clients` (
  `id` int(11) NOT NULL,
  `type` enum('individual','legal') COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `legal_name` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brand_photo` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `inn` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ogrn` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kpp` varchar(9) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `clients`
--

INSERT INTO `clients` (`id`, `type`, `name`, `phone`, `email`, `address`, `legal_name`, `brand_photo`, `inn`, `ogrn`, `kpp`, `bank_details`) VALUES
(1, 'legal', 'интернет-магазин «Пятёрочка»', '+74955029750', 'credits@5ka.ru', 'Россия, 191025, г. Санкт-Петербург, пр. Невский, 90/92', 'Общество с ограниченной ответственностью «Агроторг»', 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Pyatyorochka_logo.svg/1200px-Pyatyorochka_logo.svg.png', '7825706086', '1027809237796', '997750001', '{\"bank\": \"Сбербанк\", \"account\": \"40702810538000012345\", \"bik\": \"044525225\"}'),
(2, 'legal', 'Магнит', '+78612040607', 'info@magnit.ru', 'Краснодар, ул. Солнечная, 15', 'ПАО \"Магнит\"', 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Magnit_retail_chain_logo.svg/1280px-Magnit_retail_chain_logo.svg.png', '2310020630', '1022303944328', '231001001', '{\"bank\": \"ВТБ\", \"account\": \"40702810700000054321\", \"bik\": \"044525187\"}'),
(3, 'legal', 'СберМаркет', '+74959887766', 'support@sbermarket.ru', 'Москва, ул. Кузнецкий Мост, 21/5', 'ООО \"СберМаркет\"', 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/SberMarket_logo.svg/1200px-SberMarket_logo.svg.png', '9703123456', '1187746789321', '770301001', '{\"bank\": \"Сбербанк\", \"account\": \"40702810600000098765\", \"bik\": \"044525225\"}'),
(4, 'legal', 'Wildberries', '+74956665544', 'press@wildberries.ru', 'Москва, проспект Андропова, 18', 'ООО \"Вайлдберриз\"', 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Wildberries_logo.svg/1280px-Wildberries_logo.svg.png', '7728286337', '1167746225638', '997750001', '{\"bank\": \"Альфа-Банк\", \"account\": \"40702810600000011111\", \"bik\": \"044525593\"}'),
(5, 'legal', 'Ozon', '+74952323232', 'pr@ozon.ru', 'Москва, ул. Ленинская Слобода, 26', 'АО \"Ozon\"', 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Ozon_Logo_2020.svg/1200px-Ozon_Logo_2020.svg.png', '7728394530', '1027700067328', '997750001', '{\"bank\": \"Тинькофф\", \"account\": \"40702810700000022222\", \"bik\": \"044525974\"}');

-- --------------------------------------------------------

--
-- Структура таблицы `couriers`
--

CREATE TABLE `couriers` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL COMMENT 'ФИО курьера',
  `photo` text DEFAULT NULL,
  `phone` varchar(20) NOT NULL COMMENT 'Контактный телефон',
  `email` varchar(100) DEFAULT NULL COMMENT 'Email (опционально)',
  `vehicle_type` enum('foot','bicycle','car','scooter') DEFAULT 'foot' COMMENT 'Тип транспорта',
  `status` enum('free','busy','on_break','offline') DEFAULT 'free' COMMENT 'Текущий статус',
  `current_location` varchar(255) DEFAULT NULL COMMENT 'Последние известные координаты/адрес (опционально)',
  `registration_date` timestamp NULL DEFAULT current_timestamp() COMMENT 'Дата регистрации в системе',
  `last_activity` timestamp NULL DEFAULT NULL COMMENT 'Время последней активности',
  `notes` text DEFAULT NULL COMMENT 'Дополнительные заметки'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Таблица курьеров';

--
-- Дамп данных таблицы `couriers`
--

INSERT INTO `couriers` (`id`, `name`, `photo`, `phone`, `email`, `vehicle_type`, `status`, `current_location`, `registration_date`, `last_activity`, `notes`) VALUES
(1, 'Иванов Алексей Петрович', 'https://example.com/photos/courier1.jpg', '+79161234501', 'ivanov@delivery.ru', 'car', 'busy', '55.755826,37.617300', '2025-04-13 17:51:55', '2023-11-15 05:45:23', 'Аккуратный водитель, всегда вовремя'),
(2, 'Петрова Анна Сергеевна', 'https://example.com/photos/courier2.jpg', '+79161234502', 'petrova@delivery.ru', 'bicycle', 'free', '55.760023,37.608856', '2025-04-13 17:51:55', '2023-11-15 06:12:47', 'Работает только в центре города'),
(3, 'Сидоров Дмитрий Игоревич', 'https://example.com/photos/courier3.jpg', '+79161234503', 'sidorov@delivery.ru', 'scooter', 'on_break', '55.752023,37.622456', '2025-04-13 17:51:55', '2023-11-15 07:30:12', 'Быстрый, но иногда опаздывает'),
(4, 'Козлова Марина Викторовна', 'https://example.com/photos/courier4.jpg', '+79161234504', 'kozlova@delivery.ru', 'foot', 'free', '55.758023,37.615456', '2025-04-13 17:51:55', '2023-11-15 08:45:33', 'Пеший курьер, работает в радиусе 3 км'),
(5, 'Васильев Артем Олегович', 'https://example.com/photos/courier5.jpg', '+79161234505', 'vasiliev@delivery.ru', 'car', 'busy', '55.750023,37.625456', '2025-04-13 17:51:55', '2023-11-15 09:15:21', 'Имеет грузовой автомобиль для крупных заказов'),
(6, 'Николаева Елена Дмитриевна', 'https://example.com/photos/courier6.jpg', '+79161234506', 'nikolaeva@delivery.ru', 'bicycle', 'free', '55.753023,37.620456', '2025-04-13 17:51:55', '2023-11-15 10:22:09', 'Велокурьер, работает с 10 до 18'),
(7, 'Морозов Павел Сергеевич', 'https://example.com/photos/courier7.jpg', '+79161234507', 'morozov@delivery.ru', 'scooter', 'offline', '55.756023,37.618456', '2025-04-13 17:51:55', '2023-11-14 15:30:45', 'В отпуске до 20 ноября'),
(8, 'Федорова Ольга Игоревна', 'https://example.com/photos/courier8.jpg', '+79161234508', 'fedorova@delivery.ru', 'foot', 'free', '55.751023,37.624456', '2025-04-13 17:51:55', '2023-11-15 11:05:17', 'Новый курьер, стаж 1 месяц'),
(9, 'Григорьев Иван Васильевич', 'https://example.com/photos/courier9.jpg', '+79161234509', 'grigoriev@delivery.ru', 'car', 'busy', '55.759023,37.610456', '2025-04-13 17:51:55', '2023-11-15 12:20:38', 'Опытный курьер, работает 5 лет'),
(10, 'Семенова Анастасия Андреевна', 'https://example.com/photos/courier10.jpg', '+79161234510', 'semenova@delivery.ru', 'bicycle', 'on_break', '55.754023,37.619456', '2025-04-13 17:51:55', '2023-11-15 13:10:52', 'Специализируется на доставке еды');

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL COMMENT 'ID клиента (магазина/юрлица)',
  `courier_id` int(11) DEFAULT NULL COMMENT 'ID назначенного курьера (если есть)',
  `order_number` varchar(20) DEFAULT NULL COMMENT 'Уникальный номер заказа (например, "ORD-2023-1001")',
  `items` text NOT NULL COMMENT 'Описание товаров (JSON или простой текст)',
  `total_price` decimal(10,2) NOT NULL COMMENT 'Общая стоимость заказа',
  `delivery_price` decimal(10,2) DEFAULT NULL COMMENT 'Стоимость доставки',
  `address` text NOT NULL COMMENT 'Адрес доставки',
  `status` enum('new','processing','assigned','in_progress','delivered','canceled') DEFAULT 'new' COMMENT 'Статус заказа',
  `customer_name` varchar(100) DEFAULT NULL COMMENT 'Имя конечного покупателя (если известно)',
  `customer_phone` varchar(20) DEFAULT NULL COMMENT 'Телефон покупателя (если известен)',
  `created_at` timestamp NULL DEFAULT current_timestamp() COMMENT 'Дата создания',
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Дата обновления',
  `notes` text DEFAULT NULL COMMENT 'Примечания менеджера'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Таблица заказов';

--
-- Дамп данных таблицы `orders`
--

INSERT INTO `orders` (`id`, `client_id`, `courier_id`, `order_number`, `items`, `total_price`, `delivery_price`, `address`, `status`, `customer_name`, `customer_phone`, `created_at`, `updated_at`, `notes`) VALUES
(11, 1, 1, 'ORD-2023-1001', '[{\"name\": \"Молоко\", \"price\": 85, \"quantity\": 2}, {\"name\": \"Хлеб\", \"price\": 45, \"quantity\": 1}]', '215.00', '0.00', 'Москва, ул. Тверская, 15, кв. 42', 'delivered', 'Иванова Мария', '+79161234567', '2025-04-13 17:52:10', '2025-04-13 17:52:10', 'Оставить у двери'),
(12, 2, 2, 'ORD-2023-1002', '[{\"name\": \"Яйца\", \"price\": 120, \"quantity\": 1}, {\"name\": \"Масло\", \"price\": 180, \"quantity\": 1}]', '300.00', '50.00', 'Краснодар, ул. Красная, 32, кв. 12', 'in_progress', 'Петров Алексей', '+79261234567', '2025-04-13 17:52:10', '2025-04-13 17:52:10', 'Позвонить за 15 мин'),
(13, 3, 3, 'ORD-2023-1003', '[{\"name\": \"Смартфон\", \"price\": 25990, \"quantity\": 1}]', '25990.00', '300.00', 'Санкт-Петербург, Невский пр., 45, офис 10', 'assigned', 'Сидорова Анна', '+79361234567', '2025-04-13 17:52:10', '2025-04-13 17:52:10', 'Требуется подпись'),
(14, 4, NULL, 'ORD-2023-1004', '[{\"name\": \"Футболка\", \"price\": 1499, \"quantity\": 2}, {\"name\": \"Джинсы\", \"price\": 3990, \"quantity\": 1}]', '6988.00', '0.00', 'Екатеринбург, ул. Ленина, 5, кв. 7', 'new', 'Козлов Дмитрий', '+79461234567', '2025-04-13 17:52:10', '2025-04-13 17:52:10', NULL),
(15, 5, NULL, 'ORD-2023-1005', '[{\"name\": \"Книга\", \"price\": 890, \"quantity\": 1}, {\"name\": \"Наушники\", \"price\": 4990, \"quantity\": 1}]', '5880.00', '150.00', 'Казань, ул. Баумана, 18', 'processing', 'Мухаметов Ильдар', '+79561234567', '2025-04-13 17:52:10', '2025-04-13 17:52:10', 'Хрупкое!'),
(16, 1, 1, 'ORD-2023-1006', '[{\"name\": \"Вода\", \"price\": 65, \"quantity\": 3}, {\"name\": \"Печенье\", \"price\": 120, \"quantity\": 2}]', '435.00', '0.00', 'Москва, ул. Арбат, 33, кв. 21', 'delivered', 'Смирнова Ольга', '+79661234567', '2025-04-13 17:52:10', '2025-04-13 17:52:10', 'Код от подъезда: 1234'),
(17, 2, 2, 'ORD-2023-1007', '[{\"name\": \"Мясо\", \"price\": 450, \"quantity\": 2}, {\"name\": \"Овощи\", \"price\": 230, \"quantity\": 1}]', '1130.00', '80.00', 'Сочи, ул. Навагинская, 7, кв. 5', 'canceled', 'Волков Сергей', '+79761234567', '2025-04-13 17:52:10', '2025-04-13 17:52:10', 'Отмена по инициативе клиента'),
(18, 3, NULL, 'ORD-2023-1008', '[{\"name\": \"Ноутбук\", \"price\": 78990, \"quantity\": 1}]', '78990.00', '500.00', 'Новосибирск, ул. Ленина, 12, офис 305', 'new', 'Кузнецов Павел', '+79861234567', '2025-04-13 17:52:10', '2025-04-13 17:52:10', 'Доставить с 10 до 18'),
(19, 4, 3, 'ORD-2023-1009', '[{\"name\": \"Куртка\", \"price\": 8990, \"quantity\": 1}]', '8990.00', '0.00', 'Владивосток, ул. Светланская, 33, кв. 11', 'in_progress', 'Лебедева Екатерина', '+79961234567', '2025-04-13 17:52:10', '2025-04-13 17:52:10', 'Размер L'),
(20, 5, NULL, 'ORD-2023-1010', '[{\"name\": \"Игрушка\", \"price\": 2490, \"quantity\": 1}, {\"name\": \"Коврик\", \"price\": 3590, \"quantity\": 1}]', '6080.00', '200.00', 'Ростов-на-Дону, ул. Большая Садовая, 10', 'processing', 'Морозов Андрей', '+79031234567', '2025-04-13 17:52:10', '2025-04-13 17:52:10', 'Подарочная упаковка'),
(21, 1, 1, 'ORD-2023-10012', '[{\"name\": \"Молоко\", \"price\": 85, \"quantity\": 2}, {\"name\": \"Хлеб\", \"price\": 45, \"quantity\": 1}]', '1000.00', '100.00', '123 Duck Street', 'new', 'John Doe', '+1234567890', '2025-04-21 14:47:32', '2025-04-21 14:47:32', 'Leave at the front door'),
(34, 1, 1, 'ORD-2025-92000', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":4},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":2}]', '521.21', '92.94', '220 Duck Street', 'new', 'Customer 830', '+1903232768', '2025-04-21 14:58:53', '2025-04-21 14:58:53', 'Leave at the front door'),
(35, 1, 1, 'ORD-2025-65040', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":2},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '898.15', '76.48', '712 Duck Street', 'new', 'Customer 799', '+5728169069', '2025-04-21 14:58:53', '2025-04-21 14:58:53', 'Leave at the front door'),
(36, 1, 1, 'ORD-2025-91595', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":5},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '798.22', '123.00', '856 Duck Street', 'new', 'Customer 156', '+5596948384', '2025-04-21 14:58:54', '2025-04-21 14:58:54', 'Leave at the front door'),
(37, 1, 1, 'ORD-2025-20174', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":3},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '1118.90', '79.25', '285 Duck Street', 'new', 'Customer 682', '+6368692930', '2025-04-21 14:58:54', '2025-04-21 14:58:54', 'Leave at the front door'),
(38, 1, 1, 'ORD-2025-86750', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":5},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '795.22', '133.47', '559 Duck Street', 'new', 'Customer 940', '+6127304240', '2025-04-21 14:59:24', '2025-04-21 14:59:24', 'Leave at the front door'),
(39, 1, 1, 'ORD-2025-82089', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":3},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '881.57', '139.55', '493 Duck Street', 'new', 'Customer 978', '+7587123658', '2025-04-21 14:59:24', '2025-04-21 14:59:24', 'Leave at the front door'),
(40, 1, 1, 'ORD-2025-40788', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":4},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '746.37', '140.19', '117 Duck Street', 'new', 'Customer 321', '+7416373939', '2025-04-21 14:59:26', '2025-04-21 14:59:26', 'Leave at the front door'),
(41, 1, 1, 'ORD-2025-18969', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":4},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '1395.88', '61.50', '46 Duck Street', 'new', 'Customer 300', '+5899387142', '2025-04-21 14:59:26', '2025-04-21 14:59:26', 'Leave at the front door'),
(42, 1, 1, 'ORD-2025-85437', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":2},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '1499.76', '107.12', '777 Duck Street', 'new', 'Customer 187', '+8775080422', '2025-04-21 15:00:07', '2025-04-21 15:00:07', 'Leave at the front door'),
(43, 1, 1, 'ORD-2025-39653', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":4},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '1241.87', '110.57', '584 Duck Street', 'new', 'Customer 328', '+7899570725', '2025-04-21 15:00:07', '2025-04-21 15:00:07', 'Leave at the front door'),
(44, 1, 1, 'ORD-2025-78283', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":1},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '558.45', '114.63', '758 Duck Street', 'new', 'Customer 342', '+9699238952', '2025-04-21 15:00:48', '2025-04-21 15:00:48', 'Leave at the front door'),
(45, 1, 1, 'ORD-2025-28264', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":5},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '1024.74', '60.44', '871 Duck Street', 'new', 'Customer 91', '+2925184485', '2025-04-21 15:00:48', '2025-04-21 15:00:48', 'Leave at the front door'),
(46, 1, 1, 'ORD-2025-79904', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":2},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '1340.39', '101.00', '107 Duck Street', 'new', 'Customer 571', '+2015340121', '2025-04-21 15:00:52', '2025-04-21 15:00:52', 'Leave at the front door'),
(47, 1, 1, 'ORD-2025-75819', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":5},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":2}]', '899.85', '128.54', '666 Duck Street', 'new', 'Customer 570', '+1496701350', '2025-04-21 15:00:52', '2025-04-21 15:00:52', 'Leave at the front door'),
(48, 1, 1, 'ORD-2025-95820', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":3},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":2}]', '825.12', '82.47', '971 Duck Street', 'new', 'Customer 762', '+2184760799', '2025-04-21 15:03:23', '2025-04-21 15:03:23', 'Leave at the front door'),
(49, 1, 1, 'ORD-2025-57103', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":2},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '1171.59', '91.59', '485 Duck Street', 'new', 'Customer 263', '+2484412880', '2025-04-21 15:03:23', '2025-04-21 15:03:23', 'Leave at the front door'),
(50, 1, 1, 'ORD-2025-65062', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":1},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":2}]', '1017.74', '125.32', '396 Duck Street', 'new', 'Customer 455', '+3078470767', '2025-04-21 15:03:26', '2025-04-21 15:03:26', 'Leave at the front door'),
(51, 1, 1, 'ORD-2025-48190', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":1},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":2}]', '822.66', '122.30', '3 Duck Street', 'new', 'Customer 827', '+9091186270', '2025-04-21 15:03:26', '2025-04-21 15:03:26', 'Leave at the front door'),
(52, 1, 1, 'ORD-2025-85104', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":2},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '1153.64', '137.29', '23 Duck Street', 'new', 'Customer 567', '+4426574545', '2025-04-21 15:05:02', '2025-04-21 15:05:02', 'Leave at the front door'),
(53, 1, 1, 'ORD-2025-70521', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":2},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '1481.05', '59.76', '590 Duck Street', 'new', 'Customer 105', '+1142872188', '2025-04-21 15:05:02', '2025-04-21 15:05:02', 'Leave at the front door'),
(54, 1, 1, 'ORD-2025-55160', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":5},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":2}]', '669.50', '85.82', '494 Duck Street', 'new', 'Customer 821', '+8334972069', '2025-04-21 15:05:06', '2025-04-21 15:05:06', 'Leave at the front door'),
(55, 1, 1, 'ORD-2025-47127', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":2},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":2}]', '1271.92', '108.73', '557 Duck Street', 'new', 'Customer 7', '+6915664717', '2025-04-21 15:05:06', '2025-04-21 15:05:06', 'Leave at the front door'),
(56, 1, 1, 'ORD-2025-54738', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":4},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '1470.42', '149.76', '534 Duck Street', 'new', 'Customer 299', '+4223226263', '2025-04-21 15:05:14', '2025-04-21 15:05:14', 'Leave at the front door'),
(57, 1, 1, 'ORD-2025-47039', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":4},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":2}]', '1349.46', '51.07', '621 Duck Street', 'new', 'Customer 46', '+6969444172', '2025-04-21 15:05:15', '2025-04-21 15:05:15', 'Leave at the front door'),
(58, 1, 1, 'ORD-2025-24152', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":2},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":2}]', '549.06', '144.94', '95 Duck Street', 'new', 'Customer 468', '+5447685195', '2025-04-21 15:05:15', '2025-04-21 15:05:15', 'Leave at the front door'),
(59, 1, 1, 'ORD-2025-20200', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":1},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '779.09', '126.12', '98 Duck Street', 'new', 'Customer 437', '+6362447077', '2025-04-21 15:06:25', '2025-04-21 15:06:25', 'Leave at the front door'),
(60, 1, 1, 'ORD-2025-95206', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":2},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":2}]', '1339.92', '103.98', '105 Duck Street', 'new', 'Customer 932', '+8891247833', '2025-04-21 15:06:25', '2025-04-21 15:06:25', 'Leave at the front door'),
(61, 1, 1, 'ORD-2025-74105', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":3},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '1042.63', '134.28', '614 Duck Street', 'new', 'Customer 855', '+2338816450', '2025-04-21 15:09:29', '2025-04-21 15:09:29', 'Leave at the front door'),
(62, 1, 1, 'ORD-2025-66597', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":2},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '1135.70', '106.02', '19 Duck Street', 'new', 'Customer 112', '+6789795712', '2025-04-21 15:09:29', '2025-04-21 15:09:29', 'Leave at the front door'),
(63, 1, 1, 'ORD-2025-48432', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":4},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '1234.50', '125.65', '106 Duck Street', 'new', 'Customer 633', '+9804645344', '2025-04-21 15:09:29', '2025-04-21 15:09:29', 'Leave at the front door'),
(64, 1, 1, 'ORD-2025-88365', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":4},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '1199.49', '138.48', '534 Duck Street', 'new', 'Customer 38', '+5513186816', '2025-04-21 15:09:30', '2025-04-21 15:09:30', 'Leave at the front door'),
(65, 1, 1, 'ORD-2025-87002', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":3},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '807.43', '88.22', '858 Duck Street', 'new', 'Customer 4', '+9792681473', '2025-04-21 15:09:30', '2025-04-21 15:09:30', 'Leave at the front door'),
(66, 1, 1, 'ORD-2025-82974', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":2},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '539.93', '107.79', '622 Duck Street', 'new', 'Customer 635', '+6678974209', '2025-04-21 15:09:30', '2025-04-21 15:09:30', 'Leave at the front door'),
(67, 1, 1, 'ORD-2025-21105', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":3},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":2}]', '915.85', '96.07', '38 Duck Street', 'new', 'Customer 714', '+1303174074', '2025-04-21 15:09:48', '2025-04-21 15:09:48', 'Leave at the front door'),
(68, 1, 1, 'ORD-2025-29738', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":2},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '1192.85', '102.03', '356 Duck Street', 'new', 'Customer 293', '+8265753249', '2025-04-21 15:09:48', '2025-04-21 15:09:48', 'Leave at the front door'),
(69, 1, 1, 'ORD-2025-59087', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":5},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '794.56', '129.64', '334 Duck Street', 'new', 'Customer 2', '+4442059735', '2025-04-21 15:09:48', '2025-04-21 15:09:48', 'Leave at the front door'),
(70, 1, 1, 'ORD-2025-85379', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":2},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '1201.31', '144.94', '776 Duck Street', 'new', 'Customer 315', '+9349166789', '2025-04-21 15:09:50', '2025-04-21 15:09:50', 'Leave at the front door'),
(71, 1, 1, 'ORD-2025-81126', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":3},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '1187.09', '95.50', '485 Duck Street', 'new', 'Customer 657', '+5636898170', '2025-04-21 15:09:50', '2025-04-21 15:09:50', 'Leave at the front door'),
(72, 1, 1, 'ORD-2025-40048', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":4},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '1204.16', '135.98', '687 Duck Street', 'new', 'Customer 786', '+6469166862', '2025-04-21 15:09:50', '2025-04-21 15:09:50', 'Leave at the front door'),
(73, 1, 1, 'ORD-2025-80329', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":1},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '1333.36', '53.79', '662 Duck Street', 'new', 'Customer 710', '+6420727816', '2025-04-21 15:13:35', '2025-04-21 15:13:35', 'Leave at the front door'),
(74, 1, 1, 'ORD-2025-14628', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":4},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '580.57', '112.90', '292 Duck Street', 'new', 'Customer 67', '+5391237661', '2025-04-21 15:13:38', '2025-04-21 15:13:38', 'Leave at the front door'),
(75, 1, 1, 'ORD-2025-88223', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":1},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":2}]', '1209.66', '134.57', '549 Duck Street', 'new', 'Customer 392', '+7717643268', '2025-04-21 15:20:19', '2025-04-21 15:20:19', 'Leave at the front door'),
(76, 1, 1, 'ORD-2025-99009', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":3},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '1302.48', '100.37', '179 Duck Street', 'new', 'Customer 72', '+6734600006', '2025-04-21 15:20:19', '2025-04-21 15:20:19', 'Leave at the front door'),
(77, 1, 1, 'ORD-2025-39152', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":2},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '1293.87', '118.02', '480 Duck Street', 'new', 'Customer 878', '+1173370073', '2025-04-21 15:22:06', '2025-04-21 15:22:06', 'Leave at the front door'),
(78, 1, 1, 'ORD-2025-19418', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":4},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '1474.39', '61.51', '905 Duck Street', 'new', 'Customer 224', '+8485092683', '2025-04-21 15:22:09', '2025-04-21 15:22:09', 'Leave at the front door'),
(79, 1, 1, 'ORD-2025-82445', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":2},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":2}]', '848.73', '142.11', '561 Duck Street', 'new', 'Customer 51', '+6361838926', '2025-04-21 15:22:12', '2025-04-21 15:22:12', 'Leave at the front door'),
(80, 1, 1, 'ORD-2025-13472', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":2},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '1316.33', '149.46', '121 Duck Street', 'new', 'Customer 942', '+8342590359', '2025-04-21 15:22:12', '2025-04-21 15:22:12', 'Leave at the front door'),
(81, 1, 1, 'ORD-2025-21278', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":5},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":2}]', '1145.61', '60.93', '858 Duck Street', 'new', 'Customer 208', '+5217816160', '2025-04-21 15:22:24', '2025-04-21 15:22:24', 'Leave at the front door'),
(82, 1, 1, 'ORD-2025-98999', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":3},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '953.01', '85.92', '447 Duck Street', 'new', 'Customer 680', '+9691974225', '2025-04-21 15:23:33', '2025-04-21 15:23:33', 'Leave at the front door'),
(83, 1, 1, 'ORD-2025-65593', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":3},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '1273.04', '129.72', '464 Duck Street', 'new', 'Customer 743', '+4196229236', '2025-04-21 15:25:48', '2025-04-21 15:25:48', 'Leave at the front door'),
(84, 1, 1, 'ORD-2025-39794', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":4},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '926.02', '83.26', '895 Duck Street', 'new', 'Customer 319', '+4388205944', '2025-04-21 15:25:53', '2025-04-21 15:25:53', 'Leave at the front door'),
(85, 1, 1, 'ORD-2025-45821', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":4},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '1042.31', '127.00', '632 Duck Street', 'new', 'Customer 261', '+3886657382', '2025-04-21 15:25:54', '2025-04-21 15:25:54', 'Leave at the front door'),
(86, 1, 1, 'ORD-2025-46010', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":1},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '636.97', '103.10', '151 Duck Street', 'new', 'Customer 911', '+6709588748', '2025-04-21 15:25:56', '2025-04-21 15:25:56', 'Leave at the front door'),
(87, 1, 1, 'ORD-2025-38614', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":2},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '727.30', '50.99', '666 Duck Street', 'new', 'Customer 717', '+3535580514', '2025-04-21 15:25:58', '2025-04-21 15:25:58', 'Leave at the front door'),
(88, 1, 1, 'ORD-2025-60541', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":2},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":2}]', '1031.16', '108.00', '18 Duck Street', 'new', 'Customer 994', '+6679680969', '2025-04-21 15:28:54', '2025-04-21 15:28:54', 'Leave at the front door'),
(89, 1, 1, 'ORD-2025-65320', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":1},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '1440.31', '113.22', '366 Duck Street', 'new', 'Customer 568', '+7781968766', '2025-04-21 15:29:23', '2025-04-21 15:29:23', 'Leave at the front door'),
(90, 1, 1, 'ORD-2025-75988', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":4},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":2}]', '575.34', '134.63', '898 Duck Street', 'new', 'Customer 913', '+8654336635', '2025-04-21 15:29:24', '2025-04-21 15:29:24', 'Leave at the front door'),
(91, 1, 1, 'ORD-2025-11916', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":2},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":2}]', '1349.27', '73.81', '279 Duck Street', 'new', 'Customer 651', '+3303681329', '2025-04-21 15:29:37', '2025-04-21 15:29:37', 'Leave at the front door'),
(92, 1, 1, 'ORD-2025-43020', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":3},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '1333.35', '89.93', '535 Duck Street', 'new', 'Customer 10', '+3522843746', '2025-04-21 15:29:38', '2025-04-21 15:29:38', 'Leave at the front door'),
(93, 1, 1, 'ORD-2025-24822', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":2},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":2}]', '533.84', '122.39', '51 Duck Street', 'new', 'Customer 482', '+1405773683', '2025-04-21 15:30:12', '2025-04-21 15:30:12', 'Leave at the front door'),
(94, 1, 1, 'ORD-2025-94883', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":4},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":2}]', '707.85', '83.52', '461 Duck Street', 'new', 'Customer 681', '+4581997596', '2025-04-21 15:30:13', '2025-04-21 15:30:13', 'Leave at the front door'),
(95, 1, 1, 'ORD-2025-92015', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":1},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '1132.38', '94.25', '759 Duck Street', 'new', 'Customer 100', '+8348483487', '2025-04-21 15:30:35', '2025-04-21 15:30:35', 'Leave at the front door'),
(96, 1, 1, 'ORD-2025-35162', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":3},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":2}]', '1003.99', '84.97', '459 Duck Street', 'new', 'Customer 35', '+7141669442', '2025-04-21 15:30:46', '2025-04-21 15:30:46', 'Leave at the front door'),
(97, 1, 1, 'ORD-2025-17509', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":3},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '656.35', '135.14', '654 Duck Street', 'new', 'Customer 710', '+2287273872', '2025-04-21 15:31:08', '2025-04-21 15:31:08', 'Leave at the front door'),
(98, 1, 1, 'ORD-2025-42187', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":5},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '780.73', '70.18', '109 Duck Street', 'new', 'Customer 899', '+9030725944', '2025-04-21 15:31:09', '2025-04-21 15:31:09', 'Leave at the front door'),
(99, 1, 1, 'ORD-2025-57274', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":1},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":2}]', '1491.18', '99.92', '912 Duck Street', 'new', 'Customer 375', '+8794185394', '2025-04-21 15:31:22', '2025-04-21 15:31:22', 'Leave at the front door'),
(100, 1, 1, 'ORD-2025-33469', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":4},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":2}]', '1403.30', '89.27', '987 Duck Street', 'new', 'Customer 435', '+5549818354', '2025-04-21 15:31:23', '2025-04-21 15:31:23', 'Leave at the front door'),
(101, 1, 1, 'ORD-2025-94651', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":3},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":2}]', '1156.07', '140.01', '329 Duck Street', 'new', 'Customer 194', '+7953081444', '2025-04-21 15:31:58', '2025-04-21 15:31:58', 'Leave at the front door'),
(102, 1, 1, 'ORD-2025-37311', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":3},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '961.81', '81.87', '426 Duck Street', 'new', 'Customer 437', '+2856146749', '2025-04-21 15:33:30', '2025-04-21 15:33:30', 'Leave at the front door'),
(104, 1, 1, 'ORD-2025-51933', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":3},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '1425.16', '62.48', '997 Duck Street', 'new', 'Customer 835', '+1476583644', '2025-04-21 15:33:40', '2025-04-21 15:33:40', 'Leave at the front door'),
(105, 1, 1, 'ORD-2025-44753', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":4},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":2}]', '959.12', '117.67', '138 Duck Street', 'new', 'Customer 893', '+1671141085', '2025-04-21 15:33:47', '2025-04-21 15:33:47', 'Leave at the front door'),
(106, 1, 1, 'ORD-2025-12720', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":2},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '767.63', '137.87', '9 Duck Street', 'new', 'Customer 152', '+6609762617', '2025-04-21 15:34:06', '2025-04-21 15:34:06', 'Leave at the front door'),
(107, 1, 1, 'ORD-2025-91339', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":1},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '1254.30', '131.83', '279 Duck Street', 'new', 'Customer 724', '+9192592956', '2025-04-21 15:34:06', '2025-04-21 15:34:06', 'Leave at the front door'),
(108, 1, 1, 'ORD-2025-36359', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":4},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":2}]', '1397.75', '63.61', '359 Duck Street', 'new', 'Customer 252', '+2020527985', '2025-04-21 15:34:13', '2025-04-21 15:34:13', 'Leave at the front door'),
(109, 1, 1, 'ORD-2025-83546', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":3},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '867.10', '83.56', '576 Duck Street', 'new', 'Customer 78', '+2649249190', '2025-04-21 15:34:20', '2025-04-21 15:34:20', 'Leave at the front door'),
(110, 1, 1, 'ORD-2025-35025', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":5},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '759.11', '122.50', '321 Duck Street', 'new', 'Customer 348', '+3725631055', '2025-04-21 15:34:26', '2025-04-21 15:34:26', 'Leave at the front door'),
(111, 1, 1, 'ORD-2025-79197', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":4},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '763.02', '70.97', '226 Duck Street', 'new', 'Customer 701', '+1057890166', '2025-04-21 15:34:33', '2025-04-21 15:34:33', 'Leave at the front door'),
(112, 1, 1, 'ORD-2025-64746', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":4},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '1142.02', '50.29', '694 Duck Street', 'new', 'Customer 431', '+2722356844', '2025-04-21 15:34:49', '2025-04-21 15:34:49', 'Leave at the front door'),
(113, 1, 1, 'ORD-2025-61723', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":2},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '1100.15', '129.14', '467 Duck Street', 'new', 'Customer 780', '+5699397790', '2025-04-21 15:34:50', '2025-04-21 15:34:50', 'Leave at the front door'),
(114, 1, 1, 'ORD-2025-75809', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":1},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":3}]', '1260.11', '134.18', '530 Duck Street', 'new', 'Customer 372', '+8204670990', '2025-04-21 15:35:29', '2025-04-21 15:35:29', 'Leave at the front door'),
(115, 1, 1, 'ORD-2025-89467', '[{\"name\":\"Молоко\",\"price\":85,\"quantity\":2},{\"name\":\"Хлеб\",\"price\":45,\"quantity\":1}]', '1027.21', '113.36', '963 Duck Street', 'new', 'Customer 598', '+2663574966', '2025-04-21 15:35:30', '2025-04-21 15:35:30', 'Leave at the front door');

-- --------------------------------------------------------

--
-- Структура таблицы `order_history`
--

CREATE TABLE `order_history` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `changed_by` int(11) NOT NULL COMMENT 'ID пользователя, внесшего изменения',
  `changed_at` timestamp NULL DEFAULT current_timestamp(),
  `field_name` varchar(50) NOT NULL,
  `old_value` text DEFAULT NULL,
  `new_value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='История изменений заказов';

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `hashed_password` varchar(255) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `role` enum('admin','manager','dispatcher') DEFAULT 'manager',
  `is_active` tinyint(1) DEFAULT 1,
  `last_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `phone` varchar(20) DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Пользователи системы (менеджеры и администраторы)';

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `hashed_password`, `full_name`, `role`, `is_active`, `last_login`, `created_at`, `phone`, `notes`) VALUES
(1, 'admin', 'admin@delivery.com', '$2b$12$AGtC5nTWXnYV8RgdwqGc5ebBNZNm4uQ7UBeYQTuRbFEEpBfIJTVKa', 'Главный Администратор', 'admin', 1, NULL, '2025-04-13 18:08:06', '+79161111111', NULL),
(2, 'manager', 'manager@delivery.com', '$2b$12$AGtC5nTWXnYV8RgdwqGc5ebBNZNm4uQ7UBeYQTuRbFEEpBfIJTVKa', 'Менеджер Иванова', 'manager', 1, NULL, '2025-04-13 18:08:06', '+79162222222', NULL),
(3, 'swirch', 'swirch@example.com', '$2b$12$Dl7kBE8.jDmu3gypswsUFO8Lq0o3gIJgcg6tYHTpDodonZB7hALNi', 'Cristina Blade', 'admin', 1, NULL, '2025-04-13 15:29:12', '+790000000000', NULL),
(4, 'test', 'test1@example.com', '$2b$12$LQvTCYgZ7FiO5JYF5wRX1OScDdZEoewzU.RmhVEBK6gv.rYM8nDMC', 'test', 'manager', 1, NULL, '2025-04-13 15:48:59', '+79894', NULL);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `couriers`
--
ALTER TABLE `couriers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_vehicle` (`vehicle_type`);

--
-- Индексы таблицы `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_number` (`order_number`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `courier_id` (`courier_id`);

--
-- Индексы таблицы `order_history`
--
ALTER TABLE `order_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `changed_by` (`changed_by`),
  ADD KEY `idx_history_order` (`order_id`),
  ADD KEY `idx_history_date` (`changed_at`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_user_role` (`role`),
  ADD KEY `idx_user_active` (`is_active`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `couriers`
--
ALTER TABLE `couriers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=116;

--
-- AUTO_INCREMENT для таблицы `order_history`
--
ALTER TABLE `order_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`courier_id`) REFERENCES `couriers` (`id`) ON DELETE SET NULL;

--
-- Ограничения внешнего ключа таблицы `order_history`
--
ALTER TABLE `order_history`
  ADD CONSTRAINT `order_history_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_history_ibfk_2` FOREIGN KEY (`changed_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
