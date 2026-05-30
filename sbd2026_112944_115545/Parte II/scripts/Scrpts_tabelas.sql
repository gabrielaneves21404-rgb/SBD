SELECT DISTINCT diseaseNID, diseaseName 
FROM diseaseAttributes 
WHERE diseaseName IN ('Asthma', 'Obesity', 'Colonic Diverticulitis');



SELECT DISTINCT g.geneNID, g.geneName, g.geneDescription
FROM geneAttributes g
INNER JOIN geneDiseaseNetwork n ON g.geneNID = n.geneNID
INNER JOIN diseaseAttributes d ON n.diseaseNID = d.diseaseNID
WHERE d.diseaseName IN ('Asthma', 'Obesity', 'Colonic Diverticulitis');



SELECT n.geneNID, n.diseaseNID, n.score, n.year, n.source
FROM geneDiseaseNetwork n
INNER JOIN diseaseAttributes d ON n.diseaseNID = d.diseaseNID
WHERE d.diseaseName IN ('Asthma', 'Obesity', 'Colonic Diverticulitis');