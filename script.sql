
-- entro como sysdba
conn sys/coti as sysdba;


create user auladois identified by coti
 default tablespace users
quota 100m on users;

grant create table, create sequence, create session, 
create view, create procedure, create trigger to auladois;

-- me conecto
conn auladois/coti

--mostra quem eu sou
select user from dual;

create table aluno(idAluno number(15) primary key, nome varchar2(50), 
email varchar2(50) unique);

create sequence seq_aluno;

create or replace package PKG_ALUNO is
  procedure inclusao(vnome in varchar, vemail in varchar2);
  function findByCode(vcod in number) return varchar2;
  function findAll return sys_refcursor;
  procedure alteracao(vid in number, vnome in varchar, vemail in varchar);
  procedure exclusao (vid in number);
  end PKG_ALUNO; 
  /
  show errors;

-- sequencia criada
  select * from cat;
  create seuqence seq_aluno;

  create or replace package body PKG_ALUNO is 

  procedure inclusao (vnome in varchar, vemail in varchar2) as
  begin
  insert into aluno values (seq_aluno.nextval, vnome, vemail);
  commit;
  dbms_output.put_line('Ok dados gravados...');
  exception when others then
  dbms_output.put_line('Error....' || sqlerrm);
  rollback;
  end;

  function findByCode(vcod in number) return varchar2
  as
  vnome varchar2(50):='';
  vemail varchar2(50):='';
  begin
  select nome, email into vnome, vemail from aluno where idAluno= vcod;
  return vcod || ',' || vnome || ',' || vemail;
  exception when others then
  return 'Nao encontrado...';
  end;
  
  function findAll return sys_refcursor
  as
  linha sys_refcursor;
  begin
  open linha for select * from aluno;
  return linha;
  end;

  procedure alteracao(vid in number, vnome in varchar, vemail in varchar)
  as
  begin
  update aluno set nome=vnome, email=vemail where idAluno = vid;
  dbms_output.put_line('Dados alterados');
  exception when others then
  dbms_output.put_line('Error:' || sqlerrm);
  end;

  procedure exclusao(vid  in number) as
  begin
  delete from aluno where idAluno = vid;
  commit;
  dbms_output.put_line('Registro excluido');
  exception when others then
  dbms_output.put_line('Error' || sqlerrm);
  rollback;
  end;
  end PKG_ALUNO;
  /

 set serveroutput on size 20000;
 set linesize 2000;
 column nome format a15;
 column email format a20;
 
 --inclusao
 exec PKG_ALUNO.inclusao('lu', 'lu@gmail.com');
 exec PKG_ALUNO.inclusao('geovani', 'geovani@gmail.com');
 
 --sera apagado o test
 exec PKG_ALUNO.inclusao('test','test@gmail.com');

--consultar
 select PKG_ALUNO.findAll from dual;
 select PKG_ALUNO.findByCode(1) from dual;


--alteracao
 exec PKG_ALUNO.alteracao(1,'lu','luciana@gmail.com');

 --apagar
 exec PKG_ALUNO.exclusao(3);


 create table pessoa(id number(5) primary key,
 nome varchar(50), salario number(15,2), sexo varchar(1));
create sequence seq_pessoa;

 insert into pessoa values(seq_pessoa.nextval, 'china', 10000, 'm');
 insert into pessoa values(seq_pessoa.nextval, 'lu', 150000, 'f');
 insert into pessoa values(seq_pessoa.nextval, 'geovani', 15000, 'm');
 insert into pessoa values(seq_pessoa.nextval, 'magali', 3000, 'f');
 insert into pessoa values(seq_pessoa.nextval, 'puca', 6000, 'f');
 commit;

 create or replace function buscaSexo (vsexo in varchar)
 return sys_refcursor
 as
 linha sys_refcursor;
 begin
 open linha for select * from pessoa where sexo=vsexo;
 return linha;
 end;
 /

select buscaSexo('m') from dual;


-- ORACLE FULL
create table funcionario(
    id number(15) primary key,
    nome varchar(50),
    salario number(15.2),
    estado varchar2(20)
)
partition by list(estado)
(partition RIODEJANEIRO values ('RJ') tablespace users,
 partition SAOPAULO values ('SP') tablespace users,
 partition MINASGERAIS values ('MG') tablespace users
);

insert into funcionario values(10,'lu',15000,'RJ');
insert into funcionario values(11,'china', 9000,'SP');
insert into funcionario values(12,'geovani', 7000,'MG');
insert into funcionario values(13,'gabriel',8000,'RJ');
insert into funcionario values(14,'luis',12000,'SP');
commit;

  --usuario
 --maquina virtual
 
  cmd
  cd C:appUserproduct11.2.0dbhome_1BIN


  sqlplus system/coti

  conn sys/coti as sysdba;

 create user auladois identified by coti
  default tablespace users
 quota 100m on users;

 grant create table, create sequence,
  create session, create view, create procedure,
  create trigger
  to auladois;

conn auladois/coti 


 create table funcionario(
     id number (15) primary key,
     nome varchar (50),
     salario number (15,2),
     estado varchar2 (20)  
 )
 partition by list(estado)
 (
   partition RIODEJANEIRO values ('RJ') tablespace users,
  partition SAOPAULO values ('SP') tablespace users,
  partition MINASGERAIS values ('RJ') tablespace users
);

insert into funcionario values (10,'lu',15000,'RJ');
insert into funcionario values (11,'china',9000,'SP');
insert into funcionario values (12,'geovani',7000,'MG');
insert into funcionario values (13,'gabriel',8000,'RJ');
insert into funcionario values (14,'luis',12000,'SP');
commit;

  --usuario
 --maquina virtual
 
  cmd
  cd C:appUserproduct11.2.0dbhome_1BIN


  sqlplus system/coti

  conn sys/coti as sysdba;

 create user auladois identified by coti
  default tablespace users
 quota 100m on users;

 grant create table, create sequence,
  create session, create view, create procedure,
  create trigger
  to auladois;

conn auladois/coti 


 create table funcionario(
     id number (15) primary key,
     nome varchar (50),
     salario number (15,2),
     estado varchar2 (20)  
 )
 partition by list(estado)
 (
   partition RIODEJANEIRO values ('RJ') tablespace users,
  partition SAOPAULO values ('SP') tablespace users,
  partition MINASGERAIS values ('RJ') tablespace users
);

insert into funcionario values (10,'lu',15000,'RJ');
insert into funcionario values (11,'china',9000,'SP');
insert into funcionario values (12,'geovani',7000,'MG');
insert into funcionario values (13,'gabriel',8000,'RJ');
insert into funcionario values (14,'luis',12000,'SP');
commit;

set linesize 2000;
column nome format a15;
column estado format a10;


select * from funcionario partition (RIODEJANEIRO);
select * from funcionario partition (SAOPAULO);
select * from funcionario partition (MINASGERAIS);

-- alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
-- select sysdate from dual;
-- create or replace function getIdade(vdatanasc in date)
-- return number
-- is vidade number(5) :=0;
-- begin
-- vidade :=floor(floor(months_between(sysdate, vdatanasc))/12);
-- return vidade;
-- dbms_output.put_line('Error' || sqlerrm);
-- return -1
-- end;
-- /

-- select getIdade(to_date('28/01/1973','dd/mm/yyyy')) as idade from dual;