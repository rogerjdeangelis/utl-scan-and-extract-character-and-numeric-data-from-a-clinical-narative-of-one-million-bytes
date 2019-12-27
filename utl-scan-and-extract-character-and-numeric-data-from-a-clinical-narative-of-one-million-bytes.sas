Scan and extract character and numeric data from a clinical narative of one million bytes;

Imbeded in a very long clinical narative are bigrams containing state abreviations followed by average
age of the state population.

For instance  string  ' AL 25 ' id somewhere in the million character narrative;

github
https://tinyurl.com/wqaa76r
https://github.com/rogerjdeangelis/utl-scan-and-extract-character-and-numeric-data-from-a-clinical-narative-of-one-million-bytes

other github
https://github.com/rogerjdeangelis?utf8=%E2%9C%93&tab=repositories&q=32&type=&language=

related to to
https://tinyurl.com/qw4ubvg
https://communities.sas.com/t5/SAS-Data-Management/Finding-Strings-Exact-or-Partial-Match-in-a-Line/m-p/613762

Note States50 and states50q are defined in my autoexec

%let states50= %sysfunc(compbl(AL AK AZ AR CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT
NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV WI WY)) ;

%let states50q="AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT",
"NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY";


Tried
  rewind (only works with tape file, however may work in unix because a tape file and disk file can be the same?)
  frewind (almost worked but cannot use '@' to scan the buffer?.

Methon
      1. cocatenate the narrative into one long 1,000,000 byte record.
         Need this to handle strings that cross a record.
      2. Use input @'Az' to search al 1,000,000 bytes.
      3. Use dosubl to do a rewind
*_                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

Approximately a 1 million character long nariative;

data _null_;
  array states $2 &states50 (&states50q);
  length txt $1700 lyn $200;;
  txt=compbl('
       SUPPLY OF MANPOWER AS PER PROFORMA INVOICE DATED 14.01.2019
       ,1. SIGNED COMMERCIAL INVOICE(S) IN 1 ORIGINAL AND 2 COPIES
       ,SHOWING DATE OF SUPPLY OF MANPOWER NOT LATER THAN 15.05.2019 AND
       ,DULY COUNTERSIGNED BY APPLICANTS AUTHORIZED SIGNATORY AND TO BE
       ,AUTHENTICATED BY IRAN NATIONAL BANK  ERAN TRADE FINANCE DEPARTMENT
       ,PRIOR PRESENTATION OF DOCS FOR NEGOTIATION.
       ,IN THE ABSENCE OF DATE OF SUPPLY OF MANPOWER  THE DATE SHOWN ON
       ,COMMERCIAL INVOICE WILL BE CONSIDERED AS THE SUPPLY DATE for DAWOOD HASSAN. USD 120/
       , OR EQUIVALENT IN THE L/C CURRENCY AND RELATED
       ,CHARGES SHOULD BE DEDUCTED FROM THE PAYMENT FOR EACH PRESENTATION by DAWOOD HASAN
       ,OF DISCREPANT DOCUMENTS UNDER THIS CREDIT  NOT WITHSTANDING ANY
       ,INSTRUCTION TO THE CONTRARY  THIS CHARGE SHALL BE FOR THE ACCOUNT
       ,OF BENEFICIARY 202 577688-001-0010-000  BIC: PIBPBG2L
       ,2. BENEFICIARYS A/C NO.: 202 577688-001-0010-000  BIC: PIBPBG2L
       ,APPLICANT ACCOUNT. ALL OTHER
       ,CHARGES INCLUDING REIMBURSEMENT AND
       ,SWIFT PAYMENTS RELATED CHARGES
       ,FOR BENEFICIARY ACCOUNT in SYRIA
       ,WITHOUT DESPATCH FULL SET OF PRESENTED / NEGOTIATED DOCUMENTS IN ONE LOT
       ,BY COURIER TO: QATAR NATIONAL BANK  MAIN OFFICE  GRAND HAMAD
       ,STREET  TRADE FINANCE DEPARTMENT  IMPORTS SECTION  P.O. BOX 1000
       ,DOHA  QATAR. 202 577688-001-0010-000  BIC: PIBPBG2L
       ,++UPON RECEIPT OF CREDIT COMPLYING DOCUMENTS OSMA BIN LADEN PAYMENT SHALL BE
       ,EFFECTED BY US AS PER PRESENTING BANKS INSTRUCTION.
       ,DOHA  QATAR. 202 577688-001-0010-000  BIC: PIBPBG2L
       ,++UPON RECEIPT OF CREDIT COMPLYING DOCUMENTS OSMA BIN LADEN PAYMENT SHALL BE
       ,EFFECTED BY US AS PER PRESENTING BANKS INSTRUCTION.
       ,EFFECTED BY US AS PER PRESENTING BANK.
       ');
    file "d:/txt/chr75000.txt";
    do chunk=1 to 13;
       average_age=ceil(40*uniform(12345))+10;
       put +1 "GOOBOLY GOOP GOBOLOY" +1 states[chunk] $2. / +1 average_age 2. +1 " THE REST " @;
       do idx=1 to 50;
          do jdx=1 to 28;
             lyn=scan(txt,jdx,',');
             put +1 lyn " ";
         end;
       end;
    end;
run;quit;


d:/txt/chr75000.txt
                                                                                         |  RULE OUTPUT
                                                                                         |
 gooboly goop goboloy AL                                                                 |  State   Age
 25  the rest  SUPPLY OF MANPOWER AS PER PROFORMA INVOICE DATED 14.01.2019               |
 1. SIGNED COMMERCIAL INVOICE(S) IN 1 ORIGINAL AND 2 COPIES                              |    AL     25
 SHOWING DATE OF SUPPLY OF MANPOWER NOT LATER THAN 15.05.2019 AND                        |
 DULY COUNTERSIGNED BY APPLICANTS AUTHORIZED SIGNATORY AND TO BE                         |
 AUTHENTICATED BY IRAN NATIONAL BANK ERAN TRADE FINANCE DEPARTMENT                       |
 PRIOR PRESENTATION OF DOCS FOR NEGOTIATION.                                             |
 IN THE ABSENCE OF DATE OF SUPPLY OF MANPOWER THE DATE SHOWN ON                          |
 COMMERCIAL INVOICE WILL BE CONSIDERED AS THE SUPPLY DATE for DAWOOD HASSAN. USD 120/    |
 OR EQUIVALENT IN THE L/C CURRENCY AND RELATED                                           |
 CHARGES SHOULD BE DEDUCTED FROM THE PAYMENT FOR EACH PRESENTATION by DAWOOD HASAN       |
 OF DISCREPANT DOCUMENTS UNDER THIS CREDIT NOT WITHSTANDING ANY                          |
 INSTRUCTION TO THE CONTRARY THIS CHARGE SHALL BE FOR THE ACCOUNT                        |
 OF BENEFICIARY 202 577688-001-0010-000 BIC: PIBPBG2L                                    |
 2. BENEFICIARYS A/C NO.: 202 577688-001-0010-000 BIC: PIBPBG2L                          |
 APPLICANT ACCOUNT. ALL OTHER                                                            |
 CHARGES INCLUDING REIMBURSEMENT AND                                                     |
 SWIFT PAYMENTS RELATED CHARGES                                                          |
 ...                                                                                     |
 75,000 more characters                                                                  |
                                                                                         |  RULE OUTPUT
 gooboly goop goboloy AZ                                                                 |
 44  the rest  SUPPLY OF MANPOWER AS PER PROFORMA INVOICE DATED 14.01.2019               |  State   Age
 1. SIGNED COMMERCIAL INVOICE(S) IN 1 ORIGINAL AND 2 COPIES                              |
 SHOWING DATE OF SUPPLY OF MANPOWER NOT LATER THAN 15.05.2019 AND                        |    AZ     44
 DULY COUNTERSIGNED BY APPLICANTS AUTHORIZED SIGNATORY AND TO BE                         |
 AUTHENTICATED BY IRAN NATIONAL BANK ERAN TRADE FINANCE DEPARTMENT                       |
 PRIOR PRESENTATION OF DOCS FOR NEGOTIATION.                                             |
 IN THE ABSENCE OF DATE OF SUPPLY OF MANPOWER THE DATE SHOWN ON                          |
 COMMERCIAL INVOICE WILL BE CONSIDERED AS THE SUPPLY DATE for DAWOOD HASSAN. USD 120/    |
 OR EQUIVALENT IN THE L/C CURRENCY AND RELATED                                           |
 CHARGES SHOULD BE DEDUCTED FROM THE PAYMENT FOR EACH PRESENTATION by DAWOOD HASAN       |
 OF DISCREPANT DOCUMENTS UNDER THIS CREDIT NOT WITHSTANDING ANY                          |
 INSTRUCTION TO THE CONTRARY THIS CHARGE SHALL BE FOR THE ACCOUNT                        |
 OF BENEFICIARY 202 577688-001-0010-000 BIC: PIBPBG2L                                    |
 2. BENEFICIARYS A/C NO.: 202 577688-001-0010-000 BIC: PIBPBG2L                          |
 APPLICANT ACCOUNT. ALL OTHER                                                            |
 CHARGES INCLUDING REIMBURSEMENT AND                                                     |
 SWIFT PAYMENTS RELATED CHARGES                                                          |
 ...                                                                                     |
 approx 850,000 more characters


*            _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| '_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
;

Imbeded in the 1,000,000 character narative is this data

WORK.WANT total obs=7

 STATES    AGE

   AL       25
   AK       40
   AZ       44
   AR       22
   CA       18
   CO       40
   CT       14

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

* take the narative and concatenate lines into a single one million byte record;
data _null_;
  infile "d:/txt/chr75000.txt";
  file "d:/txt/chr1000000.txt" lrecl=1000000 recfm=f;
  input;
  put " " _infile_ @@;
run;quit;


* I file rewind function would be nice;
* find the average age for states ""AL","AK","AZ","AR","CA","CO","CT ;

data want;
 do states="AL","AK","AZ","AR","CA","CO","CT";
    call symputx('state',states);
    rc=dosubl('
       /*%let state=%str( AL);*/
       data _null_;
           *informat age $3.;
           infile "d:/txt/chr1000000.txt" lrecl=1000000 recfm=f;
           input @" &state " age;
           call symputx("age",age);
           putlog age=;
           stop;
       run;quit;
    ');
    age=symgetn("age");
    output;
 end;
 drop rc;
 stop;
run;quit;


