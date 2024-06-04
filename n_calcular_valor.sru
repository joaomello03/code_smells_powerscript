HA$PBExportHeader$n_calcular_valor.sru
forward
global type n_calcular_valor from nonvisualobject
end type
end forward

global type n_calcular_valor from nonvisualobject
end type
global n_calcular_valor n_calcular_valor

forward prototypes
public function decimal of_calcular_valor (decimal ade_preco, decimal ade_taxa, decimal ade_desconto, integer ai_quantidade)
end prototypes

public function decimal of_calcular_valor (decimal ade_preco, decimal ade_taxa, decimal ade_desconto, integer ai_quantidade);Return (ade_Preco + ade_Taxa + ade_Desconto) * ai_Quantidade
end function

on n_calcular_valor.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_calcular_valor.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

