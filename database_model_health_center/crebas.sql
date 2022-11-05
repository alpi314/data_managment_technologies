/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     11/5/2022 3:07:39 PM                         */
/*==============================================================*/


drop index ANGLESKI_ICD_PK;

drop table ANGLESKI_ICD;

drop index PRIPADA_FK;

drop index JE_VKLJUCENA_V_FK;

drop index CAKALNA_VRSTA_PK;

drop table CAKALNA_VRSTA;

drop index IMA_MEDNARODNI_FK;

drop index IMA_ANG_INDENTIFIKATOR_FK;

drop index IMA_SLO_INDENTIFIKATOR_FK;

drop index IMA_POSTAVLJENO_FK;

drop index DIAGNOZA_PK;

drop table DIAGNOZA;

drop index MEDNARODNI_ICD_PK;

drop table MEDNARODNI_ICD;

drop index NASLOV_PK;

drop table NASLOV;

drop index IMA_DODELJENO_FK;

drop index OBRAVNAVA_PK;

drop table OBRAVNAVA;

drop index ODDELEK_PK;

drop table ODDELEK;

drop index PREISKUJE_FK;

drop index ODREDI_FK;

drop index ODREJENE_PREISKAVE_PK;

drop table ODREJENE_PREISKAVE;

drop index ZIVI_NA_FK;

drop index OSEBA_PK;

drop table OSEBA;

drop index ZAHTEVA_FK;

drop index PLACANE_PREISKAVE_PREISKUJE_FK;

drop index PLACANE_PREISKAVE_PK;

drop table PLACANE_PREISKAVE;

drop index PRICAKUJE_FK;

drop index PREISKAVA_PK;

drop table PREISKAVA;

drop index IMA_REFERENCO_Z_FK;

drop index IMA_REFERENCO_M_FK;

drop index PRICAKOVANA_VREDNOST_PK;

drop table PRICAKOVANA_VREDNOST;

drop index REFERENCA_MOSKI_PK;

drop table REFERENCA_MOSKI;

drop index REFERENCA_ZENSKE_PK;

drop table REFERENCA_ZENSKE;

drop index SAMOPLACNIK_IMA_PODATKE_FK;

drop index SAMOPLACNIK_PK;

drop table SAMOPLACNIK;

drop index SLOVENSKI_ICD_PK;

drop table SLOVENSKI_ICD;

drop index ZAVAROVANEC_IMA_PODATKE_FK;

drop index ZAVAROVANEC_PK;

drop table ZAVAROVANEC;

/*==============================================================*/
/* Table: ANGLESKI_ICD                                          */
/*==============================================================*/
create table ANGLESKI_ICD (
   ICD_SIFRA            VARCHAR(100)         null,
   ICD_OPIS_A           TEXT                 null,
   ICD_OPIS_SLO_A       TEXT                 null,
   ANG_ICD_ID           INT4                 not null,
   constraint PK_ANGLESKI_ICD primary key (ANG_ICD_ID)
);

/*==============================================================*/
/* Index: ANGLESKI_ICD_PK                                       */
/*==============================================================*/
create unique index ANGLESKI_ICD_PK on ANGLESKI_ICD (
ANG_ICD_ID
);

/*==============================================================*/
/* Table: CAKALNA_VRSTA                                         */
/*==============================================================*/
create table CAKALNA_VRSTA (
   ST_OBRAVNAVE         INT4                 not null,
   ODDELEK_ID           INT4                 not null,
   CAS_VPISA            DATE                 null,
   PREDVIDEN_CAS_SPREJEMA DATE                 null,
   CAS_SPREJEMA         DATE                 null,
   constraint PK_CAKALNA_VRSTA primary key (ST_OBRAVNAVE, ODDELEK_ID)
);

/*==============================================================*/
/* Index: CAKALNA_VRSTA_PK                                      */
/*==============================================================*/
create unique index CAKALNA_VRSTA_PK on CAKALNA_VRSTA (
ST_OBRAVNAVE,
ODDELEK_ID
);

/*==============================================================*/
/* Index: JE_VKLJUCENA_V_FK                                     */
/*==============================================================*/
create  index JE_VKLJUCENA_V_FK on CAKALNA_VRSTA (
ST_OBRAVNAVE
);

/*==============================================================*/
/* Index: PRIPADA_FK                                            */
/*==============================================================*/
create  index PRIPADA_FK on CAKALNA_VRSTA (
ODDELEK_ID
);

