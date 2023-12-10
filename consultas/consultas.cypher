// Qual foi o jogador que mais fez gol em uma única partida
MATCH (j:Jogador)-[f:FEZ_GOL]->(p:Partida)
WITH j, p, count(f) as gols
ORDER BY gols DESC
LIMIT 1
MATCH (j)-[:ELENCO_DE]->(t:Time)-[:MANDANTE|VISITANTE]->(p)
RETURN j.nome, t.nome, p.id_partida, p.data, p.placar, gols


// Este código vai retornar apenas os 20 primeiros pares de times que mais se enfrentaram ao longo dos anos, com o número de partidas que eles jogaram

MATCH (t1:Time)-[:MANDANTE|VISITANTE]->(p:Partida)<-[:MANDANTE|VISITANTE]-(t2:Time)
WHERE t1.nome < t2.nome
WITH t1, t2, count(p) as partidas
ORDER BY partidas DESC
LIMIT 20
RETURN t1.nome, t2.nome, partidas


// Este código vai retornar os 10 jogadores que fizeram mais gols, com o nome, a posição e o número de gols

MATCH (j:Jogador)-[f:FEZ_GOL]->(p:Partida)
WITH j, count(f) as gols
ORDER BY gols DESC
LIMIT 10
RETURN j.nome, gols


// Qual jogador que jogou mais partidas pelo Palmeiras? Quantas?

MATCH (jogador:Jogador)-[:ELENCO_DE]->(:Time {nome: "Palmeiras"})
RETURN jogador.nome AS Jogador, COUNT(*) AS TotalPartidas
ORDER BY TotalPartidas DESC
LIMIT 1


// Qual o total do gols feitos no ano de 2018?

MATCH (:Jogador)-[:FEZ_GOL]->(partida:Partida)
WHERE split(partida.data, '/')[2] = "2018"
RETURN "O número total de gols marcados em 2018 foi " + COUNT(*) AS TotalGols2018


// Quais foram os 10 jogadores que fez mais fizeram gols pelo Fluminense? Quantos gols eles fizeram?

MATCH (jogador:Jogador)-[:FEZ_GOL]->(:Partida)
WHERE (jogador)-[:ELENCO_DE]->(:Time {nome: "Fluminense"})
RETURN jogador.nome AS Jogador, COUNT(*) AS TotalGols
ORDER BY TotalGols DESC
LIMIT 10


// Quais jogadores mais trocaram de time ao longo dos anos e quais são esses times?

MATCH (jogador:Jogador)-[:ELENCO_DE]->(time:Time)
WITH jogador, COLLECT(DISTINCT time.nome) AS times
RETURN jogador.nome AS Jogador, times
ORDER BY SIZE(times) DESC
LIMIT 5


// Todos os jogadores que ja passaram pelo Fluminense e quais anos eles ficaram no clube

MATCH (jogador:Jogador)-[:ELENCO_DE]->(:Time {nome: "Fluminense"})-[:MANDANTE|VISITANTE]->(partida:Partida)
WITH jogador, split(partida.data, '/')[2] as ano
WITH jogador, collect(DISTINCT ano) as anos
RETURN jogador.nome AS Jogador, apoc.coll.sort(anos) AS Anos


// Lista dos 5 times com mais gols como visitante e como mandantes

MATCH (t:Time)-[:MANDANTE]->(p:Partida)<-[:FEZ_GOL]-(j:Jogador)
WITH t.nome as Time, count(j) as Gols, "Mandante" as Tipo
ORDER BY Gols DESC
RETURN Time, Gols, Tipo
LIMIT 5
UNION
MATCH (t:Time)-[:VISITANTE]->(p:Partida)<-[:FEZ_GOL]-(j:Jogador)
WITH t.nome as Time, count(j) as Gols, "Visitante" as Tipo
ORDER BY Gols DESC
RETURN Time, Gols, Tipo
LIMIT 5


// Qual time fez mais gols em cada ano do campeonato

MATCH (t:Time)-[:MANDANTE|VISITANTE]->(p:Partida)<-[:FEZ_GOL]-(j:Jogador)
WITH t, split(p.data, '/')[2] as ano, count(j) as gols
WITH ano, collect({time: t.nome, gols: gols}) as times_gols
WITH ano, reduce(max_gols = head(times_gols), time_gols in tail(times_gols) |
  case 
    when time_gols.gols > max_gols.gols then time_gols
    else max_gols
  end) as maxGols
RETURN maxGols.time as Time, ano as Ano, maxGols.gols as Gols
ORDER BY Ano


