#   URL:   https://github.com/ElderHenhique/Insercao_de-Dados-BD1.git   #

DROP TABLE IF EXISTS TRABALHAM;
DROP TABLE IF EXISTS REGIAO;
DROP TABLE IF EXISTS REALIZAM;
DROP TABLE IF EXISTS FORNECEDORES;
DROP TABLE IF EXISTS ENTREGA;
DROP TABLE IF EXISTS VENDAS;
DROP TABLE IF EXISTS CLIENTES;
DROP TABLE IF EXISTS PROD_ORGANICOS;
DROP TABLE IF EXISTS PROD_INDUSTRIAIS;
DROP TABLE IF EXISTS CONTEM;
DROP TABLE IF EXISTS PRODUTOS;
DROP TABLE IF EXISTS TEM;
DROP TABLE IF EXISTS SETORES;
DROP TABLE IF EXISTS TRABALHAM_NO;
DROP TABLE IF EXISTS DURACAO;
DROP TABLE IF EXISTS DEPARTAMENTO;
DROP TABLE IF EXISTS FUNCIONARIOS;

CREATE TABLE DURACAO(
	id_duracao INTEGER,
    desde VARCHAR(50),
    ate VARCHAR(50),
    PRIMARY KEY(id_duracao)
);

CREATE TABLE FUNCIONARIOS(
	cpf CHAR(11),
    nome VARCHAR(100),
    cargo VARCHAR(100),
    PRIMARY KEY(cpf)
);

CREATE TABLE DEPARTAMENTO(
	id_depart INTEGER,
    orcamento REAL,
    nome VARCHAR(100),
    PRIMARY KEY(id_depart)
);

CREATE TABLE TRABALHAM_NO(
	cpf CHAR(11),
	id_depart INTEGER,
    id_duracao INTEGER,
    PRIMARY KEY (cpf, id_depart, id_duracao),
    FOREIGN KEY (cpf) REFERENCES FUNCIONARIOS(cpf),
    FOREIGN KEY (id_depart) REFERENCES DEPARTAMENTO(id_depart),
    FOREIGN KEY (id_duracao) REFERENCES DURACAO(id_duracao)
);

CREATE TABLE SETORES(
	tipo_de_produto VARCHAR(100),
    nome VARCHAR(100),
    informacoes VARCHAR(200),
    PRIMARY KEY(tipo_de_produto)
);

CREATE TABLE TEM(
	id_depart INTEGER,
    tipo_de_produto VARCHAR(100),
    PRIMARY KEY (id_depart, tipo_de_produto),
    FOREIGN KEY (id_depart) REFERENCES DEPARTAMENTO(id_depart), 
    FOREIGN KEY (tipo_de_produto) REFERENCES SETORES(tipo_de_produto)
);

CREATE TABLE PRODUTOS(
	codigo INTEGER,
    nome VARCHAR(100),
    preco REAL,
    PRIMARY KEY(codigo)
);

CREATE TABLE CONTEM(
	codigo INTEGER,
    tipo_de_produto VARCHAR(100),
    PRIMARY KEY (codigo, tipo_de_produto),
    FOREIGN KEY (codigo) REFERENCES PRODUTOS(codigo), 
    FOREIGN KEY (tipo_de_produto) REFERENCES SETORES(tipo_de_produto)
);

CREATE TABLE PROD_ORGANICOS(
	codigo INTEGER,
	selo VARCHAR(50),
	FOREIGN KEY (codigo) REFERENCES PRODUTOS(codigo) ON DELETE CASCADE,
    PRIMARY KEY (codigo)
);

CREATE TABLE PROD_INDUSTRIAIS(
	codigo INTEGER,
    unidade_de_medidas_massa VARCHAR(100),
    FOREIGN KEY (codigo) REFERENCES PRODUTOS(codigo) ON DELETE CASCADE,
    PRIMARY KEY (codigo)
);

