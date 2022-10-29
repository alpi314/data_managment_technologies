# Homework 1

Predstavljajmo si zdravstveni dom, ki ga sestavlja več oddelkov in laboratorij. Zdravstveni dom obiskujejo pacienti, opisani s številko kartice zdravstvenega zavarovanja (KZZ), imenom, priimkom, rojstnim datumom, spolom in naslovom. Ob začetku zdravljenja se pacientu dodeli številka obravnave, ki ga spremlja skozi celoten potek zdravljenja. Pacient se lahko zdravi na enem ali več oddelkih. Vsak izmed oddelkov je opisan s številko oddelka in imenom.

Oddelki imajo različne čakalne vrste v katere se vpišejo pacienti po dodelitvi številke obravnave in ugotovljeni potrebi po oddelku. Čakalna vrsta vsebuje podatke o številki obravnave, zahtevanem oddelku, datumu in času vpisa in predvidenem datumu in času sprejema na oddelek.

Pacientu tekom zdravljenj opravljajo določene laboratorijske preiskave. Te so opisane s šifro preiskave, ter datumom in časom preiskave  (npr. odvzema krvi). Vsaka laboratorijska preiskava je opisana tudi z imenom, dopustnim intervalom vrednosti (min-max), ter referenčnimi vrednostmi (interval min-max), ki je pogosto različen za moške in ženske.

Na posamezne laboratorijske preiskave se lahko naročijo tudi samoplačniki, ki trenutno niso na zdravljenju v zdravstvenem domu. Pri preiskavah je določena tudi cena za samoplačnike. Predlagajte, kako se lahko na najbolj enostaven način vključijo tudi taki primeri.

Med in ob koncu zdravljenja se pacientu postavi ena ali več diagnoz. Diagnoze so oštevilčene (začenši z 1) in opisane po mednarodni klasifikaciji bolezni (ICD) po najmanj enem izmed sistemov: slovenski (SLO), ameriški (USA), mednarodni (WHO). Vsaka bolezen je opisana z ICD kodo, slovenskim in angleškim imenom, ter morda še kakšnimi drugimi atributi (primeri so v priponki).

## Short Task Description

<strong>Task in text</strong> -> Think about how to handle people who are not actively treated but would like to apply for self-financed labwork.
<br>
<strong>Task A</strong> -> From the provided text indentify atributes, entety types, indentifiers, relationships (think about additional attributes that might be needed).
<br>
<strong>Task B</strong> -> Through PowerDesigner creater entety-relation schema according to the provided text.
<br>
<strong>Task C</strong> -> Think about logical constraints that would also be applicable to the problem in the text (which ones can be implement in ER-diagaram and which ones cannot).

## Task A

V podanem tekstu identificirajte gradnike ER modela: atribute, entitetne tipe, identifikatorje, razmerja. Razmislite in opišite ali (če sploh) je potrebno dodati še kakšne nove/umetne/izračunane atribute.  

<hr>

<strong> Entitetni Tipi: </strong>
- pacient
- oddelek
- cakalna_vrsta
- preiskava
- diagnoza

<strong> Atributi </strong>
- pacient
    - kzzs
    - ime
    - priimek
    - datum_rojstva
    - spol
    - naslov
- obravnava
- oddelek
    - oddelek_id
    - ime
- cakalna_vrsta
    - st_obravnave
    - oddelek_id
    - cas_vpisa
    - cas_sprejema
- preiskava 
    - preiskava_id
    - datum
    - ime
    - cena_za_samoplacnike
    - pricakovana_vrednost_id
- pricakovana_vrednost
    - pricakovana_vrednost_id
    - dopustna_min
    - dopustna_max
    - referencna_moski_min
    - referencna_moski_max
    - referencna_zenske_min
    - referencna_zenske_max
- diagnoza
    - diagnoza_id
    - icd_sifra
    - slovensko_ime
    - anglesko_ime
- icd
    - icd_id
    - icd_sifra
    - icd_sistem
    - icd_opis

<strong> Indentifikatorji: </strong>
- kzzs
- st_obravnave & oddelek_id
- st_obravnave
- preiskava_id
- diagnoza_id

<strong> Razmerja: </strong>
- pacient 'čaka v' cakalna_vrsta
- cakalna_vrsta 'pripada' oddelku
- pacient 'opravi' preiskava
- pacient 'ima postavljeno' diagnoza

<strong> Dodatni Indentifikatorji: </strong>
- pricakovana_vrednost_id
- icd_id

<strong> Dodatna Razmerja: </strong>
- preiskava 'predvideva' pricakovana_vrednost
- diagnoza 'je opisana z' icd