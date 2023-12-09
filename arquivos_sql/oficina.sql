-- CRIANDO AS TABELAS

CREATE DATABASE IF NOT EXISTS mechanic_shop;

-- show databases;
-- DROP DATABASE mechanic_shop;

USE mechanic_shop;




CREATE TABLE clients (
	idclient INT PRIMARY KEY AUTO_INCREMENT,
    fname varchar(45) NOT NULL,
    mname varchar(45),
    lname varchar(45),
    cpf char(11) NOT NULL,
    address varchar(80),
    contact varchar(15),
    CONSTRAINT unique_client_cpf UNIQUE (cpf)
);






CREATE TABLE vehicle (
	idvehicle INT PRIMARY KEY AUTO_INCREMENT,
    idclient_car INT,
    make VARCHAR(20) NOT NULL,
    model VARCHAR(20) NOT NULL,
    colour VARCHAR(20) NOT NULL,
    number_plate CHAR(7) NOT NULL,
    tire_model VARCHAR(20),
    CONSTRAINT fk_owner_vehicle FOREIGN KEY (idclient_car) REFERENCES clients(idclient),
    CONSTRAINT unique_plate UNIQUE (number_plate)
);





CREATE TABLE mechanic_local (
	idmechanic INT PRIMARY KEY,
    place_name VARCHAR(45) NOT NULL,
    location VARCHAR(45) NOT NULL
);





CREATE TABLE worker (
	idworker INT AUTO_INCREMENT,
    work_place INT,
    fname VARCHAR(45) NOT NULL,
    mname VARCHAR(45),
    lname VARCHAR(45),
    cpf CHAR(11) NOT NULL,
    salary FLOAT,
    PRIMARY KEY (idworker, work_place),
    CONSTRAINT unique_worker_cpf UNIQUE (cpf),
    CONSTRAINT fk_place_info FOREIGN KEY (work_place) REFERENCES mechanic_local(idmechanic)
);







CREATE TABLE services (
	idservice INT PRIMARY KEY AUTO_INCREMENT,
    service_type ENUM('tire_change', 'motor_change', 'oil_change', 'colour_change', 'gas', 'tire_fill')
);







CREATE TABLE historys (
	idhistory INT AUTO_INCREMENT,
    service_did INT,
    car_info INT,
    date_service DATETIME,
    PRIMARY KEY (idhistory, service_did, car_info, date_service),
    CONSTRAINT fk_service_did FOREIGN KEY (service_did) REFERENCES services(idservice),
    CONSTRAINT fk_car_service_history FOREIGN KEY (car_info) REFERENCES vehicle(idvehicle)
);






CREATE TABLE payment (
	idpayment INT AUTO_INCREMENT,
    history_payment INT,
    payment_type ENUM('cartão_débito', 'cartão_crédito', 'boleto', 'pix'),
    PRIMARY KEY (idpayment, history_payment),
    CONSTRAINT fk_history_paid FOREIGN KEY (history_payment) REFERENCES historys(idhistory)
);






CREATE TABLE parts (
	idparts INT PRIMARY KEY AUTO_INCREMENT,
    part_name VARCHAR(20) NOT NULL
);







CREATE TABLE parts_storage (
	idstorage INT,
    part_info INT,
    quantity INT DEFAULT 0,
    PRIMARY KEY (idstorage, part_info),
    CONSTRAINT part_names FOREIGN KEY (part_info) REFERENCES parts(idparts)
);






CREATE TABLE supplier (
	idsupplier INT AUTO_INCREMENT,
    company_id INT,
    socialname VARCHAR(45) NOT NULL,
    cnpj CHAR(15) NOT NULL,
    part_selling ENUM('tire','motor','car paint') NOT NULL,
    quantity INT DEFAULT 0,
    CONSTRAINT unique_cnpj_supplier UNIQUE (cnpj),
    PRIMARY KEY (idsupplier, company_id),
    CONSTRAINT fk_mechanic_shop_supplier FOREIGN KEY (company_id) REFERENCES mechanic_local(idmechanic)
);




SHOW TABLES;








