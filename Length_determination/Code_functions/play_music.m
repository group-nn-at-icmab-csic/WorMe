function play_music(fullname_arxiu, temps_espera)

% Executa un so mp3 o wav
% NO RULAAA
%
% Variables exemple
% fullname_arxiu = "Internal_files\Music\6-8-march-in-d-major-4311.mp3";

[music_y, Fs_music] = audioread(fullname_arxiu);
PO=audioplayer(music_y,Fs_music);
% Play audio
play(PO)
% Stop audio
% pause(5)
if exist('temps_espera','var')
    pause(temps_espera)
    stop(PO)
end
clear music_y Fs_music


end