/*==============================================================*/
/* Table: DIAGNOZA                                              */
/*==============================================================*/
create table DIAGNOZA (
   DIAGNOZA_ID          SERIAL               not null,
   ST_OBRAVNAVE         INT4                 not null,
   ICD_MED_ID           INT4                 null,
   ANG_ICD_ID           INT4                 null,
   SLO_ICD_ID           INT4                 null,
   SLOVENSKO_IME        CHAR(100)            not null,
   ANGLESKO_IME         CHAR(100)            not null,
   constraint PK_DIAGNOZA primary key (DIAGNOZA_ID)
);

/*==============================================================*/
/* Index: DIAGNOZA_PK                                           */
/*==============================================================*/
create unique index DIAGNOZA_PK on DIAGNOZA (
DIAGNOZA_ID
);

/*==============================================================*/
/* Index: IMA_POSTAVLJENO_FK                                    */
/*==============================================================*/
create  index IMA_POSTAVLJENO_FK on DIAGNOZA (
ST_OBRAVNAVE
);

/*==============================================================*/
/* Index: IMA_SLO_INDENTIFIKATOR_FK                             */
/*==============================================================*/
create  index IMA_SLO_INDENTIFIKATOR_FK on DIAGNOZA (
SLO_ICD_ID
);

/*==============================================================*/
/* Index: IMA_ANG_INDENTIFIKATOR_FK                             */
/*==============================================================*/
create  index IMA_ANG_INDENTIFIKATOR_FK on DIAGNOZA (
ANG_ICD_ID
);

/*==============================================================*/
/* Index: IMA_MEDNARODNI_FK                                     */
/*==============================================================*/
create  index IMA_MEDNARODNI_FK on DIAGNOZA (
ICD_MED_ID
);

/*==============================================================*/
/* Table: MEDNARODNI_ICD                                        */
/*==============================================================*/
create table MEDNARODNI_ICD (
   ICD_SIFRA            VARCHAR(100)         null,
   ICD_OPIS_M           TEXT                 null,
   ICD_OPIS_SLO_M       TEXT                 null,
   ICD_MED_ID           INT4                 not null,
   constraint PK_MEDNARODNI_ICD primary key (ICD_MED_ID)
);

/*==============================================================*/
/* Index: MEDNARODNI_ICD_PK                                     */
/*==============================================================*/
create unique index MEDNARODNI_ICD_PK on MEDNARODNI_ICD (
ICD_MED_ID
);

/*==============================================================*/
/* Table: NASLOV                                                */
/*==============================================================*/
create table NASLOV (
   NASLOV_ID            INT4                 not null,
   HISNA_ST             INT4                 null,
   HISNA_OZNAKA         CHAR(1)              null,
   ULICA                VARCHAR(30)          null,
   KRAJ                 VARCHAR(20)          null,
   POSTNA_ST            NUMERIC(4)           null,
   constraint PK_NASLOV primary key (NASLOV_ID)
);

/*==============================================================*/
/* Index: NASLOV_PK                                             */
/*==============================================================*/
create unique index NASLOV_PK on NASLOV (
NASLOV_ID
);

/*==============================================================*/
/* Table: OBRAVNAVA                                             */
/*==============================================================*/
create table OBRAVNAVA (
   ST_OBRAVNAVE         INT4                 not null,
   KZZS                 INT4                 not null,
   CAS_ZACETKA          DATE                 null,
   CAS_ZAKLJUCKA        DATE                 null,
   constraint PK_OBRAVNAVA primary key (ST_OBRAVNAVE)
);

/*==============================================================*/
/* Index: OBRAVNAVA_PK                                          */
/*==============================================================*/
create unique index OBRAVNAVA_PK on OBRAVNAVA (
ST_OBRAVNAVE
);

/*==============================================================*/
/* Index: IMA_DODELJENO_FK                                      */
/*==============================================================*/
create  index IMA_DODELJENO_FK on OBRAVNAVA (
KZZS
);

/*==============================================================*/
/* Table: ODDELEK                                               */
/*==============================================================*/
create table ODDELEK (
   ODDELEK_ID           SERIAL               not null,
   ODDELEK_AKTIVEN      CHAR(1)              null,
   ODDELEK_IME          CHAR(20)             null,
   constraint PK_ODDELEK primary key (ODDELEK_ID)
);

/*==============================================================*/
/* Index: ODDELEK_PK                                            */
/*==============================================================*/
create unique index ODDELEK_PK on ODDELEK (
ODDELEK_ID
);

