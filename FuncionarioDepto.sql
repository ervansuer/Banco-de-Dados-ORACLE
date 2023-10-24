
--------------------------------------------------------------------------------------------------------------------------------

-- Crie o pacote que conterá o procedimento e a função
CREATE OR REPLACE PACKAGE Pacote_Funcionario_Depto AS
  -- Procedimento para listar funcionários e seus departamentos
  PROCEDURE Listar_Funcionarios_Deptos;

  -- Função para incluir um registro de funcionário e departamento
  FUNCTION Incluir_Funcionario_Depto (
    p_nome_funcionario IN VARCHAR2,
    p_salario IN NUMBER,
    p_nome_departamento IN VARCHAR2
  ) RETURN NUMBER;
END Pacote_Funcionario_Depto;
/

-- Agora, vamos implementar o pacote
CREATE OR REPLACE PACKAGE BODY Pacote_Funcionario_Depto AS
  -- Procedimento para listar funcionários e seus departamentos
  PROCEDURE Listar_Funcionarios_Deptos AS
  BEGIN
    FOR funcionario_rec IN (SELECT f.nome AS nome_funcionario, d.nome AS nome_departamento FROM FUNCIONARIO f
                            JOIN DEPTO d ON f.id_departamento = d.id_departamento) LOOP
      DBMS_OUTPUT.PUT_LINE('Funcionário: ' || funcionario_rec.nome_funcionario || ', Departamento: ' || funcionario_rec.nome_departamento);
    END LOOP;
  END;

  -- Função para incluir um registro de funcionário e departamento
  FUNCTION Incluir_Funcionario_Depto (
    p_nome_funcionario IN VARCHAR2,
    p_salario IN NUMBER,
    p_nome_departamento IN VARCHAR2  )
    RETURN NUMBER IS
    v_id_funcionario NUMBER;
  BEGIN
    -- Inserir o funcionário
    INSERT INTO FUNCIONARIO (nome, salario) VALUES (p_nome_funcionario, p_salario)
      RETURNING id_funcionario INTO v_id_funcionario;

    -- Inserir o departamento relacionado ao funcionário
    INSERT INTO DEPTO (id_funcionario, nome) VALUES (v_id_funcionario, p_nome_departamento);

    COMMIT;
    
    RETURN v_id_funcionario;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
      RETURN NULL;
  END;
END Pacote_Funcionario_Depto;
/