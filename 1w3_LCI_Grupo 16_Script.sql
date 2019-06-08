--- Primero se crea la Base de Datos
create database ITV_Cordoba
go

--- Seleccionamos la Base de Datos sobre la que vamos a trabajar
Use ITV_Cordoba

--- Se comienza a crear las tablas auxiliares
create table marcas_vehiculos
(
	id_marca int identity (1,1) NOT NULL, ---Se utiliza el comando "identity" para indicar que debe incrementar automáticamente y se indica que el PK no puede quedar vacío
	nombre varchar (20)
	constraint pk_id_marca primary key (id_marca) --- se determina el PK de la tabla
)

create table modelos_vehiculos --- Creamos la tabla de Modelos de vehículos
(
	id_modelo int identity (1,1) NOT NULL,
	nombre varchar (20),
	id_marca int,
	constraint pk_id_modelo primary key (id_modelo), ---Designamos su PK
	constraint fk_id_marca foreign key (id_marca) references marcas_vehiculos(id_marca) ---Y linkeamos a la tabla "Marcas"
)

create table tipos_vehiculos
(
	id_tipo_vehiculo int identity (1,1) NOT NULL,
	descripcion varchar(20),
	constraint pk_id_tipo_vehiculo primary key (id_tipo_vehiculo)
)

create table destinos_vehiculos
(
	id_destino int identity (1,1) NOT NULL primary key,
	descripcion varchar(20)
)

create table tipos_combustible
(
	id_tipo_combustible int identity (1,1) NOT NULL primary key,
	descripcion varchar(20)
)

create table observaciones
(
	id_observaciones int identity (1,1) NOT NULL primary key,
	descripcion varchar(50)
)

create table tipos_clientes
(
	id_tipo_cliente int identity (1,1) NOT NULL primary key,
	descripcion varchar(20)
)

create table lineas_inspeccion
(
	id_linea_inspeccion int identity (1,1) NOT NULL primary key,
	nombre varchar (20)
)

create table generos
(
	id_genero int identity (1,1) NOT NULL primary key,
	descripcion varchar (20)
)

create table tipos_telefonos
(
	id_tipo_telefono int identity (1,1) NOT NULL primary key,
	descripcion varchar (20)
)

create table tipos_documentos
(
	id_tipo_doc int identity (1,1) NOT NULL,
	descripcion varchar (20),
	constraint pk_id_tipo_doc primary key (id_tipo_doc)
)

create table especialidades
(
	id_especialidad int identity (1,1) NOT NULL primary key,
	descripcion varchar (20)
)

create table ciudades
(
	id_ciudad int identity (1,1) NOT NULL primary key,
	nombre varchar(50)
)

create table barrios
(
	id_barrio int identity (1,1) NOT NULL primary key,
	nombre varchar (50),
	id_ciudad int,
	constraint fk_id_ciudad foreign key (id_ciudad) references ciudades(id_ciudad)
)

create table tipos_controles
(
	id_tipo_control int identity (1,1) NOT NULL primary key,
	descripcion varchar (30)
)

create table controles
(
	id_control_item int identity (1,1) NOT NULL,
	descripcion varchar (30),
	id_tipo_control int,
	constraint pk_id_control_item primary key (id_control_item),
	constraint fk_id_tipo_control foreign key (id_tipo_control) references tipos_controles(id_tipo_control)
)

create table resultados
(
	id_resultado int identity (1,1) NOT NULL primary key,
	descripcion varchar (50)
)

--- A continuación procedemos a crear las tablas maestras y sus referenias a las tablas auxiliares.

create table personas
(
	id_persona int identity (1,1) NOT NULL,
	id_tipo_doc int,
	nro_documento varchar (15),
	apellido varchar (50),
	nombre varchar (50),
	fecha_nacimiento datetime,
	id_genero int,
	calle varchar (50),
	nro_calle int,
	id_barrio int,
	email varchar (30),
	constraint pk_id_persona primary key (id_persona),
	constraint fk_id_tipo_doc foreign key (id_tipo_doc) references tipos_documentos (id_tipo_doc),
	constraint fk_id_genero foreign key (id_genero) references generos (id_genero),
	constraint fk_id_barrio foreign key (id_barrio) references barrios (id_barrio)
)

