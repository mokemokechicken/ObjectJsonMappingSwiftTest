#!/bin/sh

cd $(dirname $0)

git submodule update --init --recursive

cd ObjectJsonMapperGenerator

cat example/book.yml example/order.yml > .tmp.yml

ruby bin/make_ojm.rb -c .tmp.yml -l swift -o ../OJM/ojm.swift

rm -f .tmp.yml
