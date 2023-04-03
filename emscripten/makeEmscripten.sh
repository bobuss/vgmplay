#!/bin/sh
set -e

# emcc -I. -I.. -I../3rdParty/zlib/ -I../src/ \
#     ../3rdParty/zlib/adler32.c ../3rdParty/zlib/compress.c ../3rdParty/zlib/crc32.c ../3rdParty/zlib/gzio.c ../3rdParty/zlib/uncompr.c ../3rdParty/zlib/deflate.c ../3rdParty/zlib/trees.c ../3rdParty/zlib/zutil.c ../3rdParty/zlib/inflate.c ../3rdParty/zlib/infback.c ../3rdParty/zlib/inftrees.c ../3rdParty/zlib/inffast.c \
#     -DENABLE_ALL_CORES -DFM_EMU -DADDITIONAL_FORMATS -DSET_CONSOLE_TITLE -DDISABLE_HW_SUPPORT -DNO_DEBUG_LOGS \
#     -s WASM=1 \
#     -s SINGLE_FILE=1 \
#     -s VERBOSE=0 \
#     -fno-rtti \
#     -fno-exceptions \
#     -s ASSERTIONS=0 \
#     -s FORCE_FILESYSTEM=1  \
#     -Wno-pointer-sign \
#     -Os \
#     -O3 \
#     -r \
#     -o built/thirdparty.bc

# emcc -I. -I.. -I../3rdParty/zlib/ -I../src/ \
#     ../src/chips/x1_010.c ../src/chips/ws_audio.c ../src/chips/vsu.c ../src/chips/saa1099.c ../src/chips/iremga20.c ../src/chips/es5506.c ../src/chips/es5503.c ../src/chips/c352.c ../src/chips/262intf.c ../src/chips/2151intf.c ../src/chips/2203intf.c ../src/chips/2413intf.c ../src/chips/2608intf.c ../src/chips/2610intf.c ../src/chips/2612intf.c ../src/chips/3526intf.c ../src/chips/3812intf.c ../src/chips/8950intf.c ../src/chips/adlibemu_opl2.c ../src/chips/adlibemu_opl3.c ../src/chips/ay8910.c ../src/chips/ay_intf.c ../src/chips/c140.c ../src/chips/c6280.c ../src/chips/c6280intf.c ../src/chips/dac_control.c ../src/chips/emu2149.c ../src/chips/emu2413.c ../src/chips/fm2612.c ../src/chips/fm.c ../src/chips/fmopl.c ../src/chips/gb.c ../src/chips/k051649.c ../src/chips/k053260.c ../src/chips/k054539.c ../src/chips/multipcm.c ../src/chips/nes_apu.c ../src/chips/nes_intf.c ../src/chips/np_nes_apu.c ../src/chips/np_nes_dmc.c ../src/chips/np_nes_fds.c ../src/chips/okim6258.c ../src/chips/okim6295.c ../src/chips/Ootake_PSG.c ../src/chips/panning.c ../src/chips/pokey.c ../src/chips/pwm.c ../src/chips/qsound_mame.c ../src/chips/qsound_intf.c ../src/chips/qsound_ctr.c ../src/chips/rf5c68.c ../src/chips/segapcm.c ../src/chips/scd_pcm.c ../src/chips/scsp.c ../src/chips/scspdsp.c ../src/chips/sn76489.c ../src/chips/sn76496.c ../src/chips/sn764intf.c ../src/chips/upd7759.c ../src/chips/ym2151.c ../src/chips/ym2413.c ../src/chips/ym2612.c ../src/chips/ymdeltat.c ../src/chips/ymf262.c ../src/chips/ymf271.c ../src/chips/ymf278b.c ../src/chips/ymz280b.c ../src/chips/ay8910_opl.c ../src/chips/sn76496_opl.c ../src/chips/ym3438.c  ../src/chips/ym2413hd.c ../src/chips/ym2413_opl.c \
#     -DENABLE_ALL_CORES -DFM_EMU -DADDITIONAL_FORMATS -DSET_CONSOLE_TITLE -DDISABLE_HW_SUPPORT -DNO_DEBUG_LOGS \
#     -s WASM=1 \
#     -s SINGLE_FILE=1 \
#     -s VERBOSE=0 \
#     -fno-rtti \
#     -fno-exceptions \
#     -s ASSERTIONS=0 \
#     -s FORCE_FILESYSTEM=1  \
#     -Wno-pointer-sign \
#     -Os \
#     -O3 \
#     -r \
#     -o built/chips.bc

emcc -I. -I.. -I../3rdParty/zlib/ -I../src/ \
    ../src/ChipMapper.c ../src/VGMPlay.c ../src/VGMPlayUI.c ../src/VGMPlay_AddFmts.c \
    -DENABLE_ALL_CORES -DFM_EMU -DADDITIONAL_FORMATS -DSET_CONSOLE_TITLE -DDISABLE_HW_SUPPORT -DNO_DEBUG_LOGS \
    -s WASM=1 \
    -s SINGLE_FILE=1 \
    -s VERBOSE=0 \
    -fno-rtti \
    -fno-exceptions \
    -s ASSERTIONS=0 \
    -s FORCE_FILESYSTEM=1  \
    -Wno-pointer-sign \
    -Os \
    -O3 \
    -r \
    -o built/main.bc




emcc -I. -I.. -I../3rdParty/zlib/ -I../src/ built/thirdparty.bc built/chips.bc built/main.bc   adapter.c \
    -DENABLE_ALL_CORES -DFM_EMU -DADDITIONAL_FORMATS -DSET_CONSOLE_TITLE -DDISABLE_HW_SUPPORT -DNO_DEBUG_LOGS \
    -s WASM=1 \
    -s VERBOSE=0 \
    -fno-rtti \
    -fno-exceptions \
    -s ASSERTIONS=0 \
    -s FORCE_FILESYSTEM=1  \
    -Wno-pointer-sign \
    -Os \
    -O3 \
    --closure 1 \
    -s EXPORTED_RUNTIME_METHODS="['ccall', 'UTF8ToString']" \
    -s EXPORTED_FUNCTIONS="['_emu_init','_emu_get_sample_rate','_emu_get_position','_emu_get_max_position','_emu_seek_position','_emu_teardown','_emu_set_subsong','_emu_get_track_info','_emu_get_audio_buffer','_emu_get_audio_buffer_length','_emu_compute_audio_samples', '_malloc', '_free']" \
    -o htdocs/vgm.js \
    -s SINGLE_FILE=1 \
    -s BINARYEN_ASYNC_COMPILATION=0 \
    -s ALLOW_MEMORY_GROWTH=1 \
    -s ENVIRONMENT=worker \
    -s MODULARIZE=1 \
    -s EXPORT_NAME=backend_vgm \
    -s "BINARYEN_METHOD='native-wasm'" \
    --extern-pre-js pre.js \
    --extern-post-js post.js
