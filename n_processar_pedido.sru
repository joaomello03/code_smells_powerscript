HA$PBExportHeader$n_processar_pedido.sru
forward
global type n_processar_pedido from nonvisualobject
end type
end forward

global type n_processar_pedido from nonvisualobject
end type
global n_processar_pedido n_processar_pedido

forward prototypes
public function integer of_processar_pedido (long al_idpedido)
public function decimal of_calcular_desconto (long al_iditem, long al_quantidade)
public function boolean of_verificar_estoque (long al_iditem, long al_quantidade)
public function integer of_atualizar_total_pedido (long al_idpedido, decimal ade_precofinal)
public function boolean of_atualizar_estoque (long al_iditem, long al_quantidade)
end prototypes

public function integer of_processar_pedido (long al_idpedido);// Fun$$HEX2$$e700e300$$ENDHEX$$o para processar um novo pedido
DataStore lds_Pedido
Integer li_For, li_Resultado
Long ll_IdItem, ll_Quantidade
Decimal lde_PrecoUnitario, lde_Desconto, lde_PrecoTotal, lde_PrecoFinal

// Carregar os detalhes do pedido
lds_Pedido = Create DataStore
lds_Pedido.DataObject = "d_pedido"
lds_Pedido.SetTransObject(SQLCA)
lds_Pedido.Retrieve(al_IdPedido)

// Verificar cada item do pedido
For li_For = 1 To lds_Pedido.RowCount()
	ll_IdItem = lds_Pedido.GetItemNumber(li_For, "iditem")
	ll_Quantidade = lds_Pedido.GetItemNumber(li_For, "quantidade")
	lde_PrecoUnitario = lds_Pedido.GetItemDecimal(li_For, "precounitario")

	// Verificar estoque
	If Not of_Verificar_Estoque(ll_IdItem, ll_Quantidade) Then
		MessageBox("Erro", "Estoque insuficiente para o item: " + String(ll_IdItem))
		Return -1
	End If
	
	// Aplicar desconto se aplic$$HEX1$$e100$$ENDHEX$$vel
	lde_Desconto = of_Calcular_Desconto(ll_IdItem, ll_Quantidade)
	lde_PrecoTotal = ll_Quantidade * lde_PrecoUnitario
	lde_PrecoFinal = lde_PrecoTotal - (lde_PrecoTotal * lde_Desconto / 100)

	// Atualizar estoque
	If Not of_Atualizar_Estoque(ll_IdItem, ll_Quantidade) Then
		MessageBox("Erro", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar o estoque para o item: " + String(ll_IdItem))
		Return -1
	End If

	// Atualizar o total do pedido
	li_Resultado = of_Atualizar_Total_Pedido(al_IdPedido, lde_PrecoFinal)
	If li_Resultado <> 1 Then
		MessageBox("Erro", "Problema ao atualizar o total do pedido.")
		Return -1
	End If
Next

// Finaliza o processamento com sucesso
Return 1
end function

public function decimal of_calcular_desconto (long al_iditem, long al_quantidade);Return 1
end function

public function boolean of_verificar_estoque (long al_iditem, long al_quantidade);Return True
end function

public function integer of_atualizar_total_pedido (long al_idpedido, decimal ade_precofinal);Return 1
end function

public function boolean of_atualizar_estoque (long al_iditem, long al_quantidade);Return True
end function

on n_processar_pedido.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_processar_pedido.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

