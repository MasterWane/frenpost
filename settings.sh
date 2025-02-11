#!/usr/bin/env sh

#address of the frenpost server to connect to
serverAdd=127.0.0.1:5000

#who's public keys to encrypt with
recepients=""

tmpfile="tmp"
gpgout="tmp.gpg"
gpgverify="gpgtmp"
gpgdecrypted="gpgdec"
tmpcheck="tmpcheck"
tmpcheck2="tmpcheck2"

#where to save images
imgdir="pictures"

#public key to use to encrypt files locally
self="Ben Dover"

#use this function to save downloaded pictures as encrypted
function encryptimgproc {
    mkdir -p "$imgdir"
    rm -f "$imgdir/$2"
    gpg --output "$imgdir/$2" -r "$self" -e "$1"
}

function unsafeimgproc {
    mkdir -p "$imgdir"
    cp "$1" "$imgdir/$2"; }

function imgproc {
    encryptimgproc "$@"
}

#where to save other binary files
bindir="other"

#use this function to save downloaded files as encrypted
function encryptbinproc {
    mkdir -p "$bindir"
    rm -f "$bindir/$2"
    gpg --output "$bindir/$2" -r "$self" -e "$1"
}

function unsafebinproc {
    mkdir -p "$bindir"
    cp "$1" "$bindir/$2"; }

function binproc {
    encryptbinproc "$@"
}

#What to do with text
function textproc {
    cat "$1"
}

EDITOR="vim"
update_delay=1


source settings.d/*
