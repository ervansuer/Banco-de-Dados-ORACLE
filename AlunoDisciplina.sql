
-----------------------------------------------------------------------------------------------------------------

-- Cria o pacote que conterá o procedimento e a função
CREATE OR REPLACE PACKAGE Pacote_Aluno_Disciplina AS
  -- Procedimento para listar alunos e suas disciplinas
  PROCEDURE Listar_Alunos_Disciplinas;

  -- Função para incluir um registro de aluno e disciplina
  FUNCTION Incluir_Aluno_Disciplina (
    p_nome_aluno IN VARCHAR2,
    p_matricula IN NUMBER,
    p_nome_disciplina IN VARCHAR2
  ) RETURN NUMBER;
END Pacote_Aluno_Disciplina;
/

-- Agora, vamos implementar o pacote
CREATE OR REPLACE PACKAGE BODY Pacote_Aluno_Disciplina AS
  -- Procedimento para listar alunos e suas disciplinas
  PROCEDURE Listar_Alunos_Disciplinas AS
  BEGIN
    FOR aluno_rec IN (SELECT a.nome AS nome_aluno, d.nome AS nome_disciplina
                      FROM ALUNO a
                      JOIN DISCIPLINA d ON a.id_aluno = d.id_aluno) LOOP
      DBMS_OUTPUT.PUT_LINE('Aluno: ' || aluno_rec.nome_aluno || ', Disciplina: ' || aluno_rec.nome_disciplina);
    END LOOP;
  END;

  -- Função para incluir um registro de aluno e disciplina
  FUNCTION Incluir_Aluno_Disciplina (
    p_nome_aluno IN VARCHAR2,
    p_matricula IN NUMBER,
    p_nome_disciplina IN VARCHAR2
  ) RETURN NUMBER IS
    v_id_aluno NUMBER;
  BEGIN
    -- Inserir o aluno
    INSERT INTO ALUNO (nome, matricula) VALUES (p_nome_aluno, p_matricula)
      RETURNING id_aluno INTO v_id_aluno;

    -- Inserir a disciplina relacionada ao aluno
    INSERT INTO DISCIPLINA (id_aluno, nome) VALUES (v_id_aluno, p_nome_disciplina);

    COMMIT;
    
    RETURN v_id_aluno;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
      RETURN NULL;
  END;
END Pacote_Aluno_Disciplina;
/
