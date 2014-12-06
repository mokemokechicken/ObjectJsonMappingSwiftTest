#!/bin/sh

cd $(dirname $0)
cd ObjectJsonMapperGenerator

ruby bin/make_ojm.rb -c example/book.yml -l swift -o ../OJM/book.swift

rm -rf ../example
cp -r example ../example
