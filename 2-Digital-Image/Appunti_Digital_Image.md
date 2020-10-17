---
title: "Digital Signal and Image Management"
author: "Alberto Filosa"
date: "29/9/2020"
email: "a.filosa1@campus.unimib.it"
documentclass: article
lang: it
fontsize: 11pt
geometry: margin = 0.5in
classoption: twocolumn
output: 
  bookdown::gitbook:
    keep_md: true
    css: style.css
    split_by: rmd
    config:
      toc:
        collapse: subsection
        before: |
          <li><a > Digital Signal and Image Management </a></li>
        after: |
          <li><a href = "https://github.com/rstudio/bookdown" target = "blank">Published with bookdown</a></li>
      download: ["pdf", "epub"]
      fontsettings:
        theme: white
        family: sans
        size: 2
      sharing:
        github: yes
        linkedin: yes
        twitter: no
        facebook: no
  pdf_document:
    latex_engine: xelatex
    toc: true
    toc_depth: 3
    number_sections: true
    fig_width: 7
    fig_height: 6
    fig_caption: true
    df_print: kable
    highlight: monochrome
---



# Classificazione dei Segnali
I segnali possono essere classificati in base al Dominio ed al Codominio. Si riportano i seguenti esempi:

1. Segnale Analogico, $\mathbb{D} : \mathbb{R} \rightarrow \mathbb{R}$;
2. Segnale Analogico a tempo discreto, $\mathbb{D} : \mathbb{R} \rightarrow \mathbb{K}$, con $K = \{\dots, t-1, t, t+1, \dots\}$;
3. Segnale Continuo nelle ampiezze, $\mathbb{D} : \mathbb{R} \rightarrow \mathbb{K}$;
4. Segnale Digitale, $\mathbb{D} : \mathbb{K} \rightarrow \mathbb{K}$.

Per rappresentare digitalmente un segnale analogico sono necessari 3 fasi:

* Campionamento: si considerano solanemente le parti di segnali tali per cui non si perdono troppe informazioni. Una alta frequenza di campionamenta significa una buona riproduzione del segnale originale, ma si avrà un numero elevato di dati, mentre una bassa frequenza di campionamnto produce il fenomeno chiamato aliasing;
* Quantizzazione: l'ADC campiona una onda analogica ad intervalli temporali uniformi ed assegna u valore digitale ad ogni campione. Il valore è ottenuto tramite la seguente formula:

$$\text{Digital Output Code} = \frac{\text{Analog Input}}{\text{Reference Input}} \times (2^N - 1)$$;

* Codifica, limitata dalla memoria del dispositivo digitale e dalla sua velocità. Il file verrà compresso, processato o trasmesso

Per un efficace trattamento dei segnali è necessario minimizzare il quantitativo dei dati processati individuando solo quelli strettamente necessari, in modo da perdere meno informazioni possibili. La differenza tra il segnale analogico e la sua rappresentazione digitale è definita rumore di quantizzazione; il rumore diminuisce all'aumentare dei bit richiesti per la codifica del singolo campione.

Per *Ampiezza* si intende il valore assunto dal segnale e sarà la variabile dipendente $y$. Il tempo (o lo spazio) corrisponde alla variabile indipendente $x$, monodimensionale o a più dimensioni.

Le grandezze statistiche utilizzate sono:

Energy: $E_f = \int_{-\infty}^{+\infty} f^2(t) dt$
Power: $P_f = \lim_{T \rightarrow \infty} \frac{1}{T} \int_{-\frac{T}{2}}^{\frac{T}{2}} (|f(t)|)^2 dt$
Average: $\mu = \lim_{T \rightarrow \infty} \frac{1}{T} \int_{-\frac{T}{2}}^{\frac{T}{2}} x(t) dt = \frac{1}{T_1 - T_0}\int_{T_0}^{T_1} x(t) dt$

Se il segnale è una forma d'onda ripetuta, queste escursioni sono costanti e possono essere descritte da una grandezza chiamata Ampiezza *Picco-Picco*.

La periodicità di un segnale indica il tempo nel quale è definito il segnale che si ripete. La frequenza fondamentale è legata al periodo della relazione $f_0 = 1/T$. Nella realtà non esistono segnali puramente periodici, ma segnali quasi periodici caratterizzati da forme d'onda che si ripetono quasi uguali.

