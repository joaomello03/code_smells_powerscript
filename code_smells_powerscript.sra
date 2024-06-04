HA$PBExportHeader$code_smells_powerscript.sra
$PBExportComments$Generated Application Object
forward
global type code_smells_powerscript from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type code_smells_powerscript from application
string appname = "code_smells_powerscript"
end type
global code_smells_powerscript code_smells_powerscript

on code_smells_powerscript.create
appname = "code_smells_powerscript"
message = create message
sqlca = create transaction
sqlda = create dynamicdescriptionarea
sqlsa = create dynamicstagingarea
error = create error
end on

on code_smells_powerscript.destroy
destroy( sqlca )
destroy( sqlda )
destroy( sqlsa )
destroy( error )
destroy( message )
end on

