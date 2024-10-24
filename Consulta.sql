
-- 1- Função dos músicos, data de nascimento, nome e instrumento favorito:

SELECT msc.nome AS 'Nome do Músico', 
       DATE_FORMAT(msc.dt_nascimento, "%d/%m/%Y") AS 'Data de Nascimento',
       TIMESTAMPDIFF(YEAR, msc.dt_nascimento, NOW()) AS "Idade", 
       msc.Instrumento_Fav AS 'Instrumento Favorito', 
       msc.nacionalidade AS 'Nacionalidade', 
       func.funcao AS 'Função', 
       inst.nome AS 'Instrumento do Músico'
FROM musicos msc
INNER JOIN participa prt ON prt.Musicos_idMusicos = msc.idMusicos
INNER JOIN instrumentos inst ON inst.idInstrumentos = prt.Instrumentos_idInstrumentos
INNER JOIN funcao_musicos func ON func.idfunca = prt.funcao_musicos_idfunca
ORDER BY msc.nome;

-- 2 - Músicos que vão se apresentar na Sinfonia 40:

SELECT msc.nome AS "Nome do Músico", 
       DATE_FORMAT(msc.dt_nascimento, "%d/%m/%Y") AS 'Data de Nascimento',
       TIMESTAMPDIFF(YEAR, msc.dt_nascimento, NOW()) AS "Idade", 
       msc.Instrumento_Fav AS 'Instrumento Favorito', 
       msc.nacionalidade AS 'Nacionalidade', 
       sinf.nome AS 'Sinfonia', 
       inst.nome AS 'Instrumento', 
       inst.categoria AS 'Categoria'
FROM musicos msc
INNER JOIN participa prt ON prt.Musicos_idMusicos = msc.idMusicos
INNER JOIN sinfonia sinf ON sinf.idSinfonia = prt.Sinfonia_idSinfonia
INNER JOIN instrumentos inst ON inst.idInstrumentos = prt.Instrumentos_idInstrumentos
WHERE sinf.nome LIKE "Sinfonia No. 40"
ORDER BY msc.nome;


-- 3 - Orquestra e local de apresentação:

SELECT orq.nome AS 'Nome da Orquestra', 
       orq.cidade AS 'Local de Apresentação', 
       orq.pais AS 'País', 
       sinf.nome AS 'Sinfonia',
       apt.loca_da_apresentacao "Local da Apresentação"
FROM orquestra orq
INNER JOIN sinfonia sinf ON sinf.Orquestra_idOrquestra = orq.idOrquestra
inner join apresentacoes apt on apt.Orquestra_idOrquestra = orq.idOrquestra
ORDER BY orq.nome;


-- 4 - Maestros das orquestras e a data do evento:

SELECT orq.nome AS 'Nome da Orquestra', 
       fmsc.funcao AS 'Função', 
       msc.nome AS 'Nome do Maestro', 
       orq.cidade AS 'Local de Apresentação', 
       DATE_FORMAT(orq.Data_Apres, "%d/%m/%Y") AS 'Data do Evento'
FROM orquestra orq
INNER JOIN musicos msc ON msc.Orquestra_idOrquestra = orq.idOrquestra
INNER JOIN participa prt ON prt.Musicos_idMusicos = msc.idMusicos
INNER JOIN funcao_musicos fmsc ON fmsc.idfunca = prt.funcao_musicos_idfunca
WHERE fmsc.funcao LIKE "Maestro"
ORDER BY DATE_FORMAT(orq.Data_Apres, "%d/%m/%Y");


-- 5 - Data de criação da sinfonia, duração e local de apresentação:

SELECT sinf.nome AS "Nome da Sinfonia", 
       sinf.duracao AS "Duração", 
       DATE_FORMAT(sinf.dt_criacao, "%d/%m/%Y") AS 'Data de Criação', 
       sinf.compositor AS 'Compositor', 
       orq.nome AS "Local de Apresentação"
FROM sinfonia sinf
INNER JOIN orquestra orq ON sinf.Orquestra_idOrquestra = orq.idOrquestra
WHERE sinf.dt_criacao BETWEEN "1824-05-07" AND "1893-10-28";


-- 6 - Músicos Brasileiros e suas Orquestras:

SELECT msc.nome AS "Músico", DATE_FORMAT(msc.dt_nascimento, "%d/%m/%Y") AS "Data de Nascimento", 
       TIMESTAMPDIFF(YEAR, msc.dt_nascimento, NOW()) AS "Idade", msc.nacionalidade AS "Nacionalidade",
       orq.nome AS "Orquestra"