create table clientes
(
	id_cliente int identity (1,1) NOT NULL,
	id_persona int,
	id_tipo_cliente int,
	constraint pk_id_cliente primary key (id_cliente),
	constraint fk_id_persona foreign key (id_persona) references personas (id_persona),
	constraint fk_id_tipo_cliente foreign key (id_tipo_cliente) references tipos_clientes (id_tipo_cliente)
)

create table inspectores
(
	legajo int identity (1,1) NOT NULL,
	id_persona int,
	fecha_ingreso datetime,
	id_especialidad int,
	matricula varchar (20),
	constraint pk_legajo primary key (legajo),
	constraint fk_id_persona_2 foreign key (id_persona) references personas (id_persona),
	constraint fk_id_especialidad foreign key (id_especialidad) references especialidades (id_especialidad)
)

create table vehiculos
(
	dominio varchar (7) NOT NULL,
	id_modelo int,
	id_tipo_vehiculo int,
	num_chasis varchar (30),
	num_motor varchar (30),
	id_destino int,
	año_fabricacion datetime,
	id_tipo_combustible int,
	constraint pk_dominio primary key (dominio),
	constraint fk_id_modelo foreign key (id_modelo) references modelos_vehiculos (id_modelo),
	constraint fk_id_tipo_vehiculo foreign key (id_tipo_vehiculo) references tipos_Vehiculos (id_tipo_vehiculo),
	constraint fk_id_destino foreign key (id_destino) references destinos_vehiculos (id_destino),
	constraint fk_id_tipo_combustible foreign key (id_tipo_combustible) references tipos_combustible (id_tipo_combustible)
)

create table informes
(
	nro_informe int identity (1,1) NOT NULL,
	fecha_informe date,
	hora_informe time,
	dominio varchar (7),
	id_linea_inspeccion int,
	legajo int,
	id_cliente int,
	nro_oblea int,
	fecha_venc_oblea datetime,
	resultado_inspeccion bit NOT NULL,
	fecha_regreso_insp datetime,
	id_observaciones int,
	constraint pk_nro_informe primary key (nro_informe),
	constraint fk_dominio foreign key (dominio) references vehiculos (dominio),
	constraint fk_id_linea_inspeccion foreign key (id_linea_inspeccion) references lineas_inspeccion (id_linea_inspeccion),
	constraint fk_legajo foreign key (legajo) references inspectores (legajo),
	constraint fk_id_cliente foreign key (id_cliente) references clientes (id_cliente),
	constraint fk_id_observaciones foreign key (id_observaciones) references observaciones (id_observaciones)
)

create table telefonos_por_persona
(
	nro_telefono varchar(30) not null,
	id_persona int,
	id_tipo_telefono int,
	constraint pk_nro_telefono primary key (nro_telefono),
	constraint fk_id_persona_3 foreign key (id_persona) references personas (id_persona),
	constraint fk_id_tipo_telefono foreign key (id_tipo_telefono) references tipos_telefonos (id_tipo_telefono)
)

create table detalle_informes
(
	nro_informe int,
	id_detalles int identity (1,1) NOT NULL,
	id_control_item int,
	id_resultado int,
	constraint pk_id_detalles primary key (id_detalles),
	constraint fk_nro_informe foreign key (nro_informe) references informes (nro_informe),
	constraint fk_id_control_item foreign key (id_control_item) references controles (id_control_item),
	constraint fk_id_resultado foreign key (id_resultado) references resultados (id_resultado)
)

