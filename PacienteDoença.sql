
------------------------------------------------------------------------------------------------------------------------------
-- Crie o pacote que conterá o procedimento e a função
CREATE OR REPLACE PACKAGE Pacote_Paciente_Doenca AS
  -- Procedimento para listar pacientes e suas doenças
  PROCEDURE Listar_Pacientes_Doenças;

  -- Função para incluir um registro de paciente e doença
  FUNCTION Incluir_Paciente_Doenca (
    p_nome_paciente IN VARCHAR2,
    p_idade IN NUMBER,
    p_nome_doenca IN VARCHAR2
  ) RETURN NUMBER;
END Pacote_Paciente_Doenca;
/

-- Agora, vamos implementar o pacote
CREATE OR REPLACE PACKAGE BODY Pacote_Paciente_Doenca AS
  -- Procedimento para listar pacientes e suas doenças
  PROCEDURE Listar_Pacientes_Doenças AS
  BEGIN
    FOR paciente_rec IN (SELECT p.nome AS nome_paciente, d.nome AS nome_doenca
                         FROM PACIENTE p
                         JOIN DOENCA d ON p.id_paciente = d.id_paciente) LOOP
      DBMS_OUTPUT.PUT_LINE('Paciente: ' || paciente_rec.nome_paciente || ', Doença: ' || paciente_rec.nome_doenca);
    END LOOP;
  END;

  -- Função para incluir um registro de paciente e doença
  FUNCTION Incluir_Paciente_Doenca (
    p_nome_paciente IN VARCHAR2,
    p_idade IN NUMBER,
    p_nome_doenca IN VARCHAR2
  ) RETURN NUMBER IS
    v_id_paciente NUMBER;
  BEGIN
    -- Inserir o paciente
    INSERT INTO PACIENTE (nome, idade) VALUES (p_nome_paciente, p_idade)
      RETURNING id_paciente INTO v_id_paciente;

    -- Inserir a doença relacionada ao paciente
    INSERT INTO DOENCA (id_paciente, nome) VALUES (v_id_paciente, p_nome_doenca);

    COMMIT;
    
    RETURN v_id_paciente;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
      RETURN NULL;
  END;
END Pacote_Paciente_Doenca;
/