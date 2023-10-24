
----------------------------------------------------------------------------------------------------------------------------

-- Crie o pacote que conterá o procedimento e a função
CREATE OR REPLACE PACKAGE Pacote_Pessoa_Profissao AS
  -- Procedimento para listar pessoas e suas profissões
  PROCEDURE Listar_Pessoas_Profissoes;

  -- Função para incluir um registro de pessoa e profissão
  FUNCTION Incluir_Pessoa_Profissao (
    p_nome_pessoa IN VARCHAR2,
    p_idade IN NUMBER,
    p_nome_profissao IN VARCHAR2
  ) RETURN NUMBER;
END Pacote_Pessoa_Profissao;
/

-- Agora, vamos implementar o pacote
CREATE OR REPLACE PACKAGE BODY Pacote_Pessoa_Profissao AS
  -- Procedimento para listar pessoas e suas profissões
  PROCEDURE Listar_Pessoas_Profissoes AS
  BEGIN
    FOR pessoa_rec IN (SELECT p.nome AS nome_pessoa, pr.nome AS nome_profissao
                      FROM PESSOA p
                      JOIN PROFISSAO pr ON p.id_profissao = pr.id_profissao) LOOP
      DBMS_OUTPUT.PUT_LINE('Pessoa: ' || pessoa_rec.nome_pessoa || ', Profissão: ' || pessoa_rec.nome_profissao);
    END LOOP;
  END;

  -- Função para incluir um registro de pessoa e profissão
  FUNCTION Incluir_Pessoa_Profissao (
    p_nome_pessoa IN VARCHAR2,
    p_idade IN NUMBER,
    p_nome_profissao IN VARCHAR2
  ) RETURN NUMBER IS
    v_id_pessoa NUMBER;
  BEGIN
    -- Inserir a pessoa
    INSERT INTO PESSOA (nome, idade) VALUES (p_nome_pessoa, p_idade)
      RETURNING id_pessoa INTO v_id_pessoa;

    -- Inserir a profissão relacionada à pessoa
    INSERT INTO PROFISSAO (id_pessoa, nome) VALUES (v_id_pessoa, p_nome_profissao);

    COMMIT;
    
    RETURN v_id_pessoa;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
      RETURN NULL;
  END;
END Pacote_Pessoa_Profissao;
/