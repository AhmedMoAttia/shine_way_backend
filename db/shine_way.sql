create table users(
id INTEGER PRIMARY KEY AUTOINCREMENT,
handle varchar(32) not null unique,
createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
password varchar(1000) not null,
type int not null default 0 check(type between 0 and 1),
firstName varchar(32) not null,
lastName varchar(32) not null
);

create table places(
id INTEGER PRIMARY KEY AUTOINCREMENT,
createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
type int not null default 0 check(type between 0 and 2),
address varchar(200) not null,
siteUrl varchar(200),
mapUrl varchar(200)
);

create table comments(
id INTEGER PRIMARY KEY AUTOINCREMENT,
createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
content varchar(500) not null,
userId int,
placeId int,
commentId int,
creatorId int,
FOREIGN KEY(userId) REFERENCES users(id) on update cascade ON DELETE CASCADE,
FOREIGN KEY(placeId) REFERENCES places(id) on update cascade ON DELETE CASCADE,
FOREIGN KEY(commentId) REFERENCES comments(id) on update cascade ON DELETE CASCADE,
FOREIGN KEY(creatorId) REFERENCES users(id) on update cascade on delete set null,
check(id != commentId),
check(userId != null or placeId != null or commentId != null)
);
CREATE INDEX comments_userId ON comments(userId);
CREATE INDEX comments_placeId ON comments(placeId);
CREATE INDEX comments_commentId ON comments(commentId);
CREATE INDEX comments_creatorId ON comments(creatorId);

create table subscriptions(
id INTEGER PRIMARY KEY AUTOINCREMENT,
createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
price UNSIGNED float not null,
duration DATETIME NOT NULL
);

create table advertisements(
id INTEGER PRIMARY KEY AUTOINCREMENT,
createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
placeId int,
FOREIGN KEY(placeId) REFERENCES places(id) on update cascade on delete set null
);
CREATE INDEX advertisements_placeId ON advertisements(placeId);

create table vouchers(
id INTEGER PRIMARY KEY AUTOINCREMENT,
createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
number UNSIGNED INTEGER not null check(number > 0),
placeId int,
FOREIGN KEY(placeId) REFERENCES places(id) on update cascade on delete set null
);
CREATE INDEX vouchers_placeId ON vouchers(placeId);

create table visits(
id INTEGER PRIMARY KEY AUTOINCREMENT,
createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
live bool not null default 0,
userId int,
placeId int,
FOREIGN KEY(userId) REFERENCES users(id) on update cascade on delete set null,
FOREIGN KEY(placeId) REFERENCES places(id) on update cascade on delete set null
);
CREATE INDEX visits_userId ON visits(userId);
CREATE INDEX visits_placeId ON visits(placeId);

create table locations(
id INTEGER PRIMARY KEY AUTOINCREMENT,
createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
latitude float not null check(latitude between -90 and 90),
longitude float not null check(longitude between -180 and 180),
area UNSIGNED float,
placeId int unique,
advertisementId int,
FOREIGN KEY(placeId) REFERENCES places(id) on update cascade ON DELETE CASCADE,
FOREIGN KEY(advertisementId) REFERENCES advertisements(id) on update cascade ON DELETE CASCADE,
check(placeId != null or advertisementId != null),
check(advertisementId = null or (area != null and area > 0))
);
CREATE INDEX locations_placeId ON locations(placeId);
CREATE INDEX locations_advertisementId ON locations(advertisementId);

create table votes(
id INTEGER PRIMARY KEY AUTOINCREMENT,
createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
vote bool,
rating int check(rating between 0 and 5),
userId int,
placeId int,
commentId int,
visitId int,
creatorId int not null,
FOREIGN KEY(userId) REFERENCES users(id) on update cascade ON DELETE CASCADE,
FOREIGN KEY(placeId) REFERENCES places(id) on update cascade ON DELETE CASCADE,
FOREIGN KEY(commentId) REFERENCES comments(id) on update cascade ON DELETE CASCADE,
FOREIGN KEY(visitId) REFERENCES visits(id) on update cascade ON DELETE CASCADE,
FOREIGN KEY(creatorId) REFERENCES users(id) on update cascade ON DELETE CASCADE,
check(userId != creatorId),
check(userId != null or placeId != null or commentId != null or visitId != null),
check(vote != null or rating != null),
unique(creatorId, userId),
unique(creatorId, placeId),
unique(creatorId, commentId),
unique(creatorId, visitId)
);
CREATE INDEX votes_userId ON votes(userId);
CREATE INDEX votes_placeId ON votes(placeId);
CREATE INDEX votes_commentId ON votes(commentId);
CREATE INDEX votes_visitId ON votes(visitId);
CREATE INDEX votes_creatorId ON votes(creatorId);