---Comenzamos cargando las posibles marcas de los vehículos.
insert into marcas_vehiculos (nombre) 
values ('Volskwagen'), ('Fiat'), ('Ford'), ('Renault'), ('Peugeot'), ('Toyota'), ('Citroen'), ('Audi'), ('Mercedes Benz'), ('Alfa Romeo'), ('Chevrolet'), ('Dodge'), ('Hyundai'), ('Jeep'), ('Kia')

---A continuación cargamos los modelos de vehículos.
insert into modelos_vehiculos (id_marca, nombre)
values	('1', 'Gol'),
		('1','Fox'),
		('1','Suran'),
		('2','Uno'),
		('2','Cronos'),
		('2','Argo'),
		('3','Ka'),
		('3','Focus'),
		('3','EcoSport'),
		('4','Kwid'),
		('4','Sandero'),
		('4','Kangoo'),
		('5','208'),
		('5','307'),
		('5','301'),
		('6','Hilux'),
		('6','Etios'),
		('6','Corolla'),
		('7','C3'),
		('7','Berlingo'),
		('7','C4')

insert into tipos_vehiculos (descripcion)
values ('Hatchback'), ('Sedán'), ('Coupé'), ('SUV'), ('4x4'), ('Utilitario'), ('Ciclomotor')

insert into destinos_vehiculos (descripcion)
values ('Personal'), ('Comercial'), ('Protocolar'), ('Taxi'), ('Oficial'), ('Escolar'), ('Alquiler'), ('Autoescuela'), ('Remis')

insert into tipos_combustible (descripcion)
values ('Nafta'), ('Gasoil'), ('GNC'), ('Eléctrico'), ('Híbrido'), ('Biodiesel')

insert into generos (descripcion)
values ('Masculino'), ('Femenino'), ('Otros'), ('No especifica')

insert into tipos_telefonos (descripcion)
values ('Fijo Personal'), ('Celular Personal'), ('Fijo Laboral'), ('Celular Laboral'), ('Fax')

insert into tipos_documentos (descripcion)
values ('DNI'), ('Pasaporte'), ('Libreta Cívica'), ('L. Enrolamiento'), ('C. de extranjería')

insert into resultados (descripcion)
values ('Aprobado'), ('No Aprobado'), ('Fallas Leves'), ('Provisorio')

insert into tipos_controles (descripcion)
values ('Mecánico'), ('Eléctrico'), ('Interior'), ('Exterior'), ('Otros')

insert into controles (descripcion, id_tipo_control)
values	('Carrocería', 4),
		('Chasis', 4),
		('Alumbrado', 2), 
		('Señalización', 2), 
		('Emisiones', 5), 
		('Frenos', 1), 
		('Dirección', 1), 
		('Ejes', 1), 
		('Neumáticos', 4), 
		('Suspensiones', 1), 
		('Motor', 1), 
		('Transmisión', 1)

insert into ciudades (nombre)
values	('Córdoba'),
		('Rio Cuarto'),
		('Villa María'),
		('Villa Carlos Paz'),
		('San Francisco'),
		('Alta Gracia'),
		('Río Tercero'),
		('Bell Ville'),
		('La Calera'),
		('Villa Dolores'),
		('Río Primero'),
		('Río Segundo'),
		('Hernando'),
		('Huinca Renancó'),
		('Mediolaza'),
		('Villa Allende'),
		('Saldán'),
		('Malvinas Argentinas'),
		('Toledo'),
		('Pilar')

insert into barrios (nombre, id_ciudad)
values	('Alta Córdoba', '1'),
		('Alberdi', '1'),
		('Villa es Libertador', '1'),
		('Nueva Córdoba', '1'),
		('Centro', '1'),
		('San Vicente', '1'),
		('Jardín', '1'),
		('Pizarro', '2'),
		('Brasca', '2'),
		('Banda Norte', '2'),
		('Florentino Ameghino', '3'),
		('Carlos Pellegrini', '3'),
		('San Justo', '3'),
		('Los Eucaliptos', '4'),
		('Miguel Muñoz', '4'),
		('Consolata', '5'),
		('Corradi', '5'),
		('Barrio Cámara', '6'),
		('Barrio Sur', '6'),
		('Castagno', '7'),
		('Las Flores', '7')