CREATE TABLE CLIENTES(
	cpf CHAR(11),
    codigo INTEGER,
    nome VARCHAR(100),
    sexo char(1),
    FOREIGN KEY (codigo) REFERENCES PRODUTOS(codigo),
    PRIMARY KEY(cpf)
);

CREATE TABLE VENDAS(
	id INTEGER,
    cpf CHAR(11),
    informacoes VARCHAR(100),
    preco REAL,
    FOREIGN KEY (cpf) REFERENCES FUNCIONARIOS(cpf),
    PRIMARY KEY(id)
);

CREATE TABLE ENTREGA(
	id INTEGER,
	cod INTEGER , 
    destinatario VARCHAR(100),
    endereco VARCHAR(100),
    FOREIGN KEY (id) REFERENCES VENDAS(id) ON DELETE CASCADE,
    PRIMARY KEY (id, destinatario)
);

CREATE TABLE FORNECEDORES(
	cod_forn INTEGER,
    localizacao VARCHAR(100),
    nome VARCHAR(100),
    PRIMARY KEY(cod_forn, localizacao)
);


CREATE TABLE REALIZAM(
	cod_forn INTEGER,
    id INTEGER,
	PRIMARY KEY (cod_forn, id),
    FOREIGN KEY (cod_forn) REFERENCES FORNECEDORES(cod_forn), 
    FOREIGN KEY (id) REFERENCES VENDAS(id)
);

CREATE TABLE REGIAO(
	endereco VARCHAR(100),
    nome VARCHAR(100),
    clima VARCHAR(100),
    PRIMARY KEY(endereco)
);

CREATE TABLE TRABALHAM(
	cod_forn INTEGER,
	endereco VARCHAR(100),
	PRIMARY KEY (cod_forn, endereco),
    FOREIGN KEY (cod_forn) REFERENCES FORNECEDORES(cod_forn), 
    FOREIGN KEY (endereco) REFERENCES REGIAO(endereco)
);


INSERT INTO FUNCIONARIOS(cpf, nome, cargo) VALUES (12345678901, 'Rodrigo', 'Atendente de caixa'), (98765432109, 'Ana','Gerente'),(67664381001, 'Marcelo', 'Repositor de Mercadorias')
,(23648109612, 'Patrícia', 'Atendente de caixa'),(16829374012, 'Rhuan', 'Repositor de Mercadorias'),(11765509742, 'Bianca', 'Auxiliar de limpeza')
,(34256713221, 'Solange', 'Confeiteira'),(12245889111, 'Pedro', 'Açogueiro'),(11499244121, 'Ivan', 'Açogueiro'),(22146680001, 'Sergio', 'Empacotador');


INSERT INTO DURACAO(id_duracao, desde, ate) VALUES (0001, '12-01-2000','30-09-2013'),(0008, '01-05-2003','01-09-2015'),(0009, '28-05-2003','15-04-2016'),(013, '09-03-2004','05-02-2016')
,(0018, '17-04-2005','18-06-2016'), (0023, '23-09-2005','31-05-2017'),(0030, '10-05-2006','09-06-2018')
,(0047, '25-11-2007','25-10-2018'),(0050, '16-06-2007','01-08-2019'),(0057, '02-12-2008','11-09-2020');


INSERT INTO DEPARTAMENTO(id_depart, orcamento, nome) VALUES (001, 50.580, 'Departamento de Bebidas'), (002, 22.300, 'Departamento de Padaria'), (003, 45.490, 'Departamento de Alimentos_não_Perecíveis/Enlatados')
,(004, 39.990, 'Departamento de Frios'), (005, 28.820, 'Departamento de Hortifruti'), (006, 30.000, 'Departamento de Higiene')
,(007, 18.200, 'Departamento de Papelaria'), (008, 70.799, 'Departamento de Açougue'), (009, 24.999, 'Departamento de Produtos de Limpeza'), (010, 17.115, 'Departamento de Alimentos Perecíveis/Embalados');