create table details(
id INTEGER PRIMARY KEY AUTOINCREMENT,
createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
title varchar(64) not null,
description varchar(1000),
language UNSIGNED int not null default 0,
userId int,
placeId int,
subscriptionId int,
advertisementId int,
voucherId int,
visitId int,
FOREIGN KEY(userId) REFERENCES users(id) on update cascade ON DELETE CASCADE,
FOREIGN KEY(placeId) REFERENCES places(id) on update cascade ON DELETE CASCADE,
FOREIGN KEY(subscriptionId) REFERENCES subscriptions(id) on update cascade ON DELETE CASCADE,
FOREIGN KEY(advertisementId) REFERENCES advertisements(id) on update cascade ON DELETE CASCADE,
FOREIGN KEY(voucherId) REFERENCES vouchers(id) on update cascade ON DELETE CASCADE,
FOREIGN KEY(visitId) REFERENCES visits(id) on update cascade ON DELETE CASCADE,
check(userId != null or placeId != null or subscriptionId != null or advertisementId != null or voucherId != null or visitId != null)
);
CREATE INDEX details_userId ON details(userId);
CREATE INDEX details_placeId ON details(placeId);
CREATE INDEX details_subscriptionId ON details(subscriptionId);
CREATE INDEX details_advertisementId ON details(advertisementId);
CREATE INDEX details_voucherId ON details(voucherId);
CREATE INDEX details_visitId ON details(visitId);

create table phones(
id INTEGER PRIMARY KEY AUTOINCREMENT,
createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
number varchar(15) not null unique,
userId int,
placeId int,
FOREIGN KEY(userId) REFERENCES users(id) on update cascade ON DELETE CASCADE,
FOREIGN KEY(placeId) REFERENCES places(id) on update cascade ON DELETE CASCADE,
check(userId != null or placeId != null)
);
CREATE INDEX phones_userId ON phones(userId);
CREATE INDEX phones_placeId ON phones(placeId);

create table attachments(
id INTEGER PRIMARY KEY AUTOINCREMENT,
createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
type int not null default 0 check(type between 0 and 1),
url varchar(200) not null,
userId int,
placeId int,
advertisementId int,
visitId int,
FOREIGN KEY(userId) REFERENCES users(id) on update cascade ON DELETE CASCADE,
FOREIGN KEY(placeId) REFERENCES places(id) on update cascade ON DELETE CASCADE,
FOREIGN KEY(advertisementId) REFERENCES advertisements(id) on update cascade ON DELETE CASCADE,
FOREIGN KEY(visitId) REFERENCES visits(id) on update cascade ON DELETE CASCADE,
check(userId != null or placeId != null or advertisementId != null or visitId != null)
);
CREATE INDEX attachments_userId ON attachments(userId);
CREATE INDEX attachments_placeId ON attachments(placeId);
CREATE INDEX attachments_advertisementId ON attachments(advertisementId);
CREATE INDEX attachments_visitId ON attachments(visitId);

create table emails(
id INTEGER PRIMARY KEY AUTOINCREMENT,
createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
email varchar(254) not null unique check(email LIKE '%_@__%.__%'),
userId int,
placeId int,
FOREIGN KEY(userId) REFERENCES users(id) on update cascade ON DELETE CASCADE,
FOREIGN KEY(placeId) REFERENCES places(id) on update cascade ON DELETE CASCADE,
check(userId != null or placeId != null)
);
CREATE INDEX emails_userId ON emails(userId);
CREATE INDEX emails_placeId ON emails(placeId);

create table user_subscription_junctions(
createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
endsAt DATETIME NOT NULL,
cost UNSIGNED float not null,
userId int,
subscriptionId int,
FOREIGN KEY(userId) REFERENCES users(id) on update cascade on delete set null,
FOREIGN KEY(subscriptionId) REFERENCES subscriptions(id) on update cascade on delete set null,
unique(userId, subscriptionId)
);
CREATE INDEX user_subscription_junctions_userId ON user_subscription_junctions(userId);
CREATE INDEX user_subscription_junctions_subscriptionId ON user_subscription_junctions(subscriptionId);

create table user_voucher_junctions(
createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
serial varchar(100) not null unique,
userId int,
voucherId int,
FOREIGN KEY(userId) REFERENCES users(id) on update cascade on delete set null,
FOREIGN KEY(voucherId) REFERENCES vouchers(id) on update cascade on delete set null,
unique(userId, voucherId)
);
CREATE INDEX user_voucher_junctions_userId ON user_voucher_junctions(userId);
CREATE INDEX user_voucher_junctions_voucherId ON user_voucher_junctions(voucherId);

create table user_visit_junctions(
createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
userId int NOT NULL,
visitId int NOT NULL,
FOREIGN KEY(userId) REFERENCES users(id) on update cascade ON DELETE CASCADE,
FOREIGN KEY(visitId) REFERENCES visits(id) on update cascade ON DELETE CASCADE,
primary key(userId, visitId)
);
CREATE INDEX user_visit_junctions_userId ON user_visit_junctions(userId);
CREATE INDEX user_visit_junctions_visitId ON user_visit_junctions(visitId);

create table user_place_junctions(
createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
userId int NOT NULL,
placeId int NOT NULL,
FOREIGN KEY(userId) REFERENCES users(id) on update cascade ON DELETE CASCADE,
FOREIGN KEY(placeId) REFERENCES places(id) on update cascade ON DELETE CASCADE,
primary key(userId, placeId)
);
CREATE INDEX user_place_junctions_userId ON user_place_junctions(userId);
CREATE INDEX user_place_junctions_placeId ON user_place_junctions(placeId);

create table user_user_junctions(
createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
userId int NOT NULL,
favUserId int NOT NULL,
FOREIGN KEY(userId) REFERENCES users(id) on update cascade ON DELETE CASCADE,
FOREIGN KEY(favUserId) REFERENCES users(id) on update cascade ON DELETE CASCADE,
primary key(userId, favUserId)
);
CREATE INDEX user_user_junctions_userId ON user_user_junctions(userId);
CREATE INDEX user_user_junctions_favUserId ON user_user_junctions(favUserId);