FROM musicos msc
INNER JOIN orquestra orq ON msc.Orquestra_idOrquestra = orq.idOrquestra
WHERE msc.nacionalidade LIKE "Brasil%"
ORDER BY msc.nome;


-- 7 - Última e Próxima Apresentação:

SELECT orq.nome AS "Orquestra", DATE_FORMAT(orq.Ultima_Apres, "%d/%m/%Y") AS "Última Apresentação", 
       DATE_FORMAT(orq.Data_Apres, "%d/%m/%Y") AS "Próxima Apresentação", 
       msc.nome AS "Músico", fmsc.funcao AS "Função"
FROM orquestra orq
INNER JOIN musicos msc ON msc.Orquestra_idOrquestra = orq.idOrquestra
INNER JOIN participa prt ON prt.Musicos_idMusicos = msc.idMusicos
INNER JOIN funcao_musicos fmsc ON fmsc.idfunca = prt.funcao_musicos_idfunca
WHERE fmsc.funcao LIKE "Maestro"
ORDER BY msc.nome;


-- 8 - Instrumentos, Categorias e Músicos:

SELECT inst.marca AS "Marca", inst.nome AS "Instrumento", inst.categoria AS "Categoria", 
       msc.nome AS "Músico"
FROM instrumentos inst
INNER JOIN participa part ON part.Instrumentos_idInstrumentos = inst.idInstrumentos
INNER JOIN musicos msc ON msc.idMusicos = part.Musicos_idMusicos
ORDER BY msc.nome;

-- 9 - Duração de Orquestras:

SELECT orq.nome AS "Orquestra", COUNT(sinf.idSinfonia) AS "Número de Sinfonias", 
       SEC_TO_TIME(SUM(TIME_TO_SEC(sinf.duracao))) AS "Duração Total"
FROM orquestra orq
INNER JOIN sinfonia sinf ON sinf.Orquestra_idOrquestra = orq.idOrquestra
GROUP BY orq.nome
ORDER BY orq.nome;


-- 10 - Músicas Femininas e Experiência:

CREATE VIEW MusicasFemininas AS
SELECT msc.nome AS "Música", TIMESTAMPDIFF(YEAR, msc.dt_nascimento, NOW()) AS "Idade", 
       msc.sexo AS "Gênero", msc.experiencia AS "Experiência", orq.nome AS "Orquestra"
FROM musicos msc
INNER JOIN orquestra orq ON msc.Orquestra_idOrquestra = orq.idOrquestra
WHERE msc.sexo LIKE "F"
ORDER BY msc.experiencia;


-- 11 - Músicos da Orquestra de São Paulo:

CREATE VIEW MusicosOrqSaoPaulo AS
SELECT msc.nome AS "Músico", orq.nome AS "Orquestra", 
       COUNT(DISTINCT part.Sinfonia_idSinfonia) AS "Participações"
FROM participa part
INNER JOIN musicos msc ON part.Musicos_idMusicos = msc.idMusicos
INNER JOIN orquestra orq ON msc.Orquestra_idOrquestra = orq.idOrquestra
WHERE orq.nome LIKE "Orquestra Sinfônica Nacional do Brasil"
GROUP BY msc.nome, orq.nome
ORDER BY COUNT(DISTINCT part.Sinfonia_idSinfonia) DESC;


-- 12 - Instrumentos Mais Usados e Quantidade de Músicos:

CREATE VIEW InstrumentosEQuantidades AS
SELECT orq.nome AS "Orquestra", inst.nome AS "Instrumento", 
       COUNT(part.Instrumentos_idInstrumentos) AS "Instrumentos Usados", 
       COUNT(part.Musicos_idMusicos) AS "Número de Músicos"
FROM participa part
INNER JOIN instrumentos inst ON part.Instrumentos_idInstrumentos = inst.idInstrumentos
INNER JOIN musicos msc ON part.Musicos_idMusicos = msc.idMusicos
INNER JOIN orquestra orq ON msc.Orquestra_idOrquestra = orq.idOrquestra
GROUP BY orq.nome, inst.nome
ORDER BY orq.nome;


-- 13 - Categorias de Instrumentos nas Sinfonias:


CREATE VIEW CategoriasESinfonias AS
SELECT sinf.nome AS "Sinfonia", inst.categoria AS "Categoria de Instrumento", inst.marca AS "Marca", 
       COUNT(part.Instrumentos_idInstrumentos) AS "Quantidade"
FROM participa part
INNER JOIN instrumentos inst ON part.Instrumentos_idInstrumentos = inst.idInstrumentos
INNER JOIN sinfonia sinf ON part.Sinfonia_idSinfonia = sinf.idSinfonia
GROUP BY inst.categoria, sinf.nome, inst.marca
ORDER BY COUNT(part.Instrumentos_idInstrumentos) DESC;


