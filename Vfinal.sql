create database m22;
use m22;
create table if not exists perfil(
idPerfil int not null,
nombrePerfil varchar (45),
codigo varchar(45),
PRIMARY KEY (idPerfil)
);
create table if not exists usuario(
		idUsuario int not null,
		nombreUsuario varchar(45),
        idPerfil int,
        idZona int,
		PRIMARY KEY (idUsuario),
        FOREIGN KEY (idPerfil) REFERENCES perfil(idPerfil)
);

create table if not exists ordenTrabajo (
	idOrdenTrabajo  int not null,
    codigo varchar(45),
    fecha date,
    descripcion varchar(45),
    idUsuario int,
    PRIMARY KEY (idOrdenTrabajo),
	FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario)
    );

create table if not exists reporte(
	idReporte int not null,
	reporte varchar (45),
	codigo varchar(45),
	fechaInicio date,
	fechaFin date,
	idOrdenTrabajo int,
	PRIMARY KEY (idReporte),
	FOREIGN KEY (idOrdenTrabajo) REFERENCES ordenTrabajo(idOrdenTrabajo) 
);
create table if not exists tecnico(
	idTecnico int not null,
	nombreTecnico varchar(45),
    PRIMARY KEY (idTecnico)
);
create table if not exists reporteTecnico(
	idReporteTecnico int not null,
    idTecnico int,
    idReporte int,
    primary key (idReporteTecnico),
    FOREIGN KEY (idTecnico) REFERENCES tecnico(idTecnico) ,
    FOREIGN KEY (idReporte) REFERENCES reporte(idReporte) 
);
create table if not exists actividad(
	idActividad int not null,
    nombreActividad varchar(45),
    codigo varchar(45),
    PRIMARY KEY (idActividad)
);
create table if not exists reporteActividad(
	idReporteActividad int not null,
	idReporte int,
    idActividad int,
    PRIMARY KEY (idReporteActividad),
    FOREIGN KEY (idReporte) REFERENCES reporte(idReporte),
    FOREIGN KEY (idActividad) REFERENCES actividad(idActividad)
);
create table if not exists usuarioReporte(
	idUsuarioReporte int not null,
    idUsuario int,
    idReporte int,
    PRIMARY KEY (idUsuario),
	FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario),
	FOREIGN KEY (idReporte) REFERENCES reporte(idReporte)
);

insert into perfil
values ( 1,'yolo', 1),
(2,'pvp',2);
insert into usuario 
 values ( 1, 'daniel', 1, 6),
 ( 2, 'camilo', 2, 6);
insert into actividad
values (1, 'falla_interna', 6),
	(2, 'falla_externa', 6);
insert into ordenTrabajo
values (1, 6, '2022-02-17', 'falla_cableado', 1),
(2, 6, '2022-02-17', 'falla_cableado', 1);
insert into reporte
values (1, 'falla_interna', 6, '2022-02-17', '2022-02-18', 1),
(2, 'falla_Externa', 6, '2022-02-17', '2022-02-22', 1);

insert into usuarioReporte
values (1, 1, 1);
insert into reporteActividad
values (1, 1, 1),
(2,2,2);
insert into tecnico values(1,'juancarlos');
insert into reporteTecnico values(1,1,1);
insert into reporteTecnico values(2,1,2);




SELECT 
TIMESTAMPDIFF(HOUR, reporte.fechaInicio,reporte.fechaFin) AS TiempoTardado 
from reporte 
left join ordenTrabajo 
on ordenTrabajo.idOrdenTrabajo = reporte.idOrdenTrabajo
where ordenTrabajo.codigo = 6;



select Tecnico.nombreTecnico,
       count(reporte.reporte) as numeroOrdenes,
       reporte.fechaInicio as fecha
from tecnico
left join reporteTecnico
on reporteTecnico.idTecnico = tecnico.idTecnico 
inner join reporte 
on reporte.idReporte = reporteTecnico.idReporte 
where reporte.fechaInicio >= '2022-01-01' and reporte.fechaInicio <= '2022-12-31';


		select actividad.nombreActividad,
		max(TIMESTAMPDIFF (HOUR, reporte.fechaInicio,reporte.fechaFin)) AS HorasHombre
        from actividad 
        left join reporteActividad 
        on reporteActividad.idActividad = actividad.idActividad
        left join reporte 
        on reporte.idReporte = reporte.idReporte;
        
        
        select usuario.idUsuario,
				usuario.nombreUsuario,
				ifnull(count(usuarioReporte.idreporte),0) as numeroReportes
                from usuario
                left join usuarioReporte 
                on  usuarioreporte.idUsuario = usuario.idUsuario
                where usuarioReporte.idreporte is null
                union 
         select usuario.idUsuario,
				usuario.nombreUsuario,
				ifnull(count(usuarioReporte.idreporte),0) as numeroReportes
                from usuario
                inner join usuarioReporte 
                on  usuarioreporte.idUsuario = usuario.idUsuario
                
               


