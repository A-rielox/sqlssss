USE Gym;
GO

DROP TABLE IF EXISTS dbo.PicturesClass;
GO

CREATE TABLE PicturesClass
(
	id INT IDENTITY(1,1),
	url VARCHAR(500),
	publicId VARCHAR(500),
	classId INT

	CONSTRAINT PK_PicturesClass_id PRIMARY KEY (id),
	CONSTRAINT FK_PicturesClass_appUserId FOREIGN KEY (classId) REFERENCES Clase (id)
);

SELECT * 
FROM PicturesClass ORDER BY classId;


INSERT INTO [dbo].[PicturesClass] (url, classId)
VALUES	('https://media.istockphoto.com/id/1362732103/es/foto/mujer-en-kimono-practicando-tabla-de-rotura.jpg?s=612x612&w=0&k=20&c=2CtZMDdHNx3ZOfLxIaciG4ajXYKqC-nDWUyepzkR27E=', 5),-- Karate adultos intermedio
		('https://media.istockphoto.com/id/1430749093/es/foto/maestros-de-karate-rompiendo-con-la-pata-de-tabla-de-madera.jpg?s=612x612&w=0&k=20&c=TCnHScZb9LAPZUmJv1zv_QN8bchDloVVPnby9XfY0n4=', 5),
		('https://media.istockphoto.com/id/1343482344/es/foto/jugador-de-karate-masculino-rompiendo-tablones-de-madera.jpg?s=612x612&w=0&k=20&c=v63MX88iMtTLcc_kIimoZrTdvhJt_mY9r5WScUKurmU=', 5),
		('https://media.istockphoto.com/id/1432699739/es/foto/maestros-de-karate-rompiendo-con-la-pata-de-tabla-de-madera.jpg?s=612x612&w=0&k=20&c=wrio9SXqUN20TcM5JI6DZpKFnbsT8X_DNNwBBRGukH4=', 5),

		('https://media.istockphoto.com/id/895781768/es/foto/con-un-cintur%C3%B3n-azul-una-chica-adulto-pega-una-patada.jpg?s=612x612&w=0&k=20&c=MwcpA7dv1Y7y7fVuxjYTGto_mAHpTc1Zlfr0P23uFZo=', 6),-- Karate adultos avanzado
		('https://media.istockphoto.com/id/503190180/es/foto/karate-jugadores-en-acciones.jpg?s=612x612&w=0&k=20&c=YV65peAExMrQG3TguhjQpXzX51M8icvqefBSY_6DEQI=', 6),
		('https://media.istockphoto.com/id/1037680658/es/foto/un-hombre-en-negro-guantes-golpea-con-la-mano-en-un-salto-aislado.jpg?s=612x612&w=0&k=20&c=FF7txg1W_XQM8o4KDZV0C0zdFdrHU8Sj0V_hpO61nm8=', 6),
		('https://media.istockphoto.com/id/839396254/es/foto/con-una-deportista-cintur%C3%B3n-naranja-sobre-un-fondo-blanco.jpg?s=612x612&w=0&k=20&c=2gCoWVZNMz5DpGXADv4wt42jQpoHH0KWcm41O6NLqEk=', 6),

		('https://media.istockphoto.com/id/1302910346/es/foto/mujer-atl%C3%A9tica-con-ropa-deportiva-pantalones-y-top-realizando-handstand-en-yoga.jpg?s=612x612&w=0&k=20&c=4ge4ud8oE-0ByhH68YguYTzR4ZR9KwYN464U_xls-ac=', 7),-- Yoga adulto mayor intermedio
		('https://media.istockphoto.com/id/601901840/es/vector/hombre-en-la-posici%C3%B3n-de-loto-de-asana.jpg?s=612x612&w=0&k=20&c=Q-LAKTspZefi6tlP7vFllrqlof9oAz17LzsQ2Ed5yEM=', 7),
		('https://media.istockphoto.com/id/482044074/es/foto/mujer-joven-meditar-al-aire-libre-en-una-terraza.jpg?s=612x612&w=0&k=20&c=eZnGHIG3mhVqY2Y_M80RDd4PZCxReREK1Un3F_E8BEI=', 7),
		('https://media.istockphoto.com/id/162535945/es/foto/feliz-mujer-joven-en-una-estera-de-yoga-estiramientos-las-piernas.jpg?s=612x612&w=0&k=20&c=P1rQmoJsNt6gT1BRKpTbhnfgUlqczWr330C65IdgDK0=', 7),

		('https://media.istockphoto.com/id/1302675836/es/foto/mujer-hispana-practicando-movimientos-de-zumba.jpg?s=612x612&w=0&k=20&c=cntrNpXaFkL9Q0FunvdiXXDfmylpdluqCbre4pkv0vs=', 3),-- Zumba avanzado
		('https://media.istockphoto.com/id/843203000/es/foto/bailarines-de-cardio-mujer-baile-fitness-ejercicio-ejercicios-aisla.jpg?s=612x612&w=0&k=20&c=1mHa297J5rH0rBUa_nHwQhpdGOioMThRtDkDJxrkabQ=', 3),
		('https://media.istockphoto.com/id/538854567/es/foto/baile-zumba-mujer.jpg?s=612x612&w=0&k=20&c=J7HmUKYp-XbmALgElOtp6i_PIeB86UcMmPVlFiBaADs=', 3),
		('https://media.istockphoto.com/id/1155585331/es/vector/banner-gente-feliz-bailando.jpg?s=612x612&w=0&k=20&c=wwb4qPQ5BN1SBJHXANvHq2y0aZN7qnUFWJIv5rPRBdI=', 3),

		('https://media.istockphoto.com/id/155235113/es/foto/pareja-de-baile-latino-en-sal%C3%B3n-de-baile.jpg?s=612x612&w=0&k=20&c=FY0PVOMC1NkQ9Ia7749vHhyqPtksPwKgk-HdE0M1WrY=', 1),-- salsa principiante
		('https://media.istockphoto.com/id/467293786/es/foto/pareja-de-baile-latino-en-acci%C3%B3n-samba-salvaje-de-baile.jpg?s=612x612&w=0&k=20&c=WcK-2A-ifW0Pt8uIb0Eq1A6hTfGX0k6NZH5R-3jnexY=', 1),
		('https://media.istockphoto.com/id/911529800/es/vector/ultra-violeta-grabado-de-una-raza-mixta-mujer-bailar-salsa.jpg?s=612x612&w=0&k=20&c=KOZe73KCy_oVEbQxnPj79DLRhagmnlQgtyAXc5Wx3uk=',1),
		('https://media.istockphoto.com/id/1175415462/es/vector/texto-nocturno-de-salsa-sobre-fondo-colorido.jpg?s=612x612&w=0&k=20&c=CQO4kmXpj_ps5A7qEAio5Bb51mkcdywZ2JadcB-IL2w=', 1),

		('https://media.istockphoto.com/id/535873133/es/foto/mujer-joven-contra-explosi%C3%B3n-de-baile-flamenco.jpg?s=612x612&w=0&k=20&c=KxXkiknZih4OP3K4f6vfYfTq1qUqqrPJ_vtOuhIMqjQ=', 2),-- salsa intermedio
		('https://media.istockphoto.com/id/822599876/es/vector/el-baile-de-salsa.jpg?s=612x612&w=0&k=20&c=k70PwWFMesqpDhm1SwsZsQ8e4nRCoJMy3sdQcc11Awk=', 2),
		('https://media.istockphoto.com/id/1370556766/es/foto/par-de-bailarines-bailando-baile-de-sal%C3%B3n-sobre-fondo-de-pintura-art%C3%ADstica-aviador.jpg?s=612x612&w=0&k=20&c=uKDpdD7C9E2W_LBHVUpz7cJ7RDB_MZCtN8M1CpmNR5w=', 2),
		('https://media.istockphoto.com/id/1536222099/es/vector/pareja-de-ancianos-bailan-ilustraci%C3%B3n-vectorial-divertida-pareja-de-ancianos-bailando.jpg?s=612x612&w=0&k=20&c=oJtiyOmtfN2fg2eUKVoenluc4xWdHyS46-5mURbPDpM=', 2),

		('https://media.istockphoto.com/id/1359873270/es/vector/ilustraci%C3%B3n-de-dibujos-animados-de-un-ni%C3%B1o-jugando-karate.jpg?s=612x612&w=0&k=20&c=6fdkJR1b5SyvWiJ1HjlI7WP-B0pdnybXWhb2uTcrKLk=', 4),-- Karate niños principiante
		('https://media.istockphoto.com/id/1227071974/es/vector/dise%C3%B1o-del-logotipo-de-esport-de-la-mascota-de-karate-martial.jpg?s=612x612&w=0&k=20&c=rrcnuA57-wxBCNA6DgOQ55G0h6SuILfwneQ-CILRfeY=', 4),
		('https://media.istockphoto.com/id/453933987/es/foto/la-chica-est%C3%A1-protegido-de-un-ni%C3%B1o-lanzar.jpg?s=612x612&w=0&k=20&c=CVPeUqTwdoO6lSHEBnXXOuZJ0Jp5HzWuBVcogd0CQww=', 4),
		('https://media.istockphoto.com/id/1403143477/es/vector/personaje-de-dibujos-animados-ninja-con-espada-katana.jpg?s=612x612&w=0&k=20&c=KEecjotFCbayUKTFTaIDTXY8R15JFk32DRZlB2oqieM=', 4)
;

SELECT * 
FROM PicturesClass ORDER BY classId;


--TRUNCATE TABLE Gym.dbo.PicturesClass;


