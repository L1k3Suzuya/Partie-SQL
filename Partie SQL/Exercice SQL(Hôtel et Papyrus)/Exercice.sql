
----Exercice 6------
SELECT hot_nom, hot_categorie, hot_ville
FROM hotel
WHERE hot_ville = 'Bretou' AND hot_categorie >= 3

----Exercice 7-------
SELECT hot_nom, sta_nom, hot_categorie, hot_ville
FROM hotel
JOIN station ON hot_id = sta_id

----Exercice 8-------

SELECT hot_nom, cha_numero, hot_categorie, hot_ville
FROM hotel
JOIN chambre ON hot_id = cha_id

-----Exercice 9------
SELECT hot_nom, cha_numero, hot_categorie, hot_ville, cha_capacite
FROM hotel
JOIN chambre ON hot_id = cha_hot_id
WHERE hot_ville = 'Bretou' AND cha_capacite > 1

-----Exercice 10------
SELECT hot_nom, cli_nom, res_date
FROM reservation
JOIN client ON cli_id = res_cli_id
JOIN chambre ON cha_id = res_cha_id
JOIN hotel ON hot_id = cha_hot_id

-----Exercice 11------

SELECT sta_nom, hot_nom, cha_numero, cha_capacite
FROM chambre
JOIN hotel ON hot_id = cha_hot_id
JOIN station ON sta_id = hot_id

-----Exercice 12------

SELECT hot_nom, cli_nom, res_date, DATEDIFF (res_date_fin, res_date_debut)
FROM reservation
JOIN client ON cli_id = res_cli_id
JOIN chambre ON cha_id = res_cha_id
JOIN hotel ON hot_id = cha_hot_id

------Exercice 13------

SELECT sta_nom, COUNT(hot_sta_id) FROM station
JOIN hotel ON sta_id = hot_sta_id
GROUP BY sta_nom;

------Exercice 14------

SELECT sta_nom, COUNT(cha_hot_id) FROM station
JOIN hotel ON sta_id = hot_sta_id
JOIN chambre ON cha_hot_id = hot_id
GROUP BY sta_nom;

------Exercice 15------

SELECT sta_nom, COUNT(cha_hot_id) FROM station
JOIN hotel ON sta_id = hot_sta_id
JOIN chambre ON cha_hot_id = hot_id
WHERE cha_capacite > 1
GROUP BY sta_nom;

------Exercice 16------

SELECT hot_nom AS NomHotel, cha_numero AS NumeroChambre, res_date AS DateReservation, cli_nom AS NomClient FROM hotel
JOIN chambre ON hot_id = cha_hot_id
JOIN reservation ON cha_id = res_cha_id
JOIN client ON res_cli_id = cli_id
WHERE cli_nom = 'Squire';

------Exercice 17------

SELECT avg(datediff(res_date_fin,res_date_debut)) AS MoyenneSejour, sta_nom AS NomStation FROM reservation
JOIN chambre ON cha_id = res_cha_id
JOIN hotel ON hot_id = cha_hot_id
JOIN station ON sta_id = hot_sta_id
GROUP BY sta_nom;


------Exercice Papyrus------


------Question 1------

SELECT numcom AS NumeroCommande, nomfou AS Fournisseur FROM ligcom
NATURAL JOIN entcom, fournis
WHERE fournis.numfou = 9120 AND entcom.numfou = 9120;

------Question 2------

SELECT numfou AS IDFournisseur, nomfou AS NomFournisseur FROM fournis
NATURAL JOIN entcom
GROUP BY nomfou;

------Question 3------

SELECT COUNT(numcom), nomfou FROM entcom
NATURAL JOIN fournis
GROUP BY nomfou;

------Question 4------

SELECT codart AS CodeArticle, libart AS LibelleArticle, stkphy AS QttPhysique, stkale AS StockAlerte, qteann AS QttAnnuelle FROM produit
WHERE stkphy < stkale AND qteann < 1000;


------Question 5------

SELECT nomfou AS NomFournisseur, left(posfou,2) AS Departement FROM fournis
WHERE LEFT(posfou,2) IN (75, 78, 92, 77)
ORDER BY Departement;


------Question 6------

SELECT numcom AS NumeroCommande, datcom AS DateCommande FROM entcom
WHERE MONTH(datcom) IN (3,4);

------Question 7------

SELECT numcom AS NumeroCommande, datcom AS DateCommande, obscom FROM entcom
WHERE obscom <> '';


------Question 8------

SELECT numcom, (qtecde * priuni) AS Total FROM ligcom
ORDER BY numcom;


------Question 9------

SELECT numcom, (qtecde * priuni) AS Total FROM ligcom
WHERE qtecde = 1000 AND  (qtecde * priuni) > 10000
ORDER BY numcom;


------Question 10------

SELECT nomfou AS NomFournisseur, numcom AS NumeroCommande, datcom AS DateCommande FROM fournis
NATURAL JOIN entcom
ORDER BY nomfou;


------Question 11------

SELECT numcom, nomfou, libart, (qtecde*priuni) AS st FROM fournis
NATURAL JOIN entcom, ligcom, produit
WHERE obscom LIKE '%urgent%'
ORDER BY nomfou;

------Question 12------


SELECT nomfou AS NomFournisseur FROM fournis
NATURAL JOIN entcom, ligcom, produit, vente
WHERE qte1 >= 1
GROUP BY nomfou;

------Question 13------


SELECT numcom AS NumeroCommande, datcom AS DateCommande FROM ligcom
NATURAL JOIN entcom, fournis
WHERE nomfou = (
    SELECT nomfou FROM fournis
    NATURAL JOIN entcom
    WHERE numcom = 70210
    )


------Question 14------

SELECT MIN(prix1) AS PrixMinimum, libart AS LibelleArticle FROM vente
NATURAL JOIN produit
WHERE LEFT(codart,1) IN ('r','R');



-------BDD - Mettre à jour une Base De Données-------

-------Exerice 1-------
UPDATE vente
SET prix1 = prix1 + (prix1*0.04), prix2 = prix2 + (prix2*0.02)
WHERE numfou = 9180;

-------Exerice 2-------

UPDATE vente
SET prix2 = prix1
WHERE prix2 IN (NULL,0);

-------Exerice 3-------

UPDATE entcom
NATURAL JOIN fournis
SET obscom = '*****'
WHERE satisf < 5;

-------Exerice 4-------

DELETE FROM "I110"