Il *Decibel* è un'unità di misura di tipo logaritmico che esprime il rapporto fra due livelli di potenza. La misura in decibel tra due grandezze fisiche delo stesso tipo è quindi una misura relativa, adimensionale e non lineare:

$$Bel = \log_{10}\frac{P_1}{P_2} \implies dB = 10Bel = 20\log_{10}\frac{A_1}{A_2}$$

<!-- Lecture 2: 06/10/2020 -->
# Analisi di Fourier
L'Analisi di Fourier ha lo scopo di decomporre il segnale in costituenti sinusoidali di frequenze differenti. In particolare, consente di osservare il segnale non più nel dominio tempo - spazio, ma nel dominio delle freqeunze.

Ogni funzione periodica e a quadrato sommabile può essere espressa come somma di funzioni di seno e coseno:

$$y = A \sin(\overline \omega x + \phi) \\
y = A \cos(\overline \omega x + \phi)$$

L'ampiezza indica quali sono i valori che la sinusoide può assumere, La pulsazione ($\overline \omega = 2 \pi / T$) indica la frequenza della sinusionide, la fase indica quanto ritardo c'è nella sinusioide classica

<!-- Mettere Foto -->
Ad esempio, il segnale della immagine di sinistra è ottenuto sommando i segnali nella parte destra.


<img src="Immagini/Somma-Segnali.png" width="100%" style="display: block; margin: auto;" />

La serie di furier scrive un segnale nella seguente forma:

$$f(x) = \frac{a_0}{2} + \sum_{k = 1}^{\infty} a_k \cos(\frac{2 \pi}{N} kx) + b_k \sin(\frac{2 \pi}{N} kx)$$

con $N$ periodo, ($1/N$) definita come frequenza fondamentale $f_0$, $k/n$ frequenza $f_k = kf_0$ e $\overline \omega = 2 \pi f_k$ pulsazione. La formula diventa perciò:

$$f(x) = \frac{a_0}{2} + \sum_{k = 1}^{\infty} a_k \cos(2 \pi k f_0 x) + b_k \sin(2 \pi k f_0 x)$$

Data la funzione $f(x)$ periodica, i coefficienti della serie sono univocamente determinati:

$$a_k = \frac{2}{N} \int_{-N/2}^{N/2} f(x) \cos(2 \pi k f_0 x) \qquad b_k = \frac{2}{N} \int_{-N/2}^{N/2} f(x) \sin(2 \pi k f_0 x)$$

## Trasformata
Ogni funzione continua $f(x)$, anche se non periodica, può essere espressa come integrale di sinusoidi complesse opportunamente pesate:

$$F(u) = \int_{-\infty}^{+\infty} f(x) e^{-j2 \pi u x} dx \\
  f(x) = \int_{-\infty}^{+\infty} F(u) e^{j2 \pi u x} dx $$

Inoltre, è possibile passare dalla trasformata di Fourier, definita come il dominio delle frequenze (o trasformato), alla antitrasformata di Fourier, definita come dominio temporale. Questa trasformazione avviene senza perdita di informazione.

La trasformata di Fourier di una funzione continua ed integrabile è una funzione complessa nel dominio delle freqeunze. In coordinate polali si ha:

$$F(u) = F[f(x)] = \Re(u) + j\Im(u) = |F(u)|e^{j \phi(u)}$$

Il modulo della trasformata $|F(u)|$ è definito come:

$$|F(u)| = \sqrt{\Re(u)^2+ \Im(u)^2}$$

mentre la fase $\phi(u)$:

$$\phi(u) = \tan^{-1} \frac{\Im(u)}{\Re(u)}$$

Per il caso bidimensionale l'equazione della trasformata assume un'altra forma:

$$\begin{aligned}
    F(u, v) &= \int_{-\infty}^{+\infty}\int_{-\infty}^{+\infty}f(x, y) \cdot e^{-i2\pi(ux + vy)} dx dy \\
    f(u, v) &= \int_{-\infty}^{+\infty}\int_{-\infty}^{+\infty}F(x, y) \cdot e^{i2\pi(ux + vy)} dx dy
  \end{aligned}$$

che rimane molto simile a parte per il numero di assi. 

Operando con segnali digitali, che assumono valori discreti, l'integrale è sostituito dalla sommatoria:

$$F(u) = \frac{1}{N} \sum_{i = 0}^{N - 1}f(j)e^{-j 2 \pi u \frac{1}{N}i}$$