INSERT INTO TRABALHAM_NO(cpf, id_depart, id_duracao) VALUES (12345678901, 001, 0001),(98765432109, 002, 0008),(67664381001, 003, 0009)
,(23648109612, 004, 0013),(16829374012, 005, 0018),(11765509742, 006, 0023)
,(34256713221, 007, 0030),(12245889111, 008, 0047),(11499244121, 009, 0050),(22146680001, 010, 0057);


INSERT INTO SETORES(tipo_de_produto, nome, informacoes) VALUES ('Bebidas', 'Coca-Cola', 'Compre uma leve duas'), ('Padaria', 'Pão_Francês', 'Fresco e feito na hora')
,('Alimentos_não_Perecíveis/Enlatados', 'Arroz', '5 kg'), ('Frios', 'Queijo', 'Pedaço (1kg)'),('Hortifruti', 'Batata', 'Tipo Batata monalisa')
,('Higiene', 'Papel Higiênico', 'Leve 12 e Pague 11'), ('Papelaria', 'Caneta', 'Canetas nas cores azul, preta e vermelha'),('Açougue', 'Frango', 'Frango Caipira')
,('Produtos de Limpeza', 'Detergente', 'Marca Limpol'), ('Alimentos Perecíveis/Embalados', 'Ketchup', 'Ketchup Heinz (397g)');


INSERT INTO TEM(id_depart, tipo_de_produto) VALUES (001,'Bebidas'), (002,'Padaria'), (003,'Alimentos_não_Perecíveis/Enlatados'), (004,'Frios')
, (005,'Hortifruti'), (006,'Higiene'), (007,'Papelaria'), (008,'Açougue'), (009,'Produtos de Limpeza'), (010,'Alimentos Perecíveis/Embalados');


INSERT INTO PRODUTOS(codigo, nome, preco) VALUES (20, 'Coca-cola', 6.40),(189, 'Pão_Francês', 1.07),(199, 'Arroz', 23.29)
,(77, 'Queijo', 34.99),(50, 'Batata', 1.52),(41, 'Papel Higiênico', 13.67)
,(32, 'Caneta', 1.50),(382, 'Frango', 15.99),(109, 'Detergente', 1.75),(247, 'Ketchup', 7.57);


INSERT INTO CONTEM(codigo, tipo_de_produto) VALUES (20,'Bebidas'), (189,'Padaria'), (199,'Alimentos_não_Perecíveis/Enlatados'), (77,'Frios')
,(50,'Hortifruti'), (41, 'Higiene'), (32,'Papelaria'), (382,'Açougue'), (109,'Produtos de Limpeza'), (247,'Alimentos Perecíveis/Embalados');


INSERT INTO PROD_ORGANICOS(codigo, selo) VALUES(199, 'Selo Orgânico brasileiro'), (77, 'Selo Orgânico brasileiro'), (50, 'Selo Orgânico brasileiro');


INSERT INTO PROD_INDUSTRIAIS(codigo, unidade_de_medidas_massa) VALUES (20, '2L (Litros)'), (189, '50g (gramas)'), (41, '60m (metros)'), (32,'1.0mm (milímetro)')
, (382, '2.5kg (quilograma)'), (109, '500ml (mililitro)'), (247, '397g (gramas)');


INSERT INTO CLIENTES(cpf, nome, sexo) VALUES (14687635904, 'Sabrina', 'F') , (56389100460, 'Roberto', 'M'),(15477219804, 'Amanda', 'F')
,(17285466134, 'Carlos', 'M') , (00918247661, 'Géssica', 'F'),(10200142711, 'Kalel', 'M')
,(29965481921, 'Izadora', 'F') , (00712466122, 'Matheus', 'M'),(40287716552, 'Mariana', 'F'),(55627881301, 'Gabriel', 'M');


