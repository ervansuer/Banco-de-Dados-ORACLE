
--------------------------------------------------------------------------------------------------------------------------

-- Crie o pacote que conterá o procedimento e a função
CREATE OR REPLACE PACKAGE Pacote_Paciente_Tratamento AS
  -- Procedimento para listar pacientes e seus tratamentos
  PROCEDURE Listar_Pacientes_Tratamentos;

  -- Função para incluir um registro de paciente e tratamento
  FUNCTION Incluir_Paciente_Tratamento (
    p_nome_paciente IN VARCHAR2,
    p_idade IN NUMBER,
    p_nome_tratamento IN VARCHAR2
  ) RETURN NUMBER;
END Pacote_Paciente_Tratamento;
/

-- Agora, vamos implementar o pacote
CREATE OR REPLACE PACKAGE BODY Pacote_Paciente_Tratamento AS
  -- Procedimento para listar pacientes e seus tratamentos
  PROCEDURE Listar_Pacientes_Tratamentos AS
  BEGIN
    FOR paciente_rec IN (SELECT p.nome AS nome_paciente, t.nome AS nome_tratamento
                         FROM PACIENTE p
                         JOIN TRATAMENTO t ON p.id_paciente = t.id_paciente) LOOP
      DBMS_OUTPUT.PUT_LINE('Paciente: ' || paciente_rec.nome_paciente || ', Tratamento: ' || paciente_rec.nome_tratamento);
    END LOOP;
  END;

  -- Função para incluir um registro de paciente e tratamento
  FUNCTION Incluir_Paciente_Tratamento (
    p_nome_paciente IN VARCHAR2,
    p_idade IN NUMBER,
    p_nome_tratamento IN VARCHAR2
  ) RETURN NUMBER IS
    v_id_paciente NUMBER;
  BEGIN
    -- Inserir o paciente
    INSERT INTO PACIENTE (nome, idade) VALUES (p_nome_paciente, p_idade)
      RETURNING id_paciente INTO v_id_paciente;

    -- Inserir o tratamento relacionado ao paciente
    INSERT INTO TRATAMENTO (id_paciente, nome) VALUES (v_id_paciente, p_nome_tratamento);

    COMMIT;
    
    RETURN v_id_paciente;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
      RETURN NULL;
  END;
END Pacote_Paciente_Tratamento;
/