Si intende filtrare il suono di un'onda eliminando le frequenze sopra una certa soglia (ad esempio convervando solamente i bassi). Si effettua questa operazione nello spazio delle frequenze, molto più semplice in quanto si programma un filtro di una funzione che vale 0 sulle frequenze da eliminare e 1 quelle da conserbare, e lo si moltiplica per la trasformata $F(u)$, effettuando l'anti-trasformata per poter fruire nuovamente del file.

Si può effettuare un filtraggio anche con le immagini, considerando solamente il modulo della trasformata bidimensionale del segnale. Più la rappresentazione del modulo è regolare, più l'immagine sarà ordinata.
Per costruire un filtro basta considerare una circonferenza di raggio arbitrario per considerare solamente determinate frequenze.
Considerando solamente le frequenze alte sono conservati i bordi dell'immagine, con frequenze basse le informazioni sul contenuto (si ottiene una sfocatura dell'immagine).


<img src="Immagini/Spazio-Temporale-Frequenze.png" width="100%" style="display: block; margin: auto;" />

<!-- Lecture 4: 13/10/2020 -->
## Convoluzioni
Una *Convoluzione* è l'operatore che descrive i filtraggi lineari nel dominio spaziale. In particolare, è l'applicazione di un filtraggio $g$ ad una funzione $f$. Si considera una convoluzione nel dominio continuo tra due funzioni $f(x)$ e $g(x)$:

$$(f \ast g)(x) = \int_{s = -\infty}^{+\infty}g(x - s)f(s) ds$$

In particolare,

1. L'asse di rappresentazione di uno dei due segnali è invertita: $g(t) \rightarrow g(-t)$;
2. Il segnale invertito viene traslato tra $-\infty$ e $+\infty$;
3. Per ogni traslazione si calcola il prodotto del segnale traslato e quello non traslato;
4. Si calcola l'area del prodotto.

<!-- Esempio Convoluzione -->

I filtri possono essere a media mobile, in inglese smoothing, nella quale i coefficienti sommano ad 1 ($\sum_i c_i = 1$), e derivativi, nella quale i coefficienti sommano a 0 ($\sum_i c_i = 0$)

Applicando la definizione di Trasofrmata di Fourier è possibile dimostrare il Teorema della Convoluzione:

La trasformata della convoluzione di due funzioni è il prodotto delle trasformate delle stesse:

$$G(u) = F[g(x)] = F[f(x) \ast h(x)]= F(u)H(u)$$

Per la corrispondenza fra dominio spaziale e dominio delle frequenze si hanno le seguenti relazioni:

$$\begin{matrix}
    \text{Dominio Spaziale} &&                 && \text{Dominio delle Frequenze} \\
    g(x) = f(x) \ast h(x)   && \Leftrightarrow && G(u) = F(u) H(u) \\
    g(x) = f(x)h(x)         && \Leftrightarrow && G(u) = F(u) \ast H(u) 
  \end{matrix}$$

# Fondamenti di Immagini Digitali
Una *Immagine* è una funzione di intensità di luce a due dimensioni, $f(x, y)$, con coordinate spaziali rispetto alla luce in quel punto. Una *Immagine Digitale*, invece, è una rappresentazione di una immagine continua tramite un array bidimensionale di carattere discreto. Ogni elemento dell'array campionato è chiamato *Pixel*.

Il *Livello di Grigio* di una immagine è l'intesità relativa per ogni unità d'area, di solito compresa tra il valore più basso dintensità (Nero = 0) e più intenso (Bianco = 255).

L'*Intensità* di una immagine è l'energia di luce, emessa da una unità d'area nell'immagine (dipende dal dispositivo), mentre la *Luminosità* di una immagine è l'apparenza soggettiva di una unità d'area (soggettiva e dipende dal contesto).

<!-- Luminance Vs Lightness -->
La *Luminance* è definita come potenza della luce pesata per una funzione spettrale chiamata efficienza luminosa. Essa mi

I pixel $f(x,y) = f_{yx}$ sono ordinati in modo natuarel in una matrice, con $x$ la colonna e $y$ l'indice di riga:

$$\begin{bmatrix}
    f(0,0)   && f(1,0)   && \dots && f(N-1, L-0)
    f(0,1)   && f(1,1)   && \dots && f(N-1, 1)
    \vdots   && \vdots   &&       && \vdots
    f(0,L-1) && f(1,L-1) && \dots && f(N-1, L-1)
  \end{bmatrix}$$

<!-- Vedere Trasformazioni Immagini -->