/*==============================================================*/
/* Table: ODREJENE_PREISKAVE                                    */
/*==============================================================*/
create table ODREJENE_PREISKAVE (
   ST_OBRAVNAVE         INT4                 not null,
   PREISKAVA_ID         INT4                 not null,
   DATUM_ODREDBE        DATE                 null,
   ODREJENE_REZULTAT_PREISKAVE FLOAT8               null,
   PLACANE_PREISKAVE_OPOMBA TEXT                 null,
   constraint PK_ODREJENE_PREISKAVE primary key (ST_OBRAVNAVE, PREISKAVA_ID)
);

/*==============================================================*/
/* Index: ODREJENE_PREISKAVE_PK                                 */
/*==============================================================*/
create unique index ODREJENE_PREISKAVE_PK on ODREJENE_PREISKAVE (
ST_OBRAVNAVE,
PREISKAVA_ID
);

/*==============================================================*/
/* Index: ODREDI_FK                                             */
/*==============================================================*/
create  index ODREDI_FK on ODREJENE_PREISKAVE (
ST_OBRAVNAVE
);

/*==============================================================*/
/* Index: PREISKUJE_FK                                          */
/*==============================================================*/
create  index PREISKUJE_FK on ODREJENE_PREISKAVE (
PREISKAVA_ID
);

/*==============================================================*/
/* Table: OSEBA                                                 */
/*==============================================================*/
create table OSEBA (
   OSEBA_ID             INT4                 not null,
   NASLOV_ID            INT4                 not null,
   IME                  CHAR(20)             null,
   PRIIMEK              CHAR(20)             null,
   DRUGA_IMENA          TEXT                 null,
   SPOL                 CHAR(1)              null,
   DATUM_ROJSTVA        DATE                 null,
   constraint PK_OSEBA primary key (OSEBA_ID)
);

/*==============================================================*/
/* Index: OSEBA_PK                                              */
/*==============================================================*/
create unique index OSEBA_PK on OSEBA (
OSEBA_ID
);

/*==============================================================*/
/* Index: ZIVI_NA_FK                                            */
/*==============================================================*/
create  index ZIVI_NA_FK on OSEBA (
NASLOV_ID
);

/*==============================================================*/
/* Table: PLACANE_PREISKAVE                                     */
/*==============================================================*/
create table PLACANE_PREISKAVE (
   PREISKAVA_ID         INT4                 not null,
   EMSO                 NUMERIC(14)          not null,
   DATUM_PLACILA        DATE                 null,
   PLACANE_PREISKAVE_DATUM_ZAHTEVE DATE                 null,
   PLACANE_PREISKAVE_OPOMBA TEXT                 null,
   PLACANE_REZULTAT_PREISKAVE FLOAT8               null,
   constraint PK_PLACANE_PREISKAVE primary key (PREISKAVA_ID, EMSO)
);

/*==============================================================*/
/* Index: PLACANE_PREISKAVE_PK                                  */
/*==============================================================*/
create unique index PLACANE_PREISKAVE_PK on PLACANE_PREISKAVE (
PREISKAVA_ID,
EMSO
);

/*==============================================================*/
/* Index: PLACANE_PREISKAVE_PREISKUJE_FK                        */
/*==============================================================*/
create  index PLACANE_PREISKAVE_PREISKUJE_FK on PLACANE_PREISKAVE (
PREISKAVA_ID
);

/*==============================================================*/
/* Index: ZAHTEVA_FK                                            */
/*==============================================================*/
create  index ZAHTEVA_FK on PLACANE_PREISKAVE (
EMSO
);

/*==============================================================*/
/* Table: PREISKAVA                                             */
/*==============================================================*/
create table PREISKAVA (
   PREISKAVA_ID         INT4                 not null,
   PRICAKOVANA_VREDNOST_ID INT4                 not null,
   CENA_ZA_SAMOPLACNIKE MONEY                null,
   PREISKAVA_IME        CHAR(20)             null,
   constraint PK_PREISKAVA primary key (PREISKAVA_ID)
);

/*==============================================================*/
/* Index: PREISKAVA_PK                                          */
/*==============================================================*/
create unique index PREISKAVA_PK on PREISKAVA (
PREISKAVA_ID
);

/*==============================================================*/
/* Index: PRICAKUJE_FK                                          */
/*==============================================================*/
create  index PRICAKUJE_FK on PREISKAVA (
PRICAKOVANA_VREDNOST_ID
);

/*==============================================================*/
/* Table: PRICAKOVANA_VREDNOST                                  */
/*==============================================================*/
create table PRICAKOVANA_VREDNOST (
   PRICAKOVANA_VREDNOST_ID SERIAL               not null,
   REFERENCA_ZENSKE_ID  INT4                 null,
   REFERENCA_MOSKI_ID   INT4                 null,
   DOPUSTNA_MIN         FLOAT8               null,
   DOPUSTNA_MAX         FLOAT8               null,
   constraint PK_PRICAKOVANA_VREDNOST primary key (PRICAKOVANA_VREDNOST_ID)
);

