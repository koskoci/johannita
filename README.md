[![Coverage Status](https://coveralls.io/repos/github/koskoci/johannita/badge.svg?branch=master)](https://coveralls.io/github/koskoci/johannita?branch=master)

Johannita Segito szolgalat web app

Regi [wordpress site](http://johannitak.hu/segito-szolgalat)

## Hirfolyam

  * HIR - cim, tartalom, kep
  * ~ebbol legutolso 4~ lekuldom mindet
  * GET list
  * ADMIN USER - POST, PATCH, DELETE

## A Segito Szolgalat

  * statikus, ugyan azok, mint eddig, picit mas tartalom, kepeket betenni ide-oda
  * Johanniter International terkepre kattintva adott orszag honlapjara link
  * ritkan update-elendo

## Kiemelt tevekenysegeink

  * statikus, ugyan azok, mint eddig, picit mas tartalom, kepeket betenni ide-oda
  * Eszkozkolcsonzes - raktarkezelo program van, van-e API?
  * Mentoszolgalat - shiftek szervezese jelenleg Google Spreadsheets-ben
    * jovoben majd: esetleg behozni ide, (emailben) ertesiteni az onkentest, h jovo kedden te leszel
  * ritkan update-elendo

## Szamitunk rad! - Jelentkezes

  ### 1. Jelentkezes Kepzesre

  * 1.1 Katasztrofavedelmi kepzes
    * MEGHIRD
      * evente ADMIN kiirja az idopontot
      * USER jelentkezik
    * KULSOS is jelentkezhet (<- regisztralni kell)
    * CV + motiv. level feltolt (-> ELKULD)
    * pszihologiai alkalmassagi vizsga (belsos, 3 ora)
    * -> mehet

  * 1.2 Elsosegely-kepzes

    * 1.2.1 Egyedi/csoportos igenyek
      * Munkahelyi kepzes
      * Ovisoknak mentoauto-simogato
      * Altalanos sutyó (iskola)
      * Folyamat: please call

    * 1.2.2 Kismamaknak (SEO?)
      * egyeni jelentkezes
      * elore meghirdetett idopontra, indul, ha 10-nel tobben
      * MEGHIRD
        * ADMIN megadja az idopontot
        * USER jelentkezesi hatarido utan kap ertesitest, hogy elindul-e a kepzes

    * 1.2.3 Ujraelesztes-kepzes (BLS-ARD)
      * mint Kismama

    * 1.2.4 Otthonapolasi tanfolyam
      * mint Kismama

    * 1.2.5 Alapszintu elsosegely-kepzes
      * feltetele nincs
      * Kozepisk, Egyetem, etc.
        * nem honlapon keresztul jelentkeznek
      * MEGHIRD
        * egyeni jelentkezes folyamata mint Kismama
      * -> elvegezheti az Ugyeleti modult
      * statuszok
        * jelentkezett (app csinalja egyeninek, csoportosnak nincs)
        * vizsgat tett
          * ADMIN regisztralja egyeninek / csoportosnak is (-> HOGYAN?))

    * 1.2.6 Ugyeleti modul
      * feltetele az Alapszint vizsga
      * -> Rendezvenyen mehet ugyeletbe
      * Folyamat
        * mint Kismama
      * statuszok
        * jelentkezett (app csinalja egyeninek, csoportosnak nincs)
        * sikeres vizsgat ADMIN regisztralja egyeninek / csoportosnak is (-> HOGYAN?))
        * aktiv
          * ugyeleti vizsgat tett 1,5 even belul
          * ugyeleti ismetlovizsgat tett 1,5 even belul es volt 2-szer ugyeleten
        * passziv
          * ismetlo vizsgat nem tett idoben (1,5 evvel elso vizsga utan)
          * vagy nem volt 2-szer ugyeletben

    * 1.2.7 Emelt szint
      * feltetele az Ugyeleti modul
      * -> Mentõn szekundalhat
      * statuszok
        * aktiv
          * emelt szintu vizsgat tett 1,5 even belul
          * emelt ismetlovizsgat tett 1,5 even belul es volt 2-szer ugyeleten es 2-szer szekundalni
        * passziv
          * ismetlo vizsgat nem tett idoben (1,5 evvel elso vizsga utan)
          * vagy nem volt 2-szer ugyeletben es 2-szer szekundalni

  ### 2. Jelentkezes Onkentes Lehetosegekre

  * 2.1 Elsosegely ugyelet
    * feltetele: Ugyeleti modul
    * kimenete: 2 teljesitett ugyelet evente feltetele az aktiv elsosegelynyujto statusznak
  * 2.2 Mento szekundalas
    * ez a csucspontja az elsosegely-tanfolyamoknak
    * (ld. emelt szint)
    * ? egeszsegugyi alkalmassagi (kulsos ceg)
      * ha kell, u. az, mint lent
  * 2.3 Mentoszolgalathoz (eü. dolgozo, havonta nehany jel.)
    * Jelentkezes
      * KULSOS is jelentkezhet (<- regisztralni kell)
      * CV + motiv. level feltolt
      * formanyomtatvany (-> ELKULD)
      * szemelyes elbesz
      * szerzodeskotes (-> SZERZODESES ONKENTES)
    * egeszsegugyi alkalmassagi (kulsos ceg)
      * (Nice to have: feltoltes (pdf/jpg))
      * lejarati datum kitoltese
        * 1 honappal lejarat elott email (ADMINnak es usernek)
        * Meg egy email, ha lejart
    * ha mindez megvan -> szekundalas (-> utana lesz "mentoszolgalati onkentes")
  * 2.4 Taborokba onkentes
    TBD
  * 2.5 Idosek latogatasa, Fogyatekkal elok latogatasa
    * Jelentkezes
      * mint Mentoszolgalathoz
  * 2.6 Ad hoc alkalom (pl. arviz)
    * Jelentkezes
      * mint Mentoszolgalathoz kiveve a motivacios levelet
  * 2.7 Ifjusagi szervezet (nem teljesen onkentes alkalom)
    * KULSOS is jelentkezhet (<- regisztralni kell)
      * formanyomtatvany (-> ELKULD)

## Tamogatas

  pl. mint baptistasegely.hu

## Hirlevel

  honlapon keresztul?

## Taborozasi lehetoseg

  * tabor terkepe, kattintva info, foglalas
    * jelentkezesi lap

## TBD
  * sikeres vizsgat ADMIN hogy viszi be a rendszerbe
    * kulonosen csoportos, nem appon keresztuli jelentkezoknek (Kozepisk., Egyetem)
  * jelenleti ivek automatizalasa (alairni kell)

## Megj.
  * Oktatasi anyagok jelenleg Google Docs-ban
    * Lehetne a honlapon hostolni ezeket TAGoknak
    * Lehetne dinamikus (feleletvalasztos) teszteket csinalni
  * Munkahelyi elsosegely kepzes ervenyessege 2 evente lejar
    * Kuldeni emailt munkaltatonak errol
  * Ugyeleti modul lejar
    * Kuldeni emailt eves ismetlo vizsgarol

## USER-hierarchia
  * ADMIN (hirt ir, statikus kontentet szerkeszt, egy v. ket ember lesz)
  * TAGOK
    * RENDES (KOZGYULESI) TAG
    * SIMA (HELYI SZERVEZETI) TAG
  * ONKENTESEK
    * SZERZODESES ONKENTES (SIMA TAG vagy RENDES TAG is)
    * ALKALMI ONKENTES (nem TAG)
  * KULSOS (pl. tabort berel ki, kepzesen hallgato, tamogatast ad)

## Profil
  * sajat adataim
    * szemelyes adatok (nev, jogsi?, vezethet?, PAV?, PAV datum?, kell-e egeszsegugyi alk.? ha igen, datum?)
    * statusz adatok (kepzes jel., vizsgazott, aktiv statuszok)
  * ADMIN reszere teljes user lista

## Regisztracio
  * neve
  * (anyja neve)
  * email
  * (szul. datum)