HA$PBExportHeader$n_calcular_valor_refatorado.sru
forward
global type n_calcular_valor_refatorado from nonvisualobject
end type
end forward

global type n_calcular_valor_refatorado from nonvisualobject
end type
global n_calcular_valor_refatorado n_calcular_valor_refatorado

forward prototypes
public function decimal of_calcular_valor (s_dados ast_dados)
end prototypes

public function decimal of_calcular_valor (s_dados ast_dados);Return (ast_Dados.Preco + ast_Dados.Taxa + ast_Dados.Desconto) * ast_Dados.Quantidade
end function

on n_calcular_valor_refatorado.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_calcular_valor_refatorado.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

