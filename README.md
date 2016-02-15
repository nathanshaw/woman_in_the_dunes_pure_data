This is the Readme for the YinYang interactive audio/visual installation 
            by Martin Vélez and Nathan Villicaña-Shaw

========== CHECK LIST =================================

2x Laptop Computers
4x CRT TV's
1x Audio Mixer
6x rca 1->2 atapters
2x HDMI -> RCA audio/video adapters'

========== HARDWARE SETUP =============================

1. Stack four TV's on top of each other on a sturdy table

2. Tweak the video settings for each TV as much as possible to distort the quality of their video signal
    in a unique way.

3. Balence the Audio from each TV so that they are all equal amplitude

4. Hook up each of the two laptops to an HDMI -> RCA audio video converter

5. For each of the two audio outputs and for the one video output for the
    adapter add a signal splitter that converts the single RCA output into two identical outputs

6. Hook up each of the two outputs to two different TVS's (repeat for each laptop)

7. Take another copy of the stereo audio mix from each of the two laptops and mix them together using
    an audio mixer. (each of the systems should live 75% on opposite side of the mix)

8. Duplicate the Mix and route it to two headphones that are place on the table in front of the TV's

9. Plug a Nano Kontrol into each of the two laptops and place in front of the TV's (if black and white Nano are present alternate the knob and slider colors)


========== SOFTWARE SETUP - Discovery Synths ===========

Run the processing sketch first
Then run the PD sketch
then move all sliders, knobs and buttons

========== SOFTWARE SETUP - NANO Kontrols ==============

---------- PURE DATA -----------------------------------
1. Open the korg2_Midi_in_to_OSC.pd file in pure data
2. Click on the message "connect 127.0.0.1"
3. In pure data go to media->Audio Settings and make sure that the output device is set to HDMI
4. Test your controller's first channel, you should see the patch display values for the knobs, sliders and buttons' 
5. Open woman_in_the_dunes_feedback_machines.pd
6. Click the button next to Load in the main control box. Load one of the samples found under "pure data -> media" (Such as dunes_03.aif)
7. Move all the sliders and knobs and press a few buttons and the sound should start playing
8.