INSERT INTO VENDAS(id, informacoes, preco) VALUES (0029, 'Pagamento_Em_Dinheiro', 225.59) , (0034, 'Pagamento_No_Cartão_Crédito', 413.07),(0039, 'Pagamento_No_Cartão_Débito', 50.99)
,(0046, 'Pagamento_Em_Dinheiro', 67.28) , (0047, 'Pagamento_No_Cartão_Débito', 509.91),(0051, 'Pagamento_No_Cartão_Crédito', 724.23)
,(0055, 'Pagamento_Em_Dinheiro', 100.86) , (0063, 'Pagamento_No_Cartão_Débito', 26.79),(0068, 'Pagamento_No_Cartão_Crédito', 217.17),(0070, 'Pagamento_Em_Dinheiro', 15.66);


INSERT INTO ENTREGA(id, cod, destinatario, endereco) VALUES (0029, 001, 'Sabrina', 'Rua Triangulo Austral 427'),(0034, 002, 'Roberto', 'Av. Centauro 345')
,(0039, 003, 'Amanda', 'Av. Centauro 361'),(0046, 004, 'Carlos', 'Rua Três Marias 847'),(0047, 005, 'Géssica', 'Rua Vega 714')
,(0051, 006, 'Kalel', 'Rua Orion 529'),(0055, 007, 'Izadora', 'Rua Estrala D alva 912'),(0063, 008, 'Matheus', 'Av. Carena 658')
,(0068, 009, 'Mariana', 'Rua Hécules 229'),(0070, 010, 'Gabriel', 'Rua Três Marias 097');


INSERT INTO FORNECEDORES(cod_forn, localizacao, nome) VALUES (012386, 'Sorocab-SP', 'Bertin'), (098216, 'Jardim Carmela Campo Largo-PR', 'Oesa'), (082942, 'Curitiba-PR', 'Maxxi Atacado')
,(071652, 'Rio Grande da Serra-SP', 'Seara'), (024726, 'Maringá-PR', 'Ceasas'), (050291, 'Vila Cordeiro São Paulo-SP', 'Procter & Gamble'), (032215, 'Vila Gertrudes-SP', 'Unilever')
, (062195, 'Campo Mourão-PR', 'Alvorada Papelaria'), (012386, 'Maringá-PR', 'Assai Atacadista'), (016942, 'Vila Olímpia-SP', 'Diageo');


INSERT INTO REALIZAM(cod_forn, id) VALUES (012386, 0029), (098216, 0034), (082942, 0039), (071652, 0046)
,(024726, 0047), (050291, 0051), (032215, 0055), (062195, 0063), (012386, 0068), (016942, 0070);


INSERT INTO REGIAO(endereco, nome, clima) VALUES ('Sorocab-SP', 'Sudeste','Tropical') , ('Jardim Carmela Campo Largo-PR','Sul','SubTropical'), ('Curitiba-PR', 'Sul','SubTropical')
,('Rio Grande da Serra-SP', 'Sudeste','Tropical'), ('Maringá-PR (Ceasas)','Sul','SubTropical'), ('Vila Cordeiro São Paulo-SP', 'Sudeste','Tropical')
,('Vila Gertrudes-SP', 'Sudeste','Tropical'), ('Campo Mourão-PR','Sul','SubTropical'), ('Maringá-PR (Assaí)', 'Sul','SubTropical'), ('Vila Olímpia-SP', 'Sudeste','Tropical');


INSERT INTO TRABALHAM(cod_forn, endereco) VALUES (012386,'Sorocab-SP'), (098216,'Jardim Carmela Campo Largo-PR'), (082942,'Curitiba-PR'), (071652,'Rio Grande da Serra-SP'), (024726,'Maringá-PR (Ceasas)')
,(050291,'Vila Cordeiro São Paulo-SP'), (032215,'Vila Gertrudes-SP'), (062195,'Campo Mourão-PR'), (012386,'Maringá-PR (Assaí)'), (016942,'Vila Olímpia-SP');
