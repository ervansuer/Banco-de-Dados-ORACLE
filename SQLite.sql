-- Criar tabela ALUNO
CREATE TABLE ALUNO (
    id_aluno NUMBER,
    matricula NUMBER,
    nome VARCHAR2(100),
    PRIMARY KEY (id_aluno)
);

-- Criar tabela DISCIPLINA
CREATE TABLE DISCIPLINA (
    id_disciplina NUMBER,
    id_aluno NUMBER,
    nome VARCHAR2(100),
    FOREIGN KEY (id_aluno) REFERENCES ALUNO(id_aluno)
);

-- Criar tabela FUNCIONARIO
CREATE TABLE FUNCIONARIO (
    id_funcionario NUMBER,
    salario NUMBER,
    nome VARCHAR2(100),
    PRIMARY KEY (id_funcionario)
);

-- Criar tabela DEPTO
CREATE TABLE DEPTO (
    id_funcionario NUMBER,
    nome VARCHAR2(100),
    FOREIGN KEY (id_funcionario) REFERENCES FUNCIONARIO(id_funcionario)
);

-- Criar tabela PACIENTE
CREATE TABLE PACIENTE (
    id_paciente NUMBER,
    idade NUMBER,
    nome VARCHAR2(100),
    PRIMARY KEY (id_paciente)
);

-- Criar tabela DOENCA
CREATE TABLE DOENCA (
    id_paciente NUMBER,
    nome VARCHAR2(100),
    FOREIGN KEY (id_paciente) REFERENCES PACIENTE(id_paciente)
);

-- Criar tabela TRATAMENTO
CREATE TABLE TRATAMENTO (
    id_paciente NUMBER,
    nome VARCHAR2(100),
    FOREIGN KEY (id_paciente) REFERENCES PACIENTE(id_paciente)
);

-- Criar tabela PESSOA
CREATE TABLE PESSOA (
    id_pessoa NUMBER,
    idade NUMBER,
    nome VARCHAR2(100),
    PRIMARY KEY (id_pessoa)
);

-- Criar tabela PROFISSAO
CREATE TABLE PROFISSAO (
    id_pessoa NUMBER,
    nome VARCHAR2(100),
    FOREIGN KEY (id_pessoa) REFERENCES PESSOA(id_pessoa)
);

-- Criar tabela ITEM
CREATE TABLE ITEM (
    id_item NUMBER,
    descricao VARCHAR2(100),
    nome VARCHAR2(100),
    PRIMARY KEY (id_item)
);

-- Criar tabela PRECO
CREATE TABLE PRECO (
    id_item NUMBER,
    valor NUMBER,
    FOREIGN KEY (id_item) REFERENCES ITEM(id_item)
);