insert into especialidades
values ('Mecánico'), ('Electrónico'), ('Carrocero'), ('Electricsta'), ('Supervisor')

insert into tipos_clientes
values ('Frecuente'), ('Inusual'), ('Registrado'), ('Propietario'), ('No Propietario')

insert into lineas_inspeccion
values ('Línea 1'), ('Línea 2'), ('Línea 3'), ('Línea 4'), ('Línea 5')

insert into vehiculos (dominio, id_modelo, id_tipo_vehiculo, num_chasis, num_motor, id_destino, año_fabricacion, id_tipo_combustible)
values	('GTR343','1','1','S7YFMBQ4Z6PVXA9P','9277274934753436657463','1','2012','1'),
		('CBA234','12','6','UCQKGR2R6QUV2PMB','6326664353865498327867','1','2006','1'),
		('AB876JR','10','1','GA8AUY6BSK9SNACZ','6893582978572929743843','2','2018','1'),
		('BN345TH','11','2','9BGZJ6F2YCLZTFTT','9393492285554744457568','1','2014','1'),
		('AA345GT','13','1','88TA8EUGD3V98P5E','3927578672664757249297','1','2015','3'),
		('CA001ER','2','1','L4F888FKWGWXM8SE','9968525267734849254872','1','2013','1'),
		('BA234ET','7','1','8JJEYLB6FGR83FCD','2334966644299465564757','3','2014','3'),
		('FJU345','4','1','VN2CCMB7QL64YGVJ','5485973679852398646526','8','1998','1'),
		('CDR377','6','2','SP9EG4FFVNUVQWTF','9297375724587887367236','1','2001','3'),
		('AB301OP','12','6','MEJ8U5VW9SNMQBSM','2457895766696463529349','1','2015','1'),
		('AA291IU','16','5','FSP22SAK5RA25KY6','3788358575464288378424','2','2017','2'),
		('BE702NI','12','6','D3KVEUFYD744NDDV','4725656998797493394724','2','2018','1'),
		('AN412FM','20','6','U4CEJ6QJGWH8XUCJ','8986885632988398246764','7','2016','3'),
		('AE322IR','14','2','3KMFEQNBDC9VLEP5','9429847548226358834436','1','2017','3'),
		('AO867MN','21','2','KYABJWGKL89UGT6H','6688898455462773454783','2','2019','1')

insert into observaciones
values ('Fallas Leves'), ('Sin Fallas')

insert into personas (id_tipo_doc, nro_documento, apellido, nombre, fecha_nacimiento, id_genero, calle, nro_calle, id_barrio, email)
values	('1','32457345','Rodriguez','Carlos','1990-09-21','1','Colon','234','4','carlosrodriguez@gmail.com'),
		('1','32712343','Toledo','Alexis','1987-07-12','1','Dean Funes','1234','2','alexistoledo@gmail.com'),
		('1','12314343','Lucero','Leandro','1965-02-04','1','Rafael Nuñez','431','5','lealucero@gmail.com'),
		('1','34563563','Zuloaga','Federico','1999-01-06','1','Juan B Justo','648','11','fedezuloaga@gmail.com'),
		('1','35446543','Pérez','Luciano','1982-02-12','1','Duarte Quirós','976','6','luperez@hotmail.com'),
		('2','AAE364754','López','Jimena','1978-05-10','2','Vélez Sarsfield','365','12','jime563@yahoo.com.ar'),
		('1','24323423','González','María','1980-10-21','2','9 de Julio','2354','3','mary_2324@hotmail.com'),
		('1','12231223','Martinez','Eugenia','1977-09-27','2','Santa Rosa','3252','21','eugemartinez@hotmail.com'),
		('1','23896768','Santoro','Ezequiel','1965-08-30','1','Sabattini','1554','2','e.santoro@frc.utn.edu.ar'),
		('1','29873094','Fernandez','Lorena','1962-02-23','2','Fuerza Aérea','8273','1','lore_cordoba@hotmail.com'),
		('2','AFE236457','Gomez','Ricardo','1959-04-26','1','27 de Abril','2984','4','ricardo1980@live.com'),
		('1','13472974','Perez','Eduardo','1991-06-16','1','Entre Ríos','1829','8','edu_elmejor@hotmail.com'),
		('1','12234343','Hernandez','María','1972-06-11','2','Tucumán','823','9','mariahernandez@gmail.com'),
		('1','13432437','Torres','Raúl','1983-11-09','1','Chacabuco','2892','5','raultorres@hotmail.com'),
		('1','18992728','Jimenez','Florencia','1970-04-02','2','Ituzaingó','1724','7','flor_jimenez@live.com')

