USE connectme;

-- 1. Primeira Consulta
SELECT * FROM perfil_usuario;

-- 2. Seleciona uma lista de amigos de um usuario
SELECT usuario.id_perfil, usuario.login_usuario, amigo.*
FROM perfil_usuario AS usuario
JOIN conexao
    ON usuario.id_perfil = conexao.id_perfil1
JOIN perfil_usuario AS amigo
    ON conexao.id_perfil2 = amigo.id_perfil
WHERE usuario.id_perfil = 2;

-- 3. Consultar as postagens de um usuario
SELECT
    p.id_postagem,
    p.data_hora_publicacao,
    p.descricao,
    p.qtd_comentario,
    p.qtd_curtidas,
    login_usuario
FROM
postagem AS p
JOIN postagem_perfil AS pp
    ON p.id_postagem = pp.id_postagem
JOIN postagem_grupo AS pg
    ON p.id_postagem = pg.id_postagem
JOIN perfil_usuario AS perfil
    ON pg.id_perfil = perfil.id_perfil
WHERE perfil.id_perfil= 501
ORDER BY p.data_hora_publicacao DESC;

-- 4. Listar as postagens mais recentes de um grupo
SELECT *
FROM grupo g
JOIN postagem_grupo pg
    ON  g.id_grupo = pg.id_grupo
JOIN postagem p
    ON pg.id_postagem = p.id_postagem
WHERE g.id_grupo = 143
ORDER BY p.data_hora_publicacao DESC;

-- 5. Listar 10 mensagens privadas trocadas entre dois usuarios
SELECT *
FROM mensagem_individual m
WHERE m.id_perfil_remetente = 1 AND m.id_perfil_destinatario = 2
ORDER BY m.data_hora_mensagem DESC
LIMIT 10;

-- 6. Buscar os usuarios por uma string de entrada
SELECT *
FROM perfil_usuario AS p
WHERE p.nome_exibicao LIKE "%Miranda%";

-- 7. Listar o id dos posts com mais interacoes nos ultimos 7 dias
SELECT id_postagem
FROM postagem
WHERE data_hora_publicacao >= NOW() - INTERVAL 7 DAY
ORDER BY (qtd_curtidas + qtd_comentario) DESC
LIMIT 5;

-- 8. Dado um post de um usuário, fazer a contagem de quantos usuários interagiram com ele nos últimos 7 dias.
SELECT  p.id_postagem, COUNT(DISTINCT c.id_perfil) + COUNT(DISTINCT c2.id_perfil) AS interacos
FROM postagem AS p
LEFT JOIN postagem_perfil pp
    ON p.id_postagem = pp.id_postagem
LEFT JOIN postagem_grupo pg
    ON p.id_postagem = pg.id_postagem
LEFT JOIN curtida c
    ON p.id_postagem = c.id_postagem
LEFT JOIN comentario c2
    ON p.id_postagem = c2.id_postagem
LEFT JOIN perfil_usuario pu
        ON pu.id_perfil = pp.id_perfil
WHERE pu.id_perfil = 123 AND p.id_postagem = 2439
AND c.data_hora_interacao >= DATE('2024-12-03 00:00:00') - INTERVAL 7 DAY
AND c2.data_hora_interacao >= DATE('2024-12-03 00:00:00') - INTERVAL 7 DAY
GROUP BY p.id_postagem;