/*==============================================================*/
/* Index: PRICAKOVANA_VREDNOST_PK                               */
/*==============================================================*/
create unique index PRICAKOVANA_VREDNOST_PK on PRICAKOVANA_VREDNOST (
PRICAKOVANA_VREDNOST_ID
);

/*==============================================================*/
/* Index: IMA_REFERENCO_M_FK                                    */
/*==============================================================*/
create  index IMA_REFERENCO_M_FK on PRICAKOVANA_VREDNOST (
REFERENCA_MOSKI_ID
);

/*==============================================================*/
/* Index: IMA_REFERENCO_Z_FK                                    */
/*==============================================================*/
create  index IMA_REFERENCO_Z_FK on PRICAKOVANA_VREDNOST (
REFERENCA_ZENSKE_ID
);

/*==============================================================*/
/* Table: REFERENCA_MOSKI                                       */
/*==============================================================*/
create table REFERENCA_MOSKI (
   REFERENCA_MOSKI_ID   SERIAL               not null,
   MOSKI_MIN            FLOAT8               null,
   MOSKI_MAX            FLOAT8               null,
   DATUM_VNOSA          DATE                 null,
   constraint PK_REFERENCA_MOSKI primary key (REFERENCA_MOSKI_ID)
);

/*==============================================================*/
/* Index: REFERENCA_MOSKI_PK                                    */
/*==============================================================*/
create unique index REFERENCA_MOSKI_PK on REFERENCA_MOSKI (
REFERENCA_MOSKI_ID
);

/*==============================================================*/
/* Table: REFERENCA_ZENSKE                                      */
/*==============================================================*/
create table REFERENCA_ZENSKE (
   REFERENCA_ZENSKE_ID  SERIAL               not null,
   ZENSKE_MIN           FLOAT8               null,
   ZENSKE_MAX           FLOAT8               null,
   DATUM_VNOSA          DATE                 null,
   constraint PK_REFERENCA_ZENSKE primary key (REFERENCA_ZENSKE_ID)
);

/*==============================================================*/
/* Index: REFERENCA_ZENSKE_PK                                   */
/*==============================================================*/
create unique index REFERENCA_ZENSKE_PK on REFERENCA_ZENSKE (
REFERENCA_ZENSKE_ID
);

/*==============================================================*/
/* Table: SAMOPLACNIK                                           */
/*==============================================================*/
create table SAMOPLACNIK (
   EMSO                 NUMERIC(14)          not null,
   OSEBA_ID             INT4                 null,
   DATUM_VNOSA          DATE                 null,
   constraint PK_SAMOPLACNIK primary key (EMSO)
);

/*==============================================================*/
/* Index: SAMOPLACNIK_PK                                        */
/*==============================================================*/
create unique index SAMOPLACNIK_PK on SAMOPLACNIK (
EMSO
);

/*==============================================================*/
/* Index: SAMOPLACNIK_IMA_PODATKE_FK                            */
/*==============================================================*/
create  index SAMOPLACNIK_IMA_PODATKE_FK on SAMOPLACNIK (
OSEBA_ID
);

/*==============================================================*/
/* Table: SLOVENSKI_ICD                                         */
/*==============================================================*/
create table SLOVENSKI_ICD (
   ICD_SIFRA            VARCHAR(100)         null,
   ICD_OPIS_S           TEXT                 null,
   ICD_OPIS_SLO_S       TEXT                 null,
   SLO_ICD_ID           INT4                 not null,
   constraint PK_SLOVENSKI_ICD primary key (SLO_ICD_ID),
   constraint AK_UNIQUE_GLOBAL_CODE_SLOVENSK unique (ICD_SIFRA)
);

/*==============================================================*/
/* Index: SLOVENSKI_ICD_PK                                      */
/*==============================================================*/
create unique index SLOVENSKI_ICD_PK on SLOVENSKI_ICD (
SLO_ICD_ID
);

/*==============================================================*/
/* Table: ZAVAROVANEC                                           */
/*==============================================================*/
create table ZAVAROVANEC (
   KZZS                 INT4                 not null,
   OSEBA_ID             INT4                 null,
   DATUM_VNOSA          DATE                 null,
   DODATNO_ZAVAROVANJE  CHAR(1)              null,
   constraint PK_ZAVAROVANEC primary key (KZZS)
);

/*==============================================================*/
/* Index: ZAVAROVANEC_PK                                        */
/*==============================================================*/
create unique index ZAVAROVANEC_PK on ZAVAROVANEC (
KZZS
);

