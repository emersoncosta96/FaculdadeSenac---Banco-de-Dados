alter table musicos
	add column Instrumento_Fav varchar(25) null after dt_nascimento;

    
alter table Instrumentos
	add column Categoria varchar(25) not null;
    
alter table orquestra 
	add column Data_Apres datetime(6) null after dt_fundacao;
    
alter table orquestra
	add column Ultima_Apres datetime(6) null after dt_fundacao;
    
alter table orquestra
	add column Final_Apres datetime(6) null after Data_Apres;
    
alter table musicos
	add column Sexo char(1) null after Instrumento_Fav;
    
alter table Instrumentos
	add column Marca varchar(25) null after Categoria;
    
alter table Sinfonia 
	add column duracao time null after dt_criacao;
    
alter table Musicos
	add column experiencia varchar(25) null after sexo;