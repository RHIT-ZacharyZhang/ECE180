m = readmidi('canon.mid');
notes = midiInfo(m,0);
unique(notes(:,2)) + 1;
voicemap = repmat({'new'},16,1);
voicemap{10} = 'null'
fs = 44100;
y = midi2audio(notes,fs,'softsynth',voicemap);
plot((0:(length(y)-1))/fs,y);
p = audioplayer(y,fs);
play(p,[1,10]*fs);
% sound(softsynth(200,2,1,10e3,'new'),10e3)