insert into inspectores (id_persona, fecha_ingreso, id_especialidad, matricula)
values	('1', '2019-04-16', '4', ''),
		('2', '2017-02-06', '2', 'AB3754BN'),
		('3', '2013-12-30', '1', 'NI2485UY'),
		('4', '2018-08-16', '5', ''),
		('10', '2015-06-09', '3', '')

insert into clientes (id_persona, id_tipo_cliente)
values	('5','1'),
		('6','1'),
		('7','2'),
		('8','4'),
		('9','1'),
		('11','2'),
		('12','3'),
		('13','4'),
		('14','3'),
		('15','1')

insert into telefonos_por_persona (nro_telefono, id_persona, id_tipo_telefono)
values	('35134236423','1','1'),
		('35427465739','2','1'),
		('35193857204','4','4'),
		('35199374395','4','1'),
		('35672849934','6','1'),
		('11938757384','3','1'),
		('35128284721','1','5'),
		('35128432924','11','1'),
		('35131976813','12','1'),
		('35724738462','13','4'),
		('35124596305','15','1'),
		('35134328573','9','1'),
		('35143248239','14','1'),
		('35184234923','2','1'),
		('35132459723','3','1'),
		('35423472347','4','2'),
		('35148323934','5','2'),
		('35134424948','6','3')

insert into informes (fecha_informe, hora_informe, dominio, id_linea_inspeccion, legajo, id_cliente, nro_oblea, fecha_venc_oblea, resultado_inspeccion, fecha_regreso_insp, id_observaciones)
values	('2018-08-03','08:13','AB876JR','3','4','8','3543','2019-08-03','1','','2'),
		('2018-12-22','07:12','AA291IU','2','2','4','2131','2019-12-22','1','','2'),
		('2018-01-15','11:48','AA291IU','5','1','10','3245','2019-01-15','1','','2'),
		('2018-04-09','16:12','AO867MN','1','2','1','2143','2019-04-09','1','','2'),
		('2018-06-12','09:32','AA291IU','4','3','2','7643','2019-06-12','0','2018-09-12','1'),
		('2018-11-10','07:45','CDR377','2','2','3','3245','2019-11-10','1','','2'),
		('2018-02-06','12:09','GTR343','3','5','4','3245','2019-02-06','0','2018-05-06','1'),
		('2018-03-21','10:35','AN412FM','1','1','7','1234','2019-03-21','1','','2'),
		('2018-05-30','10:21','BN345TH','1','5','6','3456','2019-05-30','1','','2'),
		('2018-07-18','09:40','CBA234','5','3','9','0375','2019-07-18','1','','2')

insert into detalle_informes (nro_informe, id_control_item, id_resultado)
values	('1','3','1'),
		('1','8','1'),
		('2','12','1'),
		('2','11','1'),
		('3','10','1'),
		('3','7','1'),
		('3','6','1'),
		('4','5','1'),
		('5','4','3'),
		('5','5','1'),
		('6','8','1'),
		('7','10','3'),
		('7','7','1'),
		('7','5','1'),
		('8','4','1'),
		('8','7','1'),
		('9','6','1'),
		('10','11','1'),
		('10','10','1'),
		('10','5','1')