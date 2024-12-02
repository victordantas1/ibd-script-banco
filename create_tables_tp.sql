SET GLOBAL innodb_lock_wait_timeout = 200;

-- Criação do Schema do Banco de Dados
CREATE DATABASE connectme;
USE connectme;

-- Tabela USUARIO
CREATE TABLE USUARIO (
    login_usuario VARCHAR(50) PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL,
    data_hora_registro DATETIME NOT NULL,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(50) NOT NULL
);

CREATE TABLE LOCALIZACAO (
    id_localizacao INT AUTO_INCREMENT PRIMARY KEY,
    rua VARCHAR(50),
    numero INT,
    bairro VARCHAR(50),
    cidade VARCHAR(100),
    estado VARCHAR(100),
    pais VARCHAR(100)
);

-- Tabela PERFIL_USUARIO
CREATE TABLE PERFIL_USUARIO (
    id_perfil INT AUTO_INCREMENT PRIMARY KEY,
    login_usuario VARCHAR(50) NOT NULL,
    nome_exibicao VARCHAR(100),
    biografia TEXT,
    id_localizacao INT,
    path_foto VARCHAR(255),
    FOREIGN KEY (login_usuario) REFERENCES USUARIO(login_usuario),
    FOREIGN KEY (id_localizacao) REFERENCES LOCALIZACAO(id_localizacao)
);

-- Tabela INTERESSE
CREATE TABLE INTERESSE (
    nome VARCHAR(50) PRIMARY KEY
);

-- Tabela PERFIL_INTERESSE
CREATE TABLE PERFIL_INTERESSE (
    id_perfil INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_perfil, nome),
    FOREIGN KEY (id_perfil) REFERENCES PERFIL_USUARIO(id_perfil),
    FOREIGN KEY (nome) REFERENCES INTERESSE(nome)
);

-- Tabela POSTAGEM
CREATE TABLE POSTAGEM (
    id_postagem INT AUTO_INCREMENT PRIMARY KEY,
    data_hora_publicacao DATETIME NOT NULL,
    descricao TEXT,
    qtd_comentario INT DEFAULT 0,
    qtd_curtidas INT DEFAULT 0
);

-- Tabela POSTAGEM_PERFIL
CREATE TABLE POSTAGEM_PERFIL (
    id_postagem INT NOT NULL,
    id_perfil INT NOT NULL,
    PRIMARY KEY (id_postagem),
    FOREIGN KEY (id_postagem) REFERENCES POSTAGEM(id_postagem),
    FOREIGN KEY (id_perfil) REFERENCES PERFIL_USUARIO(id_perfil)
);

-- Tabela GRUPO
CREATE TABLE GRUPO (
    id_grupo INT AUTO_INCREMENT PRIMARY KEY,
    descricao TEXT,
    nome VARCHAR(50) NOT NULL
);

-- Tabela POSTAGEM_GRUPO
CREATE TABLE POSTAGEM_GRUPO (
    id_postagem INT NOT NULL,
    id_grupo INT NOT NULL,
    PRIMARY KEY (id_postagem),
    FOREIGN KEY (id_postagem) REFERENCES POSTAGEM(id_postagem),
    FOREIGN KEY (id_grupo) REFERENCES GRUPO(id_grupo)
);

-- Tabela MIDIA
CREATE TABLE MIDIA (
    id_midia INT AUTO_INCREMENT PRIMARY KEY,
    id_postagem INT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    path_midia VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_postagem) REFERENCES POSTAGEM(id_postagem)
);

-- Tabela CURTIDA
CREATE TABLE CURTIDA (
    id_interacao INT AUTO_INCREMENT PRIMARY KEY,
    id_postagem INT NOT NULL,
    id_perfil INT NOT NULL,
    data_hora_interacao DATETIME NOT NULL,
    FOREIGN KEY (id_postagem) REFERENCES POSTAGEM(id_postagem),
    FOREIGN KEY (id_perfil) REFERENCES PERFIL_USUARIO(id_perfil)
);

-- Tabela COMENTARIO
CREATE TABLE COMENTARIO (
    id_interacao INT AUTO_INCREMENT PRIMARY KEY,
    id_postagem INT NOT NULL,
    id_perfil INT NOT NULL,
    data_hora_interacao DATETIME NOT NULL,
    texto TEXT NOT NULL,
    FOREIGN KEY (id_postagem) REFERENCES POSTAGEM(id_postagem),
    FOREIGN KEY (id_perfil) REFERENCES PERFIL_USUARIO(id_perfil)
);

-- Tabela MENSAGEM_INDIVIDUAL
CREATE TABLE MENSAGEM_INDIVIDUAL (
    id_mensagem INT AUTO_INCREMENT PRIMARY KEY,
    id_perfil_remetente INT NOT NULL,
    id_perfil_destinatario INT NOT NULL,
    data_hora_mensagem DATETIME NOT NULL,
    texto TEXT NOT NULL,
    FOREIGN KEY (id_perfil_remetente) REFERENCES PERFIL_USUARIO(id_perfil),
    FOREIGN KEY (id_perfil_destinatario) REFERENCES PERFIL_USUARIO(id_perfil)
);

-- Tabela MENSAGEM_GRUPO
CREATE TABLE MENSAGEM_GRUPO (
    id_mensagem INT AUTO_INCREMENT PRIMARY KEY,
    id_grupo INT NOT NULL,
    id_perfil_remetente INT NOT NULL,
    data_hora_mensagem DATETIME NOT NULL,
    texto TEXT NOT NULL,
    FOREIGN KEY (id_perfil_remetente) REFERENCES PERFIL_USUARIO(id_perfil),
    FOREIGN KEY (id_grupo) REFERENCES GRUPO(id_grupo)
);