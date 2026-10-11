# pharmasales-analysis
Analiza prodaje zdravil 2014–2019

Ta projekt sem naredil, da bi v praksi preizkusil, kar sem se učil pri predmetih
Podatkovna skladišča in Menedžerski informacijski sistemi. Vzel sem javne podatke
o prodaji ene lekarne, jih uredil v PostgreSQL in naredil nadzorno ploščo v Power BI.

![Nadzorna plošča](images/prodaja.png)

## Podatki

Pharma Sales Data s Kaggla: https://www.kaggle.com/datasets/milanzdravkovic/pharma-sales-data
Urna prodaja od januarja 2014 do oktobra 2019, razdeljena v 8 skupin zdravil po ATC klasifikaciji.

## Kaj sem naredil

Najprej sem CSV uvozil v staging tabelo, kjer so vsi stolpci besedilo. Nato sem
naredil zvezdno shemo: tabelo dejstev `fact_sales` ter dimenziji `dim_date` in `dim_atc`.

Podatki so bili v "širokem" formatu (vsaka skupina zdravil svoj stolpec), zato sem jih
z `UNION ALL` pretvoril v dolgi format. Ena vrstica je prodaja ene skupine v eni uri.
Tako je bilo kasneje v Power BI veliko lažje filtrirati in primerjati skupine.

Skripte v mapi `SQL`:

- `01_staging.sql` – staging tabela za surove podatke
- `02_dim_atc.sql` – dimenzija skupin zdravil
- `03_dim_date.sql` – časovna dimenzija
- `04_fact_sales.sql` – tabela dejstev (pretvorba v dolgi format)
- `upit1.sql` – prodaja po skupinah zdravil
- `upit2.sql` – prodaja po letih
- `upit3.sql` – prodaja po letnih časih za izbrano skupino
- `upit4.sql` – prodaja po urah dneva

V Power BI sem naredil dve strani: pregled prodaje in sezonskost.

## Kaj sem ugotovil

- Paracetamol predstavlja skoraj polovico vse prodaje.
- Antihistaminiki se največ prodajajo maja in junija, decembra pa skoraj trikrat manj, sezona alergij se v podatkih zelo jasno vidi.
- Zdravila za dihala imajo ravno obratno sezono, največ pozimi.
- Diklofenak in ibuprofen se prodajata enakomerno čez celo leto.
- V lekarni sta dva vrhunca prometa: okoli 11. ure in okoli 19. ure.

![Sezonskost](images/sezone.png)

## Na kaj sem naletel

- Datumi so bili v ameriškem formatu (MM/DD/YYYY). Če bi jih prebral narobe, baza ne bi javila napake, samo dnevi in meseci bi se pomešali.
- Leto 2019 ni celo (podatki do 8. oktobra), zato sem za primerjave uporabil povprečno dnevno prodajo namesto skupne.
- V toplotni mapi je paracetamol s svojimi velikimi številkami "prekril" vse ostale skupine. Rešil sem z DAX meritvijo sezonski indeks, ki vsak mesec primerja s povprečjem iste skupine (`CALCULATE` + `ALL`).
- V letu 2017 je prodaja nekaj mesecev opazno nižja. Ne vem, ali gre za dejanski padec ali napako v podatkih.

## Orodja

PostgreSQL, pgAdmin, Power BI (DAX)

## Zagon

1. V PostgreSQL ustvari bazo `pharma_sales`.
2. Zaženi `SQL/01_staging.sql`, nato v pgAdmin uvozi `saleshourly.csv`
   (desni klik na tabelo: Import/Export Data, Header vklopljen).
3. Po vrsti zaženi `02`, `03` in `04`.
4. Analitične poizvedbe so v `upit1.sql`–`upit4.sql`.
5. Odpri `pharma-dashboard.pbix` v Power BI.

---
Ivan Đukić, magistrski študij Informatika v sodobni družbi, FIŠ Novo mesto
