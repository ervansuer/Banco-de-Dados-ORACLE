
-------------------------------------------------------------------------------------------------------------------------------

-- Crie o pacote que conterá o procedimento e a função
CREATE OR REPLACE PACKAGE Pacote_Item_Preco AS
  -- Procedimento para listar itens e seus preços
  PROCEDURE Listar_Itens_Precos;

  -- Função para incluir um registro de item e preço
  FUNCTION Incluir_Item_Preco (
    p_nome_item IN VARCHAR2,
    p_descricao IN VARCHAR2,
    p_valor NUMBER
  ) RETURN NUMBER;
END Pacote_Item_Preco;
/

-- Agora, vamos implementar o pacote
CREATE OR REPLACE PACKAGE BODY Pacote_Item_Preco AS
  -- Procedimento para listar itens e seus preços
  PROCEDURE Listar_Itens_Precos AS
  BEGIN
    FOR item_rec IN (SELECT i.nome AS nome_item, p.descricao AS descricao, p.valor AS valor
                     FROM ITEM i
                     JOIN PRECO p ON i.id_item = p.id_item) LOOP
      DBMS_OUTPUT.PUT_LINE('Item: ' || item_rec.nome_item || ', Descrição: ' || item_rec.descricao || ', Valor: ' || item_rec.valor);
    END LOOP;
  END;

  -- Função para incluir um registro de item e preço
  FUNCTION Incluir_Item_Preco (
    p_nome_item IN VARCHAR2,
    p_descricao IN VARCHAR2,
    p_valor NUMBER
  ) RETURN NUMBER IS
    v_id_item NUMBER;
  BEGIN
    -- Inserir o item
    INSERT INTO ITEM (nome, descricao) VALUES (p_nome_item, p_descricao)
      RETURNING id_item INTO v_id_item;

    -- Inserir o preço relacionado ao item
    INSERT INTO PRECO (id_item, valor) VALUES (v_id_item, p_valor);

    COMMIT;
    
    RETURN v_id_item;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
      RETURN NULL;
  END;
END Pacote_Item_Preco;
/