/*==============================================================*/
/* Index: ZAVAROVANEC_IMA_PODATKE_FK                            */
/*==============================================================*/
create  index ZAVAROVANEC_IMA_PODATKE_FK on ZAVAROVANEC (
OSEBA_ID
);

alter table CAKALNA_VRSTA
   add constraint FK_CAKALNA__JE_VKLJUC_OBRAVNAV foreign key (ST_OBRAVNAVE)
      references OBRAVNAVA (ST_OBRAVNAVE)
      on delete restrict on update restrict;

alter table CAKALNA_VRSTA
   add constraint FK_CAKALNA__PRIPADA_ODDELEK foreign key (ODDELEK_ID)
      references ODDELEK (ODDELEK_ID)
      on delete restrict on update restrict;

alter table DIAGNOZA
   add constraint FK_DIAGNOZA_IMA_ANG_I_ANGLESKI foreign key (ANG_ICD_ID)
      references ANGLESKI_ICD (ANG_ICD_ID)
      on delete restrict on update restrict;

alter table DIAGNOZA
   add constraint FK_DIAGNOZA_IMA_MEDNA_MEDNAROD foreign key (ICD_MED_ID)
      references MEDNARODNI_ICD (ICD_MED_ID)
      on delete restrict on update restrict;

alter table DIAGNOZA
   add constraint FK_DIAGNOZA_IMA_POSTA_OBRAVNAV foreign key (ST_OBRAVNAVE)
      references OBRAVNAVA (ST_OBRAVNAVE)
      on delete restrict on update restrict;

alter table DIAGNOZA
   add constraint FK_DIAGNOZA_IMA_SLO_I_SLOVENSK foreign key (SLO_ICD_ID)
      references SLOVENSKI_ICD (SLO_ICD_ID)
      on delete restrict on update restrict;

alter table OBRAVNAVA
   add constraint FK_OBRAVNAV_IMA_DODEL_ZAVAROVA foreign key (KZZS)
      references ZAVAROVANEC (KZZS)
      on delete restrict on update restrict;

alter table ODREJENE_PREISKAVE
   add constraint FK_ODREJENE_ODREDI_OBRAVNAV foreign key (ST_OBRAVNAVE)
      references OBRAVNAVA (ST_OBRAVNAVE)
      on delete restrict on update restrict;

alter table ODREJENE_PREISKAVE
   add constraint FK_ODREJENE_PREISKUJE_PREISKAV foreign key (PREISKAVA_ID)
      references PREISKAVA (PREISKAVA_ID)
      on delete restrict on update restrict;

alter table OSEBA
   add constraint FK_OSEBA_ZIVI_NA_NASLOV foreign key (NASLOV_ID)
      references NASLOV (NASLOV_ID)
      on delete restrict on update restrict;

alter table PLACANE_PREISKAVE
   add constraint FK_PLACANE__PLACANE_P_PREISKAV foreign key (PREISKAVA_ID)
      references PREISKAVA (PREISKAVA_ID)
      on delete restrict on update restrict;

alter table PLACANE_PREISKAVE
   add constraint FK_PLACANE__ZAHTEVA_SAMOPLAC foreign key (EMSO)
      references SAMOPLACNIK (EMSO)
      on delete restrict on update restrict;

alter table PREISKAVA
   add constraint FK_PREISKAV_PRICAKUJE_PRICAKOV foreign key (PRICAKOVANA_VREDNOST_ID)
      references PRICAKOVANA_VREDNOST (PRICAKOVANA_VREDNOST_ID)
      on delete restrict on update restrict;

alter table PRICAKOVANA_VREDNOST
   add constraint FK_PRICAKOV_REFERENC_M foreign key (REFERENCA_MOSKI_ID)
      references REFERENCA_MOSKI (REFERENCA_MOSKI_ID)
      on delete restrict on update restrict;

alter table PRICAKOVANA_VREDNOST
   add constraint FK_PRICAKOV_REFERENC_Z foreign key (REFERENCA_ZENSKE_ID)
      references REFERENCA_ZENSKE (REFERENCA_ZENSKE_ID)
      on delete restrict on update restrict;

alter table SAMOPLACNIK
   add constraint FK_SAMOPLAC_SAMOPLACN_OSEBA foreign key (OSEBA_ID)
      references OSEBA (OSEBA_ID)
      on delete restrict on update restrict;

alter table ZAVAROVANEC
   add constraint FK_ZAVAROVA_ZAVAROVAN_OSEBA foreign key (OSEBA_ID)
      references OSEBA (OSEBA_ID)
      on delete restrict on update restrict;

