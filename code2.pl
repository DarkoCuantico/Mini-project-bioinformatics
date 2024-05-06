#!/usr/bin/perl

use strict;
use warnings;

# Título del programa
print "\n\t\tHerramienta para bioinformatica\n";
print "\t\t\tEscrito por PapiDarko\n";
print "\t\t================================\n\n";

# Menú de opciones
my $opcion;
do {
    print "\t\tOpciones:\n";
    print "\t\t1. Transcribir ADN a ARNm.\n";
    print "\t\t2. Alineamiento de secuencias.\n";
    print "\t\t3. Traduccion de proteinas.\n";
    print "\t\t4. Detener el programa.\n";
    print "\t\t5. Cambios de version.\n\n";
    # Solicitar al usuario que elija una opción
    print "\t\tElige una opcion (1-5): ";
    $opcion = <STDIN>;
    chomp($opcion);

    # Procesar la opción elegida
    if ($opcion eq "1") {
        # Opción para transcribir ADN a ARNm
        print "\n\t\tTranscripcion de proteinas power by Perl\n";
        print "\t\t========================================\n\n";
        print "\t\tx\tBienvenido al programa de transcripcion de proteinas!\n";
        print "\t\tEste programa te permite ingresar una secuencia de ADN y obtener la secuencia de ARN mensajero (ARNm)\n";
        print "\t\tcorrespondiente, segun las reglas de transcripcion del ADN a ARNm.\n\n";
        print "\t\tPor favor, ingresa una secuencia de ADN utilizando solo las letras A, T, C y G.\n";
        print "\t\tPara detener el programa, escribe 'X'.\n\n";

        # Pedir al usuario que ingrese una secuencia
        my $secuencia;
        do {
            print "\t\tSecuencia de ADN: ";
            $secuencia = <STDIN>;
            chomp($secuencia);

            $secuencia = uc($secuencia);  # Convertir la secuencia a mayúsculas

            if ($secuencia eq "X") {
                exit;
            }

            # Verificar que la secuencia ingresada solo contenga las letras permitidas
            if ($secuencia !~ /^[ATCG]+$/) {
                print "\t\tLa secuencia ingresada contiene caracteres no validos. Por favor, utiliza solo las letras A, T, C y G.\n";
            }
        } until ($secuencia =~ /^[ATCG]+$/);

        # Cambiar las letras segun las reglas de transcripcion
        $secuencia =~ tr/ATCG/UAGC/;

        # Imprimir la secuencia de ARNm
        print "\t\tLa secuencia de ARNm correspondiente es: $secuencia\n";
    } elsif ($opcion eq "2") {
        # Opción para el alineamiento de secuencias
        print "\n\t\tAlineamiento de secuencias power by Perl\n";
        print "\t\t========================================\n\n";
        print "\t\t\tBienvenido al programa de alineamiento de secuencias!\n";
        print "\t\tEste programa te permite ingresar dos secuencia de ADN y obtener el alineamiento\n";
        print "\t\tcorrespondiente segun la homologia en el ADN.\n\n";
        print "\n\t\tPor favor, ingresa dos secuencias de ADN separadas por una coma (,).\n";
        print "\t\tRecuerda, la secuencia solo es valida utilizando las letras A, T, C y G.\n";    
        print "\t\tEjemplo: ATGC,CTAG\n";
        print "\t\tPara detener el programa, escribe 'X'.\n";

        # Pedir al usuario que ingrese las dos secuencias
        my ($secuencia1, $secuencia2);
        do {
            print "\n\t\tIngrese las dos secuencias: ";
            my $input = <STDIN>;
            chomp($input);
            
            # Salir si se ingresa "X"
            if (lc$input eq "x") {
                exit;
            }
            
            # Separar las dos secuencias utilizando una coma
            my @secuencias = split(",", $input);
            
            # Verificar si se ingresaron dos secuencias
            if (@secuencias != 2) {
                print "\t\tDebe ingresar exactamente dos secuencias separadas por una coma.\n";
            } else {
                # Asignar las secuencias
                ($secuencia1, $secuencia2) = map { uc($_) } @secuencias;
                
                # Verificar que las secuencias solo contengan las letras permitidas
                if ($secuencia1 !~ /^[ATCG]+$/ || $secuencia2 !~ /^[ATCG]+$/) {
                    print "\t\tLas secuencias ingresadas contienen caracteres no validos. Por favor, utiliza solo las letras A, T, C y G.\n";
                }
            }
        } until (defined $secuencia1 && defined $secuencia2);

        # Igualar las longitudes de las secuencias rellenando con guiones ("-") si es necesario
        my $max_length = length($secuencia1) > length($secuencia2) ? length($secuencia1) : length($secuencia2);
        $secuencia1 .= "-" x ($max_length - length($secuencia1));
        $secuencia2 .= "-" x ($max_length - length($secuencia2));
        
        # Realizar el alineamiento de secuencias
        my $alineamiento = "";
        for (my $i = 0; $i < $max_length; $i++) {
            my $letra1 = substr($secuencia1, $i, 1);
            my $letra2 = substr($secuencia2, $i, 1);
            if ($letra1 eq $letra2) {
                $alineamiento .= $letra1;
            } else {
                $alineamiento .= "-";
            }
            
            # Agregar un salto de línea después de cada 10 letras
            if (($i + 1) % 20 == 0) {
                $alineamiento .= "\n";
            }
        }
        
        # Imprimir el alineamiento
        print "\t\tEl alineamiento de las secuencias es:\n\n";
        print "\t\tSecuencia 1: $secuencia1\n";
        print "\t\tSecuencia 2: $secuencia2\n";
        print "\t\tAlineamiento: $alineamiento\n\n";
        print "\t\tNota: Asegurate de solo utilizar A, G, C y T en la secuencia, el alineamiento\n";
        print "\t\tpodria fallar o agregar gaps en sitios que no deberian tener.\n";
    } elsif ($opcion eq "3") {
        # Opción para la traducción de proteínas
        print "\n\t\tTraduccion de proteinas power by Perl\n";
        print "\t\t=====================================\n\n";
        print "\t\t\tBienvenido al programa de traduccion de proteinas!\n";
        print "\t\tEste programa te permite ingresar una secuencia de ARNm y obtener\n";
        print "\t\tla secuencia de proteinas correspondiente en cadena de aminoacidos.\n\n";
        print "\t\tPor favor, ingresa una secuencia de ARNm utilizando solo las letras A, U, C y G.\n";
        print "\t\tPara detener el programa, escribe 'X'.\n";

        # Pedir al usuario que ingrese la secuencia de ARNm
        my $arnm;
        do {
            print "\n\t\tSecuencia de ARNm: ";
            $arnm = <STDIN>;
            chomp($arnm);

            $arnm = uc($arnm);  # Convertir la secuencia a mayúsculas

            if ($arnm eq "X") {
                exit;
            }

            # Verificar que la secuencia ingresada solo contenga las letras permitidas
            if ($arnm !~ /^[AUCG]+$/) {
                print "\t\tLa secuencia ingresada contiene caracteres no validos. Por favor, utiliza solo las letras A, U, C y G.\n";
            }
        } until ($arnm =~ /^[AUCG]+$/);

        # Realizar la traducción de proteínas
        my %codones = (
            "CGA" => "R", "CGC" => "R", "CGG" => "R", "CGU" => "R",
            "AGA" => "R", "AGG" => "R",
            "AAA" => "K", "AAG" => "K",
            "AAC" => "N", "AAU" => "N",
            "CAC" => "H", "CAU" => "H",
            "CAA" => "Q", "CAG" => "Q",
            "UCA" => "S", "UCC" => "S", "UCG" => "S", "UCU" => "S",
            "AGC" => "S", "AGU" => "S",
            "ACA" => "T", "ACC" => "T", "ACG" => "T", "ACU" => "T",
            "GCA" => "A", "GCC" => "A", "GCG" => "A", "GCU" => "A",
            "GGA" => "G", "GGC" => "G", "GGG" => "G", "GGU" => "G",
            "GUA" => "V", "GUC" => "V", "GUG" => "V", "GUU" => "V",
            "CCA" => "P", "CCC" => "P", "CCG" => "P", "CCU" => "P",
            "CUA" => "L", "CUC" => "L", "CUG" => "L", "CUU" => "L",
            "UUA" => "L", "UUG" => "L",
            "UUC" => "F", "UUU" => "F",
            "UAC" => "Y", "UAU" => "Y",
            "AUA" => "I", "AUC" => "I", "AUU" => "I",
            "AUG" => "M",
            "UGG" => "W",
            "UGC" => "C", "UGU" => "C",
            "UAA" => " Terminacion", "UAG" => " Terminacion", "UGA" => " Terminacion"
        );

        my $proteina = "";
        my $codon = "";
        for (my $i = 0; $i < length($arnm); $i++) {
            my $letra = substr($arnm, $i, 1);
            $codon .= $letra;
            if (length($codon) == 3) {
                if (exists($codones{$codon})) {
                    $proteina .= $codones{$codon};
                } else {
                    $proteina .= "X";
                }
                $codon = "";
            }
        }

        # Imprimir la secuencia de proteínas
        print "\n\t\tLa secuencia de proteinas correspondiente es: $proteina\n";
        print "\n\t\tNota: Asegurate de solo utilizar A, U, G y C.\n";
        print "\t\tLas minusculass no suelen alterar el resultado.\n";
    } elsif ($opcion eq "4") {
        # Opción para detener el programa
        print "\n\n\t\tEl programa ha sido detenido.\n";
        print "\n\t\t\tCreditos a PapiDarko y OpenIA.\n";
        print "\t\tHerramienta para bioinformatica - Version 1.1\n\n";
        exit;
    } elsif ($opcion eq "5") {
        # Opción para detener el programa
        print "\n\n\t\tCambios de version\n\n";
        print "\t\t1.0 - 05/05/24 \n";
        print "\t\t\t- Se agregaron las primeras dos opciones en el menu:\n";
        print "\t\t\t\t1. Transcribir ADN a ARNm.\n";
        print "\t\t\t\t2. Alineamiento de secuencias.\n";
        print "\n\t\t\t- Se incorporaron sus funciones de cada opcion dentro del codigo.\n";

        print "\n\t\t1.1 - 05/05/24 \n";
        print "\t\t\t- Se agregaron dos opciones en el menu:\n";
        print "\t\t\t\t3. Traduccion de proteinas.\n";
        print "\t\t\t\t4. Detener el programa.\n";
        print "\n\t\t\t- Se incorporaron sus funciones de cada opcion dentro del codigo.\n";
        print "\n\t\t\t- Se incorporo el uso de minusculas en la transcripcion de ADN a ARNm.\n";
        print "\n\t\t\t- Se incorporaron bucles en las opciones que lo requieran, para permitir\n";
        print "\t\t\t  reingresar un valor valido, o cancelar la operacion.\n";

        print "\n\t\t1.2 - 06/05/24 \n";
        print "\t\t\t- Se agrego una quinta opcion en el menu:\n";
        print "\t\t\t\t5. Cambios de version.\n";
        print "\n\t\t\t- Se corrigieron errores de mayusculas en el alineamiento de secuencias.\n";
        print "\n\t\t\t- Se corrigio un bug que no permitia el bucle tras ingresar valores no permitidos\n";
        print "\t\t\t  en las secuencias del alineamiento de secuencias, finalizando en error.\n";
        print "\n\t\t\t- Se retiraron los caracteres especiales con tildes para una mejor lectura.\n";
        
        print "\n\t\t\tCreditos a PapiDarko y OpenIA.\n";
        print "\t\tHerramienta para bioinformatica - Version 1.2\n\n";
        exit;
    } else {
        # Opción inválida
        print "\t\tEsa no es una opcion valida. Por favor, elige una opción del menu (1-5).\n";
    }
} until ($opcion =~ /^[1-4]$/);
