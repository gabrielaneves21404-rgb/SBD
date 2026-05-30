-- Exercício 6 Parte A

-- =============================================
-- EXEMPLO 2: Join de genes e doenças
-- =============================================

SET STATISTICS TIME ON;
SET STATISTICS IO ON;

-- PASSO 1: Query sem índices nas colunas de join
SELECT 
    D.diseaseName,
    STRING_AGG(CAST(G.geneName AS VARCHAR(MAX)), ', ') AS Genes_Associados
FROM diseaseAttributes D
JOIN geneDiseaseNetwork N ON D.diseaseNID = N.diseaseNID
JOIN geneAttributes G ON N.geneNID = G.geneNID
GROUP BY D.diseaseName;

-- PASSO 2: Criar índices nas colunas usadas nos JOINs
CREATE INDEX IX_geneDiseaseNetwork_diseaseNID 
ON geneDiseaseNetwork(diseaseNID);

CREATE INDEX IX_geneDiseaseNetwork_geneNID 
ON geneDiseaseNetwork(geneNID);

-- PASSO 3: Executar novamente e comparar
SELECT 
    D.diseaseName,
    STRING_AGG(CAST(G.geneName AS VARCHAR(MAX)), ', ') AS Genes_Associados
FROM diseaseAttributes D
JOIN geneDiseaseNetwork N ON D.diseaseNID = N.diseaseNID
JOIN geneAttributes G ON N.geneNID = G.geneNID
GROUP BY D.diseaseName;

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;

DROP INDEX IF EXISTS IX_geneDiseaseNetwork_diseaseNID ON geneDiseaseNetwork;
DROP INDEX IF EXISTS IX_geneDiseaseNetwork_geneNID ON geneDiseaseNetwork;
