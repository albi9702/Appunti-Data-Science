# Esercitazione SQL

## Esercizio 1
### 1.1 
Visualizzare solo il contenuto degli attributi titolo, tipo, prezzo della tabella libri:

```SQL
SELECT titolo,
       tipo,
       prezzo
  FROM libri;
```

### 1.2
Visualizzare titolo e prezzo dei libri che costano meno di 10 euro:

```SQL
SELECT titolo,
       prezzo
  FROM libri
 WHERE prezzo < 10;
```

### 1.3
Visualizzare le informazioni dei libri di informatica (`CS`):

```SQL
SELECT titolo,
       tipo
  FROM libri
 WHERE tipo = "CS";
```

### 1.4
Visualizzare con un'unica query le informazioni sia dei libri di informatica sia dei libri di fiction (`CS` e `FIC`):

```SQL
SELECT titolo,
       tipo
  FROM libri
 WHERE tipo = "CS" OR 
       tipo = "FIC";
```

### 1.5
Visualizzare per ogni libro, il titolo del libro e l'editore:

```SQL
SELECT titolo,
       nome
  FROM editori,
       libri
 WHERE editori.codice = libri.codice_editore;
```

### 1.6
Visualizzare per ogni libro il titolo, il prezzo e la descrizione del formato:

```SQL
SELECT titolo,
       prezzo,
       descrizione
  FROM libri AS l
       JOIN
       formato AS f ON f.codice = l.cod_format;
```

### 1.7
Visualizzare (per ogni libro della tabella libri) il titolo del libro e il cognome dell'autore che lo ha scritto:

```SQL
SELECT titolo,
       cognome
  FROM libri AS l
       JOIN
       hascritto AS hs ON l.codice = hs.codice_libro
       JOIN
       autori AS a ON hs.codice_autore = a.codice_autore;
```

### 1.8
Come il punto precedente, ma stampare solamente i libri scritti da Kafka:

```SQL
SELECT titolo,
       cognome
  FROM libri AS l
       JOIN
       hascritto AS hs ON l.codice = hs.codice_libro
       JOIN
       autori AS a ON hs.codice_autore = a.codice_autore
 WHERE cognome = "Kafka";
```

### 1.9
Come il punto precedente, ma stampare solamente i libri scritti da Kafka o da Agata Christie:

```SQL
SELECT titolo,
       cognome
  FROM libri AS l
       JOIN
       hascritto AS hs ON l.codice = hs.codice_libro
       JOIN
       autori AS a ON hs.codice_autore = a.codice_autore
 WHERE cognome = "Kafka" OR 
       cognome = "Christie";
```

### 1.10
Stampate il nome e la sede delle librerie dove � in vendita il libro `dBASE Programming`:

```SQL
SELECT nome,
       sede
  FROM negozi AS n
       JOIN
       scorte AS s ON n.codice_negozio = s.codice_negozio
       JOIN
       libri AS l ON s.codice_libro = l.codice
 WHERE titolo = "dBASE Programming";
```

## Esercizio 2
### 2.1
Visualizzare il numero totale di clienti con nome `Charles`, `Patricia` e `Sharon`:

```SQL
SELECT count( * ) AS Conteggio
  FROM customer
 WHERE fname = 'Charles' OR 
       fname = 'Patricia' OR 
       fname = 'Sharon'
 GROUP BY fname;
```

### 2.2
Visualizzare il numero totale di carte stratificate per tipo di carta:

```SQL
SELECT mc.description,
       COUNT( * ) 
  FROM customer AS c
       JOIN
       member_card AS mc ON c.card_type_id = mc.card_type_id
 GROUP BY mc.card_type_id;
```

### 2.3
Visualizzare il numero degli scontrini dei client `Clyde Dixon` e `Bonnie Emerson`:

```SQL
SELECT *
  FROM bill AS b
       JOIN
       customer AS c ON b.customer_id = c.customer_id
 WHERE c.fname = 'Clyde' AND 
       c.lname = 'Dixon';
```

### 2.4
Visualizzare il nome ed il cognome dei clienti, per i quali sono stati emessi scontrini che singolarmente riportano un totale superiore a 307 dollari:

```SQL
SELECT *
  FROM bill AS b
       JOIN
       customer AS c ON b.customer_id = c.customer_id
 WHERE b.total > 307;
```

### 2.5
Visualizzare il cognome ed il nome di tutti i clienti che hanno acquistato il prodotto `Great Muffins`:

```SQL
SELECT c.lname,
       c.fname
  FROM bill AS b
       JOIN
       customer AS c ON c.customer_id = b.customer_id
       JOIN
       item_in_bill AS i ON b.bill_id = i.bill_id
       JOIN
       product AS p ON i.product_id = p.product_id
 WHERE p.product_name = 'Great Muffins'
 ORDER BY c.lname;
```

### 2.6
Visualizzate il cognome e il nome di tutti i clienti che hanno acquistato prodotti forniti dall'azienda `Bravo`:

```SQL
SELECT c.lname,
       c.fname,
       p.product_name,
       b.date
  FROM bill AS b
       JOIN
       customer AS c ON c.customer_id = b.customer_id
       JOIN
       item_in_bill AS i ON b.bill_id = i.bill_id
       JOIN
       product AS p ON i.product_id = p.product_id
       JOIN
       supplier AS s ON p.supplier_id = s.supplier_id
 WHERE s.name = 'Bravo';
```

