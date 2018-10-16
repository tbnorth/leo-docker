\c guacamole_db
insert into guacamole_connection (connection_id, connection_name, protocol) values (1, 'test', 'vnc');
insert into guacamole_connection_parameter values (1, 'hostname', '127.0.0.1');
insert into guacamole_connection_parameter values (1, 'password', 'only1234');
insert into guacamole_connection_parameter values (1, 'port', '5901');