-- 14 - Duração das Apresentações:

CREATE VIEW DiasApresentacao AS
SELECT orq.nome AS "Orquestra", DATE_FORMAT(orq.Data_Apres, "%d/%m/%Y") AS "Início", 
       DATE_FORMAT(orq.Final_Apres, "%d/%m/%Y") AS "Fim", 
       DATEDIFF(orq.Data_Apres, orq.Final_Apres) AS "Duração (Dias)", 
       COUNT(sinf.Orquestra_idOrquestra) AS "Sinfonias"
FROM sinfonia sinf
INNER JOIN orquestra orq ON sinf.Orquestra_idOrquestra = orq.idOrquestra
GROUP BY orq.nome, orq.Data_Apres, orq.Final_Apres
ORDER BY DATEDIFF(orq.Final_Apres, orq.Data_Apres) DESC;


-- 15 - Funções e Quantidade de Músicos Brasileiros:

CREATE VIEW FuncoesBrasileiros AS
SELECT fmscs.funcao AS "Função", msc.nacionalidade AS "Nacionalidade", 
       COUNT(DISTINCT msc.idMusicos) AS "Número de Músicos"
FROM participa part
INNER JOIN musicos msc ON part.Musicos_idMusicos = msc.idMusicos
INNER JOIN funcao_musicos fmscs ON part.funcao_musicos_idfunca= fmscs.idfunca
WHERE msc.nacionalidade LIKE "Brasil%"
GROUP BY fmscs.funcao, msc.nacionalidade
ORDER BY COUNT(msc.idMusicos) DESC;


-- 16 - Maestros e Seus Instrumentos Favoritos:

CREATE VIEW MaestrosEInstrumentos AS
SELECT msc.nome AS "Maestro", sinf.nome AS "Sinfonia", msc.nacionalidade AS "Nacionalidade", 
       msc.experiencia AS "Experiência", msc.Instrumento_Fav AS "Instrumento Favorito"
FROM participa part
INNER JOIN musicos msc ON part.Musicos_idMusicos = msc.idMusicos
INNER JOIN funcao_musicos fmsc ON part.funcao_musicos_idfunca = fmsc.idfunca
INNER JOIN sinfonia sinf ON part.Sinfonia_idSinfonia = sinf.idSinfonia
WHERE fmsc.funcao = "Maestro"
ORDER BY msc.nome;


-- 17 - Diversidade de Instrumentos nas Orquestras:

SELECT orq.nome AS "Orquestra", COUNT(DISTINCT inst.categoria) AS "Diversidade de Instrumentos"
FROM participa part
INNER JOIN instrumentos inst ON part.Instrumentos_idInstrumentos = inst.idInstrumentos
INNER JOIN musicos msc ON part.Musicos_idMusicos = msc.idMusicos
INNER JOIN orquestra orq ON msc.Orquestra_idOrquestra = orq.idOrquestra
GROUP BY orq.nome;



-- 18 - Músicos, Orquestras e Instrumentos:

CREATE VIEW MusicosOrquestrasInstrumentos AS
SELECT msc.nome AS "Músico", orq.nome AS "Orquestra", msc.experiencia AS "Experiência", 
       inst.nome AS "Instrumento"
FROM participa part
INNER JOIN instrumentos inst ON part.Instrumentos_idInstrumentos = inst.idInstrumentos
INNER JOIN musicos msc ON part.Musicos_idMusicos = msc.idMusicos
INNER JOIN orquestra orq ON msc.Orquestra_idOrquestra = orq.idOrquestra
ORDER BY msc.experiencia DESC;


-- 19 - Sinfonias e Seus Compositores:

CREATE VIEW SinfoniasECompositores AS
SELECT sinf.nome AS "Sinfonia", DATE_FORMAT(sinf.dt_criacao, "%d/%m/%Y") AS "Data de Criação", 
       sinf.nome AS "Compositor",  orq.nome "Nome da Orquestra"
FROM sinfonia sinf
INNER JOIN orquestra orq ON sinf.orquestra_idOrquestra = orq.idOrquestra
ORDER BY sinf.nome;


-- 20 - Orquestras e Seus Músicos Maestros:

create view orquestraeseusmusicosmaetros as
SELECT orq.nome AS "Orquestra", msc.nome AS "Músico", fmscs.funcao AS "Função"
FROM participa part
INNER JOIN musicos msc ON part.Musicos_idMusicos = msc.idMusicos
inner join orquestra orq on msc.Orquestra_idOrquestra = orq.idOrquestra
INNER JOIN funcao_musicos fmscs ON part.funcao_musicos_idfunca= fmscs.idfunca