### 2.7
Per ogni prodotto con `product_id` < 20, visualizzare la quantit� di prodotto venduta:

```SQL
SELECT p.product_id,
       p.product_name,
       sum(i.quantity) 
  FROM product AS p
       JOIN
       item_in_bill AS i ON p.product_id = i.product_id
 WHERE p.product_id < 20
 GROUP BY p.product_id;
```

### 2.8
Eseguire delle query per individuare la classe di prodotti che vende di pi�, sia in termini di quantit�, sia in termini di ricavo:

```SQL
SELECT pc.product_class_id,
       pc.product_subcategory,
       sum(i.quantity) as Quantita
  FROM item_in_bill AS i
       JOIN
       product AS p ON i.product_id = p.product_id
       JOIN
       product_class AS pc ON p.product_class_id = pc.product_class_id
 GROUP BY pc.product_class_id;
```

# Esercitazione Graph DB

## Esercizio 1
Costruire il grafo della immagine precedente:

### 1.1
Creazione Entit� `person`:

```Cypher
LOAD CSV WITH HEADERS FROM
"file:/person.csv" AS row FIELDTERMINATOR ';'

CREATE (:person
		{name: row.name,
		gender: row.gender
});
```

### 1.2
Creazione Entit� `skill`:

```Cypher
LOAD CSV WITH HEADERS FROM
"file:/skill.csv" AS row FIELDTERMINATOR ';'

CREATE (:skill
		{name: row.name});
```

### 1.3
Creazione Relazione `INTERESTED_IN`:

```Cypher
LOAD CSV WITH HEADERS FROM
"file:/interested_in.csv" as row FIELDTERMINATOR ";" 

MATCH (a:person), (b:skill)
WHERE a.name = row.from AND b.name = row.to
CREATE (a)-[:INTERESTED_IN]->(b)
```

### 1.4
Creazione Entit� `project`:

```Cypher
LOAD CSV WITH HEADERS FROM
"file:/projects.csv" AS row FIELDTERMINATOR ';'

CREATE (:project
		{name: row.name});
```

### 1.5
Creazione Relazione `WORKED_ON`:

```Cypher
LOAD CSV WITH HEADERS FROM
"file:/worked_on.csv" as row FIELDTERMINATOR ";" 

MATCH (a:person), (b:project)
WHERE a.name = row.from AND b.name = row.to
CREATE (a)-[:WORKED_ON]->(b)
```
### 1.5
Creazione Entit� `company`:

```Cypher
LOAD CSV WITH HEADERS FROM
"file:/company.csv" AS row FIELDTERMINATOR ';'

CREATE (:company
		{name: row.name});
```

### 1.6
Creazione Relazione `WORKS_FOR`:

```Cypher
LOAD CSV WITH HEADERS FROM
"file:/works_for.csv" as row FIELDTERMINATOR ";" 

MATCH (a:person), (b:company)
WHERE a.name = row.from AND b.name = row.to
CREATE (a)-[:WORKS_FOR]->(b)
```
<!-- Lezione 13: 11/11/2020 -->
## Esercizio 2
Costruire il grafo dal seguente modello *E-R*:

<!-- Immagine Grafo Tweets -->
```{r Grafo Tweets}
knitr::include_graphics("Immagini/Graph-Tweets.png")
```

### 2.1
Creare il nodo `users`:

```Cypher
LOAD CSV WITH HEADERS FROM
"file:/expo_users.csv" AS row FIELDTERMINATOR ';'

CREATE (:users
		    {user_id: row.user_id,
         friends_count: row.user_friends_count,
         follow_count: row.user_followers_count,
         statuses_count: row.user_statuses_count,
         created_at: row.user_created_at,
         mentions: row.tweet_user_mentions,
         user_name: row.user_screen_name});
```

### 2.2
Creare il nodo `hashtags`:

```Cypher
LOAD CSV WITH HEADERS FROM
"file:/hashtag_distinct.csv" AS row FIELDTERMINATOR ';'

CREATE (:hashtags
		    {tweet_id: row.tweet_id,
         hashtags: row.tweet_hashtag});
```

### 2.3
Creare il nodo `tweets`:

```Cypher
LOAD CSV WITH HEADERS FROM
"file:/expo_streaming.csv" AS row FIELDTERMINATOR ';'

CREATE (:tweets
		    {tweet_id: row.tweet_id,
         retweet_count: row.tweet_retweet_count,
         created_at: row.tweet_created_at,
         tweet: row.tweet_text,
         hashtags: row.tweet_hashtags,
         mentions: row.tweet_user_mentions,
         user_id: row.user_id});
```

### 2.4
Creare indici sui nodi:

```Cypher
CREATE INDEX ON :users(user_id);

CREATE INDEX ON :tweets(tweets_id);
```

### 2.5
Creare la relazione `posts`:

```Cypher
LOAD CSV WITH HEADERS FROM
"file:/expo_streaming.csv" AS row FIELDTERMINATOR ';'

MATCH (u:users), (t:tweets)
WHERE u.user_id = row.user_id AND t.tweet_id = row.tweet_id
CREATE (u)-[:posts]->(t)
```

### 2.5
Creare la relazione `contains`:

```Cypher
LOAD CSV WITH HEADERS FROM
"file:/expo_users.csv" AS row FIELDTERMINATOR ';'

MATCH (t:tweets), (h:hashtags)
WHERE row.tweet_hashtags = h.hashtags AND row.tweet_id = h.tweet_id
CREATE (t)-[:contains]->(h)
```