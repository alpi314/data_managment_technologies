/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     10/31/2022 5:22:51 PM                        */
/*==============================================================*/


drop index PRIPADA_FK;

drop index JE_VKLJUCENA_V_FK;

drop index CAKALNA_VRSTA_PK;

drop table CAKALNA_VRSTA;

drop index JE_KVALIFICIRANA_Z_FK;

drop index IMA_POSTAVLJENO_FK;

drop index DIAGNOZA_PK;

drop table DIAGNOZA;

drop index ICD_PK;

drop table ICD;

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

drop index ZA_ZENSKE_PRICAKUJE_FK;

drop index ZA_MOSKE_PRICAKUJE_FK;

drop index PRICAKOVANA_VREDNOST_PK;

drop table PRICAKOVANA_VREDNOST;

drop index REFERENCA_MOSKI_PK;

drop table REFERENCA_MOSKI;

drop index REFERENCA_ZENSKE_PK;

drop table REFERENCA_ZENSKE;

drop index SAMOPLACNIK_PK;

drop table SAMOPLACNIK;

drop index ZAVAROVANEC_PK;

drop table ZAVAROVANEC;

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
   ICD_ID               INT4                 not null,
   ST_OBRAVNAVE         INT4                 not null,
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
/* Index: JE_KVALIFICIRANA_Z_FK                                 */
/*==============================================================*/
create  index JE_KVALIFICIRANA_Z_FK on DIAGNOZA (
ICD_ID
);

/*==============================================================*/
/* Table: ICD                                                   */
/*==============================================================*/
create table ICD (
   ICD_ID               SERIAL               not null,
   ICD_SIFRA            VARCHAR(100)         null,
   ICD_SISTEM           VARCHAR(100)         null,
   ICD_OPIS             TEXT                 null,
   constraint PK_ICD primary key (ICD_ID)
);

/*==============================================================*/
/* Index: ICD_PK                                                */
/*==============================================================*/
create unique index ICD_PK on ICD (
ICD_ID
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
   OSEBA_ID             INT4                 not null,
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
OSEBA_ID
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
   OSEBA_ID             INT4                 not null,
   DATUM_PLACILA        DATE                 null,
   PLACANE_PREISKAVE_DATUM_ZAHTEVE DATE                 null,
   PLACANE_PREISKAVE_OPOMBA TEXT                 null,
   PLACANE_REZULTAT_PREISKAVE FLOAT8               null,
   constraint PK_PLACANE_PREISKAVE primary key (PREISKAVA_ID, OSEBA_ID)
);

/*==============================================================*/
/* Index: PLACANE_PREISKAVE_PK                                  */
/*==============================================================*/
create unique index PLACANE_PREISKAVE_PK on PLACANE_PREISKAVE (
PREISKAVA_ID,
OSEBA_ID
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
OSEBA_ID
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
   REFERENCA_MOSKI_ID   INT4                 null,
   REFERENCA_ZENSKE_ID  INT4                 null,
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
/* Index: ZA_MOSKE_PRICAKUJE_FK                                 */
/*==============================================================*/
create  index ZA_MOSKE_PRICAKUJE_FK on PRICAKOVANA_VREDNOST (
REFERENCA_MOSKI_ID
);

/*==============================================================*/
/* Index: ZA_ZENSKE_PRICAKUJE_FK                                */
/*==============================================================*/
create  index ZA_ZENSKE_PRICAKUJE_FK on PRICAKOVANA_VREDNOST (
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
   OSEBA_ID             INT4                 not null,
   EMSO                 NUMERIC(14)          not null,
   DATUM_VNOSA          DATE                 null,
   constraint PK_SAMOPLACNIK primary key (OSEBA_ID)
);

/*==============================================================*/
/* Index: SAMOPLACNIK_PK                                        */
/*==============================================================*/
create unique index SAMOPLACNIK_PK on SAMOPLACNIK (
OSEBA_ID
);

/*==============================================================*/
/* Table: ZAVAROVANEC                                           */
/*==============================================================*/
create table ZAVAROVANEC (
   OSEBA_ID             INT4                 not null,
   KZZS                 INT4                 null,
   DATUM_VNOSA          DATE                 null,
   DODATNO_ZAVAROVANJE  CHAR(1)              null,
   constraint PK_ZAVAROVANEC primary key (OSEBA_ID)
);

/*==============================================================*/
/* Index: ZAVAROVANEC_PK                                        */
/*==============================================================*/
create unique index ZAVAROVANEC_PK on ZAVAROVANEC (
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
   add constraint FK_DIAGNOZA_IMA_POSTA_OBRAVNAV foreign key (ST_OBRAVNAVE)
      references OBRAVNAVA (ST_OBRAVNAVE)
      on delete restrict on update restrict;

alter table DIAGNOZA
   add constraint FK_DIAGNOZA_JE_KVALIF_ICD foreign key (ICD_ID)
      references ICD (ICD_ID)
      on delete restrict on update restrict;

alter table OBRAVNAVA
   add constraint FK_OBRAVNAV_IMA_DODEL_ZAVAROVA foreign key (OSEBA_ID)
      references ZAVAROVANEC (OSEBA_ID)
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
   add constraint FK_PLACANE__ZAHTEVA_SAMOPLAC foreign key (OSEBA_ID)
      references SAMOPLACNIK (OSEBA_ID)
      on delete restrict on update restrict;

alter table PREISKAVA
   add constraint FK_PREISKAV_PRICAKUJE_PRICAKOV foreign key (PRICAKOVANA_VREDNOST_ID)
      references PRICAKOVANA_VREDNOST (PRICAKOVANA_VREDNOST_ID)
      on delete restrict on update restrict;

alter table PRICAKOVANA_VREDNOST
   add constraint FK_PRICAKOV_ZA_MOSKE__REFERENC foreign key (REFERENCA_MOSKI_ID)
      references REFERENCA_MOSKI (REFERENCA_MOSKI_ID)
      on delete restrict on update restrict;

alter table PRICAKOVANA_VREDNOST
   add constraint FK_PRICAKOV_ZA_ZENSKE_REFERENC foreign key (REFERENCA_ZENSKE_ID)
      references REFERENCA_ZENSKE (REFERENCA_ZENSKE_ID)
      on delete restrict on update restrict;

alter table SAMOPLACNIK
   add constraint FK_SAMOPLAC_JE_OSEBA foreign key (OSEBA_ID)
      references OSEBA (OSEBA_ID)
      on delete restrict on update restrict;

alter table ZAVAROVANEC
   add constraint FK_ZAVAROVA_JE2_OSEBA foreign key (OSEBA_ID)
      references OSEBA (OSEBA_ID)
      on delete restrict on update restrict;

