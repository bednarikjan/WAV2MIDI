WAV2MIDI
========

A program created as the main deliverable of the Bachelro thesis Conversion of piano recordings from WAV to MIDI.

The aim of the thesis is to propose a system capable of automatic conversion of polyphonic piano recordings from the audio format WAV to MIDI. The thesis describes problems related to single tone recognition in music recordings and proposes a solution based on a probabilistic model that uses the Probabilistic Latent Component Analysis method. Recordings of isolated digital piano tones were used to train the system. The proposed system was tested on classical recordings of the Classical Piano MIDI database and on recordings of a Korg SP-250 piano and evaluated using a variety of metrics. The conclusion part contains the results of recognition success rate and their comparison with other existing systems.

## Install and run

1. Copy directories 'src' and 'test' to your hard drive. For the correct functionality of the demo tests both directories must be placed in the same parnet directory.

2. Run MATLAB a using pathtool command (File -> Set Path) add the path to the 'src', 'src\midi_toolbox' and 'src\midi_tools' to search path.

3. Open classpath.txt (enter "edit classpath.txt" in the command window) and add the path to 'KaraokeMidiJava.jar' file saved in directory  'src\midi_tools'.

4. Restart MATLAB.

## How to use WAV2MIDI

The directory 'src' contains source files of the system and the source files for the demo test. If you want to tune the system, adjust parameters in the file 'constants.m'


### WAV2MIDI

The system can be run as a console application by calling the function 'wav2midi.m'. It accepts the WAV file on its input and produces the corresponding MIDI file. See Synopsis for more info.

### Synopsis

	wav2midi(wav, midi, [thresh, [snl]])
		
		wav 	input WAV file name
		midi	input MIDI file name
		thresh	threshold, range [0, 100] (default = 15)
		snl		the length of the shortest note accepted, range [1, 5] (default = 1)
	
	Parameters 'thresh' and 'snl' affect the success rate of the conversion (and resulting quality) so it is worth to experiemtn with them a bit.

	