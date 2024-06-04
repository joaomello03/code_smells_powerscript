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
public function boolean of_carregar_detalhes_pedido (ref datastore ads_pedido, long al_idpedido)
public function boolean of_processar_itens_pedido (datastore ads_pedido)
public function boolean of_processar_estoque (long al_iditem, long al_quantidade)
public function decimal of_calcular_desconto (long al_iditem, long al_quantidade)
public function boolean of_atualizar_total_pedido (long al_idpedido, decimal ade_precofinal)
public function boolean of_verificar_estoque (long al_iditem, long al_quantidade)
public function boolean of_atualizar_estoque (long al_iditem, long al_quantidade)
end prototypes

public function integer of_processar_pedido (long al_idpedido);// Fun$$HEX2$$e700e300$$ENDHEX$$o principal para processar um novo pedido
DataStore lds_Pedido

// Carregar os detalhes do pedido
If Not of_Carregar_Detalhes_Pedido(Ref lds_Pedido, al_IdPedido) Then
	Return -1
End If

// Processar cada item do pedido
If Not of_Processar_Itens_Pedido(lds_Pedido) Then
	Return -1
End If

// Finaliza o processamento com sucesso
Return 1
end function

public function boolean of_carregar_detalhes_pedido (ref datastore ads_pedido, long al_idpedido);// Fun$$HEX2$$e700e300$$ENDHEX$$o para carregar os detalhes do pedido
ads_Pedido = Create DataStore
ads_Pedido.DataObject = "d_pedido"
ads_Pedido.SetTransObject(SQLCA)

If ads_Pedido.Retrieve(al_IdPedido) = 0 Then
	MessageBox("Erro", "Pedido n$$HEX1$$e300$$ENDHEX$$o encontrado.")
	Return False
End If

Return True
end function

public function boolean of_processar_itens_pedido (datastore ads_pedido);// Fun$$HEX2$$e700e300$$ENDHEX$$o para processar cada item do pedido
Integer li_For
Long ll_IdItem, ll_Quantidade
Decimal lde_PrecoUnitario, lde_Desconto, lde_PrecoTotal, lde_PrecoFinal

For li_For = 1 To ads_Pedido.RowCount()
	ll_IdItem = ads_Pedido.GetItemNumber(li_For, "iditem")
	ll_Quantidade = ads_Pedido.GetItemNumber(li_For, "quantidade")
	lde_PrecoUnitario = ads_Pedido.GetItemDecimal(li_For, "precounitario")

	// Verificar e atualizar estoque
	If Not of_Processar_Estoque(ll_IdItem, ll_Quantidade) Then
		Return False
	End If

	// Calcular e aplicar desconto
	lde_Desconto = of_Calcular_Desconto(ll_IdItem, ll_Quantidade)
	lde_PrecoTotal = ll_Quantidade * lde_PrecoUnitario
	lde_PrecoFinal = lde_PrecoTotal - (lde_PrecoTotal * lde_Desconto / 100)

	// Atualizar o total do pedido
	If Not of_Atualizar_Total_Pedido(ads_Pedido.GetItemNumber(li_For, "idpedido"), lde_PrecoFinal) Then
		Return False
	End If
Next

Return True
end function

public function boolean of_processar_estoque (long al_iditem, long al_quantidade);// Fun$$HEX2$$e700e300$$ENDHEX$$o para verificar e atualizar estoque
If Not of_Verificar_Estoque(al_IdItem, al_Quantidade) Then
	MessageBox("Erro", "Estoque insuficiente para o item: " + String(al_IdItem))
	Return False
End If

If Not of_Atualizar_Estoque(al_IdItem, al_Quantidade) Then
	MessageBox("Erro", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar o estoque para o item: " + String(al_IdItem))
	Return False
End If

Return True
end function

public function decimal of_calcular_desconto (long al_iditem, long al_quantidade);Return 1
end function

public function boolean of_atualizar_total_pedido (long al_idpedido, decimal ade_precofinal);Return True
end function

public function boolean of_verificar_estoque (long al_iditem, long al_quantidade);Return True
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

