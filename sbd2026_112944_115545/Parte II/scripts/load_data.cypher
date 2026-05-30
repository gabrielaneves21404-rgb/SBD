SCRIPT DE CARREGAMENTO DO GRAFO (LOAD CSV)
Grupo:09
Base de Dados: DisGeNET (Amostra: Asthma & Obesity)


1. Criação dos Nós de Doenças (Disease)
LOAD CSV FROM 'file:///disease.csv' AS row FIELDTERMINATOR ';'
CREATE (:Disease {diseaseNID: toInteger(row[0]), name: row[1]});

2. Criação dos Nós de Genes (Gene)
LOAD CSV FROM 'file:///gene.csv' AS row FIELDTERMINATOR ';'
CREATE (:Gene {geneNID: toInteger(row[0]), name: row[1], description: row[2]});


3. Criação dos Relacionamentos (ASSOCIATED_WITH) com limpeza de tipos
LOAD CSV FROM 'file:///associacoes.csv' AS row FIELDTERMINATOR ';'
MATCH (g:Gene {geneNID: toInteger(row[0])})
MATCH (d:Disease {diseaseNID: toInteger(row[1])})
CREATE (g)-[:ASSOCIATED_WITH {
  score: toFloat(replace(row[2], ',', '.')),
  year: CASE row[3] WHEN 'NULL' THEN null ELSE toInteger(row[3]) END,
  source: row[4]
}]->(d);