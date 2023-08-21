-- Criando o usários
CREATE USER IF NOT EXISTS 'dinah' IDENTIFIED BY '123',
						  'lais' IDENTIFIED BY '123',
                          'lucas' IDENTIFIED BY '123',
                          'renato' identified BY '123',
                          'lupita' identified by '123';
-- OBS: se quiser que seja de local especifico, ip usar o @local ou ip

-- lista os usuários criados
SELECT user, host FROM mysql.user;

GRANT ALL PRIVILEGES ON *.* TO 'dinah' WITH GRANT OPTION; -- todos privilégios em todos os bancos
GRANT ALL PRIVILEGES ON projeto.* TO 'lais' WITH GRANT OPTION; -- tem todos os privilégios apenas no banco projeto
GRANT SELECT ON *.* TO 'lucas' WITH GRANT OPTION; -- poderar usar o select em todas os bancos
GRANT SELECT ON projeto.* TO 'renato' WITH GRANT OPTION; -- só dará select no banco projeto

SHOW GRANTS FOR dinah; -- mostrar os privilégios que o usuário tem

REVOKE ALL PRIVILEGES ON *.* FROM 'dinah'@'%'; -- remove todos os privilegios e de qualquer lugar (%)

-- roles conjunto de funçoes/papeis, evita add individulamente privilégios
-- objetos, como SELECT, INSERT, UPDATE, DELETE, CREATE TABLE, CREATE PROCEDURE, 

CREATE ROLE if not exists 'desenvolvedor', 'leitura', 'gravacao', 'backup_role'; -- criando os papeis

GRANT ALL ON projeto.* TO 'app_desenvolvedor'; -- terá todos os privilégios sobre os objetos
GRANT SELECT ON projeto.* TO 'app_leitura'; -- terá privilégio de select na tabela projeto
GRANT INSERT, UPDATE, DELETE ON projeto.* TO 'app_gravacao'; -- terá os privilegios de insert, update, dele na tabela projeto
GRANT BACKUP_ADMIN ON *.* TO backup_role; -- terá todos os privilegios relacionado a backup



GRANT 'app_desenvolvedor' TO 'usuariox'; -- acesso a tudo
GRANT 'app_leitura' TO 'usuariox', 'usariow'; -- acesso só a leitura
GRANT 'app_leitura', 'app_gravacao' TO 'usuariok'; -- acesso a leitura e gravações
GRANT 'backup_role' TO 'lupita'; -- ações de backup

-- em cada seção com o comando a baixo, identifca a role que o usuário tem
SELECT CURRENT_ROLE();
SHOW GRANTS FOR 'usuariox' USING 'app_desenvolvedor'; -- exibe os privilegios do usuário é uma determinada role

-- ativando as role para os usuários
SET DEFAULT ROLE ALL TO
  'usuariox',
  'usuariox',
  'usariow',
  'usuariok';

-- revogar privilégios
SELECT USER(); -- para confirmar se esta na sessao root
REVOKE INSERT, UPDATE, DELETE ON projeto.* FROM 'app_gravacao'; -- para revogar alguns privilegios da role app_gravacao

/*====
-- ROLES que vem de ORACLE (Versao ATUAL do mysql) 
-- e que podemos dar privilegio para usuarios nestas ROLES:

https://dev.mysql.com/doc/workbench/en/wb-mysql-connections-navigator-management-users-and-privileges.html

DBA: Concede os direitos para realizar todas as tarefas.
DBManager: Concede direitos em todos os bancos de dados, mas com excecao de alguns direitos predefinidos, como criar user, dar shutdown,...
MaintenanceAdmin: Concede direitos para manter o servidor, como parar o servico mysql (shutdown), dar show databases, carregar tabelas
ProcessAdmin: Concede direitos para avaliar, monitorar e eliminar (kill) os processos do usuário.
UserAdmin: Concede direitos para criar usuário e redefinir senhas.
SecurityAdmin: Concede direitos para gerenciar usuarios e conceder e revogar privilégios de servidor. Cuidado para quem da este direito porque ela pode criar um user com direito de DBA.
MonitorAdmin: Concede os direitos mínimos para monitorar o servidor.
DBDesigner: Concede direitos para criar e fazer engenharia reversa em qualquer esquema de banco de dados.
ReplicationAdmin: Concede os direitos necessários para configurar e gerenciar a replicação.
BackupAdmin: Concede direitos mínimos necessários para fazer backup de qualquer banco de dados.
Custom: Pode ser customizados privilegios.
=====*/

-- remover usuário de um role
REVOKE app_leitura FROM 'usuário';

-- deletar role
DROP ROLE 'app_leitura', 'app_gravacao', 'app_desenvolvedor';

-- PARA DELETAR USER
DROP USER IF EXISTS 'usuario';