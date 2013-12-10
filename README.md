WAV2MIDI
========

Výsledný program bakalářské práce Převod záznamu piana z WAV do MIDI.

1) NÁVOD K INSTALACI
============================================================================================
(1)
Adresáře 'src' a 'test' zkopírujte na pevný disk. Pro správnou funkčnost demonstračních
testů musí být oba adresáře na stejné úrovni hierarchie adresářů.

(2)
Spusťte MATLAB a za pomocí pathtool (File -> Set Path) přidejte do vyhledávací cesty
aktuální umístění adresářů 'src', 'src\midi_toolbox' a 'src\midi_tools'. Jedná se o volně
dostupné MIDI toolboxy nezbytné pro správnou funkčnost projektu. Oba toolboxy jsou
součástí repozitáře.

(3)
Otevřete classpath.txt (do Command Window vepište "edit classpath.txt") a přidejte
záznam s cestou vedoucí k souboru KaraokeMidiJava.jar uloženém v adresáři
'src\midi_tools'.

(4)
Restartujte MATLAB.



2) POUŽITÍ SYSTÉMU WAV2MIDI
============================================================================================
Adresář 'src' obsahuje zdrojové soubory k systému WAV2MIDI i k demonstračnímu testu.
V souboru 'constants.m' lze přizpůsobit výchozí parametry systému.

WAV2MIDI
--------
Systém WAV2MIDI lze spustit jako konzolovou aplikaci voláním funkce 'wav2midi.m'. 
Funkce na vstupu přijímá soubor WAV s nahrávkou piana a produkuje soubor MIDI.
Funkce wav2midi(wav, midi, thresh, snl) přijímá 4 parametry:

	wav		jméno vstupního  WAV  souboru
	midi 	jméno výstupního MIDI souboru
	thresh	hodnota prahu (volitelné)
	snl 	hodnota nejkratší délky tónu pro post-processing (volitelné)

Pokud není zadána některá z hodnot thresh nebo snl, použijí se jejich
výchozí hodnoty (thresh = 15, snl = 1). Volba prahu a snl ovlivňuje
kvalitu výstupu. Čím vyšší práh a snl, tím méně not se do výstupu dostane.
Doporučené rozsahy pro oba parametry jsou:

	thresh	0 - 100
	snl 	1 - 5
	
Lze s nimi však libovolně experimentovat.

Zatímco výpočet PLCA a získání piano-roll matice s měkkým rozhodnutím je
časově náročné, její následné prahování a post-processing je téměř okamžitý.
Pro experimentování s prahy a snl je tak funkce wav2midi nevhodná, 
protože vždy nanovo počítá PLCA, aby získala piano-roll
matici s měkkým rozhodnutím, která bude teprve prahována. Pro experimenty
je výhodnější využít samostatně funkci 'wav2soft_proll' a její výstup
(piano-roll matici s měkkým rozhodnutím) uložit do proměnné.

Tuto proměnnou lze následně posílat funkcím 'try_midi_view.m' a 
'try_midi_sound.m', které pro zadaný práh zobrazí piano-roll
matici respektive zahrají syntetizovný zvuk. Po dosažení
optimálního prahu a snl je možné provést export do MIDI za pomoci funkce
'soft_proll2midi.m'.

DEMONSTRAČNÍ TEST
-----------------
Demonstrační test slouží k výpočtu ohodnocení úspěšnosti systému podobně,
jako bylo popsáno v textu bakalářské práce. Test sestávající ze dvou
dílčích testů naleznete ve skriptu 'test_demo.m' (lze jej přímo spustit).

Test vyhdonotí PLCA pro každý testovaný WAV soubor v adresáři 'test\sound'
a uloží výslednou piano-roll matici s měkkým rozhodnutím jako 
MAT-file do adresáře 'test\auxdata'.

Test1:
	Pro každý testovaný soubor načte piano-roll matici s měkkým rozhodnutím,
	aplikuje na ni práh a post-processing (s výchozími hodnotami prahu a dkn),
	porovná s referenčním MIDI souborem a vyhodnotí note-level a frame-level
	metriky. Výsledky pro každý testovaný soubor uloží do souboru 'test1.txt'
	v adresáři 'test\results'. Současně do konzole vypíše průměrné hodnoty
	všech výsledků metrik v následujícím formátu (viz text BP, kapitola
	5.1 Metriky):
	
		corr  fa  is  ex  Etot  Esubs  Emiss  Efa
	
Test2:
	To samé, jako Test1, ale nepoužívá výchozí hodnotu prahu a snl, nýbrž
	tyto stanoví jako nejvhodnější pro danou testovací sadu. Každý
	testovaný soubor porovná s referenčním MIDI souborem při využití
	různých kombinací prahů a snl (lze nastavit v 'constants.m').
	Vektory výsledků těchto spočtených kombinací ukládá pro každý soubor
	jako matici výsledků do MAT-file se jménem končícím na '_res_.mat'. Následně
	pro každý testovaný soubor vybere nejlepší vektor výsledků takový,
	který obsahuje hodnotu falešného poplachu (fa) maximálně o hodnotě
	15 % (lze upravit v 'constants.m' pod proměnnou 'worstFa'). Z těchto
	nejlepších vektorů stanový průměrný práh a snl a dále pokračuje jako
	Test1 s tím, že textový soubor s výsledky uloží do 'test\results' pod
	jménem 'test2.txt'. Současně do konzole vypíše průměrné hodnoty všech výsledků metrik
	ve stejném formátu jako Test1.

Pro demonstraci je pro testování přiloženo 8 1minutových nahrávek autorů
klasické klavírní hudby syntetizovaných z referenčních MIDI souborů.
V závislosti na výkonu počítače může zpracování testu trvat 10-20 minut.
Pro urychlení testu lze smazat některé WAV nahrávky a jejich referenční MIDI.
