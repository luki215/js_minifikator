#!/usr/bin/env ruby

#require 'pry'
require 'json'
require_relative "MinifyFactory"



# globalni promenne, hlavni fce 

$javascriptIn = ""
$javascriptOut = ""

#reservovaná slova javascriptem - json, uchovava jestli je nutne mit pred a za slovem mezeru
reserved_words = File.read("#{File.dirname(__FILE__)}/javascript_reserved.json");
$klicova_slova = JSON.parse(reserved_words)

#uzivatelem definovany whitelist slov, ktera nechce prejmenovavat
$nazvy_ktere_neprejmenovavat = $klicova_slova

#chce uzivatel prejmenovavat promenne nebo ne?
$prejmenovavat = true



# zpracovani parametru z prikaz radky
i = 0
if ARGV.empty?
  puts "Vyzkousejte minifikuj.rb -h"
  exit
end

while i < ARGV.length
  case ARGV[i]
  
  #help
  when ( "-h" or "?" or "--help" )
    puts "Javascriptovy minifikator"
    puts "-----------------------------------"
    puts "Parametry:"
    puts "\t-in soubor\t povinny, nazev = soubor, ktery chcete zmimifikovat"
    puts "\t-out soubor\t soubor, do ktereho ma byt zapsana zmimifikovana verze. Pokud neexistuje, vytvori se. Neni zadan => vstupni_soubor.min.koncovka"
    puts "\t -wl soubor\t soubor se seznamem nazvu promennych (oddelenych radky), ktere nechceme zkracovat"
    puts "\t --no-rename\t pokd je zadan, nebudou se zkracovat promenne"

    exit
  
  #vstupni soubor
  when "-in"
    i+=1
    $javascriptIn = ARGV[i].to_s

    unless $javascriptIn.nil? or File.exists? $javascriptIn
      abort "Vstupni soubor neexistuje"
    end
    #defaultně výstup jako něco.min.něco
    $javascriptOut = $javascriptIn.gsub(/\.([^.]*)$/, '.min.\1')
  
  #vystupni soubor
  when "-out"
    i+=1
    $javascriptOut = ARGV[i]
  
  #definuje whitelist
  when "-wl"
    i+=1
    slova={}
    File.open(ARGV[i]).each do |line|
      slova.merge!({"#{line.strip}"=> ""})
    end
    $nazvy_ktere_neprejmenovavat.merge!(slova)
  
  #nechce prejmenovavat
  when "--no-rename"
    $prejmenovavat = false
  
  #neco je divne
  else
    abort "Divne parametry, prosim zkontrolujte."    
  end

  i+=1

end 

if $javascriptIn.empty?
  abort "Chybi vstupni soubor"
end
if $javascriptOut.empty?
  abort "Spatne zadan vystupni soubor"
end

if(File.exists? $javascriptOut)
  puts "Vystupni soubor jiz existuje. Chcete prepsat? (y/n)"
  #binding.pry
  a = STDIN.gets
  unless (a == "y\n" or a == "Y\n")
    exit
  end
end


outputFile = File.new($javascriptOut, "w")



minify = MinifyFactory.new

vysledek = minify.zmimifikuj(File.read($javascriptIn)) 

outputFile.print(vysledek) 


