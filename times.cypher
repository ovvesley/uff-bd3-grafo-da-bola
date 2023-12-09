# Criação dos TIMES E Relação com a PARTIDA. Percorrer o CSV e criar os times e a relação com a partida
CREATE
    (cruzeiro:Time {nome: 'Cruzeiro'})
CREATE
    (fluminense:Time {nome: 'Fluminense'})
CREATE
    (partida:Partida {id_partida: 1234, data: '2019-10-27', local: 'Mineirão', placar: '2x1'})
CREATE (cruzeiro)-[:MANDANTE]->(partida)
CREATE (fluminense)-[:VISITANTE]->(partida)


# tratar os gols e criar o time

MATCH (time:Time {nome: "Fluminense"})-[:MANDANTE|VISITANTE]->(partida:Partida {id_partida: 1234})
CREATE(fred:Jogador{nome: "Fred"})
CREATE (fred)-[:ELENCO_DE]->(time)
CREATE (fred)-[:FEZ_GOL {minuto: 10}]->(partida)





