// Qual foi o jogador que mais fez gol em uma única partida?
MATCH (j:Jogador)-[f:FEZ_GOL]->(p:Partida)
WITH j, p, count(f) as gols
ORDER BY gols DESC
LIMIT 1
MATCH (j)-[:ELENCO_DE]->(t:Time)-[:MANDANTE|VISITANTE]->(p)
RETURN j, t, p, gols


// Quais foram os times que mais se enfrentaram na história do campeonato brasileiro?
MATCH (t1:Time)-[:MANDANTE|VISITANTE]->(p:Partida)<-[:MANDANTE|VISITANTE]-(t2:Time)
WHERE t1.nome < t2.nome
WITH t1, t2, count(p) as partidas
ORDER BY partidas DESC
LIMIT 6
WITH COLLECT({t1: t1, t2: t2, partidas: partidas}) AS dados
UNWIND dados AS dadosRelacao
MERGE (t1:Time {nome: dadosRelacao.t1.nome})-[r:SE_ENFRENTOU]->(t2:Time {nome: dadosRelacao.t2.nome})
SET r.partidas = dadosRelacao.partidas
RETURN t1, t2, r


// Quais foram os 3 jogadores que mais fizeram gols na história do campeonato brasileiro?
MATCH (j:Jogador)-[fezGol:FEZ_GOL]->(p:Partida)
WITH j, COUNT(fezGol) AS gols, COLLECT({relacao: fezGol, partida: p}) AS relacoesFezGol
ORDER BY gols DESC
LIMIT 3
RETURN j, gols, relacoesFezGol


// Qual jogador que jogou mais partidas pelo Palmeiras? Quantas?
MATCH (jogador:Jogador)-[:ELENCO_DE]->(time:Time {nome: "Palmeiras"})-[:MANDANTE|VISITANTE]->(partida:Partida)
RETURN jogador, time, COUNT(*) AS TotalPartidas
ORDER BY TotalPartidas DESC
LIMIT 1


// Qual o total do gols feitos no ano de 2018?
MATCH (jogador:Jogador)-[:FEZ_GOL]->(partida:Partida)
WHERE split(partida.data, '/')[2] = "2018"
RETURN jogador, partida


// Qual foi o jogador que mais fez gol pelo Vasco?
MATCH (jogador:Jogador)-[:FEZ_GOL]->(partida:Partida)
WHERE (jogador)-[:ELENCO_DE]->(:Time {nome: "Vasco"})
WITH jogador, COUNT(*) AS TotalGols
ORDER BY TotalGols DESC
LIMIT 1
MATCH (jogador)-[:FEZ_GOL]->(partida)
RETURN jogador, partida, TotalGols


// Quais jogadores mais trocaram de time ao longo dos anos e quais são esses times?
MATCH (jogador:Jogador)-[:ELENCO_DE]->(time:Time)
WITH jogador, COLLECT(DISTINCT time) AS times
WHERE SIZE(times) > 0
RETURN jogador, REDUCE(s = [], t IN times | s + t) AS ConexoesElenco
ORDER BY SIZE(times) DESC
LIMIT 1


// Todos os jogadores que ja passaram pelo Fluminense e quais anos eles ficaram no clube
MATCH (jogador:Jogador)-[rel:ELENCO_DE]->(time:Time {nome: "Fluminense"})
RETURN jogador, rel, time


//Quais foram os 5 jogadores que mais fizeram gols pelo Fluminense? Quantos gols eles fizeram?
MATCH (jogador:Jogador)-[fezGol:FEZ_GOL]->(partida:Partida)
WHERE (jogador)-[:ELENCO_DE]->(:Time {nome: "Fluminense"})
WITH jogador, COUNT(*) AS TotalGols, COLLECT({relacao: fezGol, partida: partida}) AS relacoesFezGol
ORDER BY TotalGols DESC
LIMIT 5
RETURN jogador, TotalGols, relacoesFezGol


//Qual jogador mais fez gols em times diferentes na sua carreira?
MATCH (j:Jogador)-[:FEZ_GOL]->(p:Partida), (j)-[:ELENCO_DE]->(t:Time)
WHERE (t)-[:MANDANTE|VISITANTE]->(p)
WITH j, COUNT(DISTINCT t) AS times, COLLECT(t) as times_jogados
ORDER BY times DESC
LIMIT 1
RETURN j, times, times_jogados
