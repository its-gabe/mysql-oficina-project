-- INSERINDO VALORES NAS TABELAS


-- CLIENTS
INSERT INTO clients (fname, mname, lname, cpf, address, contact) VALUES
    ('João', 'Silva', 'Souza', '12345678901', 'Rua A, 123', '(11) 98765-4321'),
    ('Maria', 'Ferreira', 'Oliveira', '98765432101', 'Avenida B, 456', '(22) 87654-3210'),
    ('Carlos', 'Fernandes', 'Pereira', '23456789012', 'Travessa C, 789', '(33) 76543-2109'),
    ('Ana', 'Cavalcanti', 'Lima', '34567890123', 'Rua D, 987', '(44) 65432-1098'),
    ('Pedro', 'Martins', 'Ribeiro', '45678901234', 'Avenida E, 654', '(55) 54321-0987');
    


-- VEHICLE
INSERT INTO vehicle (idclient_car, make, model, colour, number_plate, tire_model) VALUES
    (1, 'Toyota', 'Corolla', 'Blue', 'ABC1234', 'Michelin'),
    (2, 'Honda', 'Civic', 'Red', 'XYZ5678', 'Bridgestone'),
    (3, 'Ford', 'Focus', 'Green', 'DEF9012', 'Goodyear'),
    (4, 'Chevrolet', 'Malibu', 'Silver', 'GHI3456', 'Continental'),
    (5, 'Volkswagen', 'Jetta', 'Black', 'JKL7890', 'Pirelli');
    
    

-- MECHANIC_SHOP
INSERT INTO mechanic_local (idmechanic, place_name, location) VALUES
	(1, 'Speedy Repairs', 'Travessa Z, 789');
    
    
    
-- WORKER
INSERT INTO worker (idworker, work_place, fname, mname, lname, cpf, salary) VALUES
    (1, 1, 'José', 'Silva', 'Santos', '11122233344', 3000.00),
    (2, 1, 'Ana', 'Ferreira', 'Oliveira', '22233344455', 3500.00),
    (3, 1, 'Carlos', 'Fernandes', 'Pereira', '33344455566', 3200.00),
    (4, 1, 'Mariana', 'Cavalcanti', 'Lima', '44455566677', 4000.00),
    (5, 1, 'Pedro', 'Martins', 'Ribeiro', '55566677788', 3800.00);
    
    
    
-- SERVICES
INSERT INTO services (idservice, service_type) VALUES
    (1, 'tire_change'),
    (2, 'motor_change'),
    (3, 'oil_change'),
    (4, 'colour_change'),
    (5, 'gas'),
    (6, 'tire_fill');



-- HISTORY
INSERT INTO historys (service_did, car_info, date_service) VALUES
    (5, 1, '2023-01-01 10:00:00'),
    (4, 2, '2023-02-05 14:30:00'),
    (3, 3, '2023-05-10 08:45:00'),
    (6, 4, '2023-06-15 12:15:00'),
    (1, 5, '2023-08-20 09:30:00'),
    (3, 2, '2023-03-29 08:00:00'),
    (2, 3, '2023-04-05 11:30:00'),
    (4, 1, '2023-02-05 13:45:00'),
    (1, 5, '2023-05-12 10:35:00'),
    (2, 4, '2023-09-18 18:30:00');
    
    
    
-- PAYMENT
INSERT INTO payment (history_payment, payment_type) VALUES
    (1, 'cartão_crédito'),
    (2, 'boleto'),
    (3, 'cartão_débito'),
    (4, 'pix'),
    (5, 'cartão_crédito'),
    (6, 'pix'),
    (7, 'boleto'),
    (8, 'cartão_débito'),
    (9, 'pix'),
    (10, 'cartão_débito');
    
    
-- PARTS
INSERT INTO parts (idparts, part_name) VALUES
    (1, 'Engine Oil'),
    (2, 'Brake Pads'),
    (3, 'Air Filter'),
    (4, 'Spark Plugs'),
    (5, 'Battery');



-- STORAGE
INSERT INTO parts_storage (idstorage, part_info, quantity) VALUES
    (1, 1, 50),
    (1, 2, 30),
    (1, 3, 100),
    (1, 4, 80),
    (1, 5, 20);



-- SUPPLIERS
INSERT INTO supplier (company_id, socialname, cnpj, part_selling, quantity) VALUES
    (1, 'AutoPartsCo', '12345678901234', 'tire', 200),
    (1, 'MotorTech', '23456789012345', 'motor', 50),
    (1, 'PaintsRUs', '34567890123456', 'car paint', 100),
    (1, 'TireEmporium', '45678901234567', 'tire', 150),
    (1, 'EngineSupplies', '56789012345678', 'motor', 30);









-- REALIZANDO QUERIES



-- LISTAR TODOS OS CLIENTES E SEUS VEICULOS
SELECT concat(fname, ' ', lname) AS clientname, contact, make, model, colour, number_plate
	FROM clients c INNER JOIN vehicle v 
	ON c.idclient = v.idclient_car;



-- MOSTRAR O HISTÓRICO DE SERVIÇOS REALIZADOS
SELECT date_service, concat(fname, ' ', lname) AS clientname, make, model, number_plate, service_type
	FROM clients 
	JOIN vehicle ON clients.idclient = vehicle.idclient_car
	JOIN historys ON car_info = vehicle.idvehicle
	JOIN services ON historys.service_did = services.idservice;


-- QUANTOS MANUTENÇÕES/SERVIÇOS CADA CARRO PASSOU
SELECT make, number_plate, count(service_did) AS noservicos
	FROM vehicle 
    JOIN historys
    ON vehicle.idvehicle = historys.car_info
    GROUP BY number_plate;
    
    
    
-- QUAL DOS SERVIÇOS SÃO MAIS PEDIDOS NA OFICINA
SELECT service_type, count(service_did)
	FROM historys
    JOIN services
    ON historys.service_did = services.idservice
    GROUP BY service_type;



-- ESTOQUE DE CADA PEÇA
SELECT part_name, quantity
	FROM parts
    JOIN parts_storage
    ON idparts = part_info
    ORDER BY quantity DESC;



-- QUAIS FORMAS DE PAGAMENTO OS CLIENTES UTILIZARAM PARA CADA SERVIÇO FEITO
SELECT concat(fname, ' ', lname) AS clientname, service_type, payment_type
	FROM vehicle JOIN clients ON vehicle.idclient_car = clients.idclient
    JOIN historys ON historys.car_info = vehicle.idvehicle
    JOIN services ON services.idservice = historys.service_did
    JOIN payment ON historys.idhistory = payment.history_payment;



-- QUAIS METODOS DE PAGAMENTO SÃO MAIS UTILIZADOS
SELECT payment_type, count(payment_type) AS times_used
	FROM payment
    GROUP BY payment_type;



-- MÉDIA DE SALÁRIO DOS TRABALHADORES
SELECT place_name AS company, avg(salary) AS average_salary
	FROM worker 
    JOIN mechanic_local
    ON worker.work_place = mechanic_local.idmechanic
    GROUP BY place_name;



-- SALÁRIO DOS TRABALHADORES
SELECT concat(fname, ' ', lname) AS worker_name, salary
	FROM worker;



-- TRABALHADORES COM SALÁRIO MENOR QUE A MÉDIA
SELECT concat(fname, ' ', lname) AS worker_name, salary
	FROM worker
    WHERE salary < 3500;



-- TRABALHADORES COM SALÁRIO MAIOR QUE A MÉDIA
SELECT concat(fname, ' ', lname) AS worker_name, salary
	FROM worker
    WHERE salary >= 3500;



