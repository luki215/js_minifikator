
class MinifyFactory
  
  def zmimifikuj(zdrojak)

    rozdelZdrojakNaKodAZbytek(zdrojak)
    
    odstranKomentare(KodAZbytek.vratSebe)
    
    vyresMezery(KodAZbytek.vratSebe)
    
    Promenne.vyresPromenne(KodAZbytek.vratSebe) if $prejmenovavat
    
    KodAZbytek.vratSebe.join
  end   
  
  # naplni tridu kod a zbytek  - oddeli od sebe kod, ktery muzeme zminifikovat, upravit a zbytek, na ktery nesmime sahat ( retezce, regexpy, komentare atd... )
  def rozdelZdrojakNaKodAZbytek(zdrojak)

    #pokud jsme uprostřed toho co není kód, tak čím se to ukončí (" nebo ' nebo  * pro */ ...), jinak je nil
    aktualni_oddelovac = nil

    #pomocna promenna, uchovava, do ktere pozice jiz mame znaky zpracovane
    konec_zpracovani = 0
    
    #zdrojak po znacich
    pole_znaku_zdrojaku = zdrojak.chars
    
    pole_znaku_zdrojaku.each_with_index do |c, i|      
      #preskakuje znaky v pripade, ze uz jsme je zpracovali
      if i < konec_zpracovani 
        next
      end    
      
      #resi jednoradkove komentare
      if(aktualni_oddelovac.nil? and c == "/" and pole_znaku_zdrojaku[i+1] == "/")

        konec_zpracovani = zdrojak.index("\n", i) + 1
        KodAZbytek.pridejKod("")          
        KodAZbytek.pridejZbytek( zdrojak.slice(i, konec_zpracovani-i) )
        next
      
      end
      
      #zacina zbytek
      if aktualni_oddelovac.nil? and (c=="'" or c == '"' or (c == "/" and pole_znaku_zdrojaku[i+1] == "*" and  pole_znaku_zdrojaku[i-1] != "\\" ))          
        aktualni_oddelovac = c
        KodAZbytek.pridejZbytek(c)        
        if c == "/"
          KodAZbytek.pridejZbytek("*")
          konec_zpracovani= i+2
          aktualni_oddelovac = "*"
        end
      
      #konci zbytek
      elsif (c == aktualni_oddelovac and pole_znaku_zdrojaku[i-1] != "\\" ) 
          KodAZbytek.pridejZbytek(c)
          if c!= "*"                  
            aktualni_oddelovac = nil 
          elsif pole_znaku_zdrojaku[i+1] == "/"
            KodAZbytek.pridejZbytek("/")            
            konec_zpracovani= i+2            
            aktualni_oddelovac = nil 
          end       
      
      #uprostred "kodu" 
      elsif aktualni_oddelovac.nil?     
      
        #resi regexy - kdyby nahodou byl      
        if aktualni_oddelovac.nil? and c=="/"   
      
          #namatchujeme konex regexu
          konec_zpracovani = zdrojak.index(/[^\n][\/][mgi]{0,3}\s*[;),]/, i) 
  
          #eliminujeme lomitka, ktera jsou mezi aktualnim indexem a koncem regexu.. a nemaji patrit do regexu      
          #pokud je jeste nejake lomitko mezi koncem regexu a aktualni pozici, je to deleni, komentar nebo neco podobneho => zahodit  
          if !konec_zpracovani.nil? and !zdrojak.slice(i, konec_zpracovani-i).index(/[^\\][\/]/, 1).nil?
              konec_zpracovani = nil 
          end
          
          if konec_zpracovani.nil?
      
            #asi šlo o dělení nebo něco jiného co má v sobě /
            konec_zpracovani = 0
          else
      
            #pricist velikost oddelovace konce regexu od zbytku
            konec_zpracovani += (zdrojak.match(/[^\n][\/][mgi]{0,3}\s*[;),]/, i)[0]).size - 1
      
            #at jde do samostatneho policka zbytku
            KodAZbytek.pridejKod("")   
            KodAZbytek.pridejZbytek( zdrojak.slice(i, konec_zpracovani-i) )
            next
          end
        end              
           
        KodAZbytek.pridejKod(c)
      else
        KodAZbytek.pridejZbytek(c)
      end
    end
  end

  # odstrani z kodu vsechny komentare - /* */, //
  def odstranKomentare(pole_kod_a_zbytek)
    
    pole_kod_a_zbytek.each_with_index do |kod_nebo_zbytek, i|
      if i.odd? and !pole_kod_a_zbytek[i].nil?
        
        # /* */ komenty
        if pole_kod_a_zbytek[i].strip[0,2] == "/*"
          pole_kod_a_zbytek[i] = ""
        end
        
        #jednoradkove komenty
        if pole_kod_a_zbytek[i].strip[0,2] == "//"
           pole_kod_a_zbytek[i] = ""
        end    
      end
    end
    KodAZbytek.nastavSe(pole_kod_a_zbytek);
    
  end 

  #vymaze vsechny nepotrebne mezery, tam kde jsou treba nahradi \n 
  def vyresMezery(pole_kodu_a_zbytku)
  
    pole_kodu_a_zbytku.each_with_index do |kod, i|
  
      #sahat pouze na kod
      if i.even?
        pole_kodu_a_zbytku[i] = ""
        kod ||=""    
        kod = kod.split(/\s+/)
        kod.each do |word|
  
          #zacina slovem u ktereho se musi pridat mezera zleva
          if !(word =~ /^[\w]/).nil?
            vybrane = word.slice(0, (word.index( /[\W]/) || word.length  ) )
            pole_kodu_a_zbytku[i]+=" " if ($klicova_slova.has_key?(vybrane) and ($klicova_slova["#{vybrane}"][0]))
          end
          
          pole_kodu_a_zbytku[i]+=  word
          
          #konci slovem u ktereho se musi pridat mezera zprava
          if !(word =~ /[\w]$/).nil?
            vybrane = word.slice( (word.rindex( /[\W]/) || -1 )+1, word.length )
            pole_kodu_a_zbytku[i]+=" " if ($klicova_slova.has_key?(vybrane) and ($klicova_slova["#{vybrane}"][1])) and !( word == "var" || word == "function")
            pole_kodu_a_zbytku[i]+="\n" if word == "var" || word == "function"
          end
  
        end     
      end      
    end  
    KodAZbytek.nastavSe(pole_kodu_a_zbytku)
  end

end


class Promenne

  #hash, ve kterem uchovavame :promenna=>#vyskytu v kodu, po zavolani priradKPromennymNahrady novy nazev, ktery bude mit
  @@vyseparovanePromenne = {}

  def self.vyresPromenne(pole_kodu_a_zbytku)
    #vyrobime pole, ktere obsahuje jen kod a rozdeli na jednotlive oddily
    zdrojak = pole_kodu_a_zbytku.values_at(* pole_kodu_a_zbytku.each_index.select {|i| i.even?}).join("").split(/([^a-zA-Z0-9._]+)/)
       
    separujNazvyPromennych(zdrojak)
    priradKPromennymNahrady
    projedZdrojakANahradPromenne
  end

  #naplní z kodu @@vyseparovanePromenne vsemi nazvy, ktere lze prejmenovat + jejich cetnosti, od udává index, odkud se má pokračovat
  def self.separujNazvyPromennych(kod, od=0)
    i = od
    
    # jestli nejsme uprostred definovani promennych (var a, b, c=function(){}, d=8 ....)  
    insideVarDefinition = false

    while i < kod.size do
      
      #ignorace vnitrku ternarnich operatoru
      	if insideVarDefinition and kod[i].include?("(");
      		until kod[i].include?(")")
      			i+=1
      		end
      	end

      #vyseparovani funkcí
      if(kod[i] == "function")
        #takova deklarace: var a=function(promenna, promenna)
        if kod[i+1].include?("(")
          i+=1
        #takova deklarace: function a(promenna, promenna)
        else
          promenna = kod[i+2]
          pridejPridejPromennouDoVyseparovanych(promenna)
          i+=3
        end
        until kod[i].include?(")") 
          i+=1
          if kod[i].include?(",") 
            next
          end
          unless kod[i].include?(")")
            promenna = kod[i]
            pridejPridejPromennouDoVyseparovanych(promenna)
          end
        end
        next
      end
      
      #vyseparovani slov hned za var
      if(kod[i] == "var")
    
        #za mezerou prvni slovo
        promenna = kod[i+2]
        pridejPridejPromennouDoVyseparovanych(promenna)
        insideVarDefinition = true
        i+=3        
        next
      end
      
      #vyseparovani dalsich promennych ve var - za carkou
      if insideVarDefinition 
               
        #skoncili jsme s definovanim promenych
        if  kod[i].include?(';')
          insideVarDefinition = false
          next  
        end

        #definujeme neco dalsiho
        if kod[i].include?(',') 
          promenna = kod[i+1]
          pridejPridejPromennouDoVyseparovanych(promenna)
          i+=1
          next
        end
      end
     
      #mozna se jedna o nejakou promennou, pricteme kdyztak jeji vyskyt
      pridejMoznyVyskytPromenne(kod[i]) if i%2 == 0 and !insideVarDefinition
      i+=1
    end
  end

  # prida nalezenou promennou do pole @@vyseparovanePromenne
  def self.pridejPridejPromennouDoVyseparovanych(promenna)
    unless $nazvy_ktere_neprejmenovavat.has_key?( promenna ) 
      @@vyseparovanePromenne[:"#{promenna}"]||=0
      @@vyseparovanePromenne[:"#{promenna}"]+=1
    end
  end

  #vezme prida jako vyskyt promenne uvnitr kusu kodu - pokud uz nekde byla nadefinovana ( treba promenna.vlastnost.podvlastnost )
  def self.pridejMoznyVyskytPromenne(kus_kodu)
    promenna = kus_kodu.split(".").first
    @@vyseparovanePromenne[:"#{promenna}"]+=1 unless @@vyseparovanePromenne[:"#{promenna}"].nil?
  end

   #seradi vyseparovane promenne podle cetnosi a priradi jim co nejmensi znak
  def self.priradKPromennymNahrady
    @@vyseparovanePromenne = @@vyseparovanePromenne.sort_by{ |k, v| v }.reverse
    @@vyseparovanePromenne.map! do |polozka|
        polozka[1] = GeneratorNazvuPromennych.dajDalsiPromennou
        polozka
    end
    @@vyseparovanePromenne =  @@vyseparovanePromenne.to_h
  end

  #nahradi v KodAZbytek dlouhe nazvy promennych za kratke
  def self.projedZdrojakANahradPromenne
    zdrojak = KodAZbytek.vratSebe
    zdrojak.each_with_index do |kod, i|
      #je kod
     if i.even?       
        unless kod.nil?
          #rozdelime si na jednotlive casti, odkud budeme zjistovat - stajne jako ve vyseparujNazvyPromennych
          a = kod.split(/([^a-zA-Z0-9._]+)/) 

          #pokud nahodou mame tuto cast kodu nejak ulozenou ve vyseparovanych promennych, nahradime ji prirazenou hodnotou.
          a.map! do |cast_kodu|
            if(@@vyseparovanePromenne.key?(:"#{cast_kodu.split(".")[0]}"))
              cast_kodu.sub!(/([^\.]+)/, @@vyseparovanePromenne[:"#{cast_kodu.split(".")[0]}"])
            end
            cast_kodu
          end        
          zdrojak[i] = a.join("")
        end
      end    
    end   
    
    KodAZbytek.nastavSe(zdrojak) 
  end

end



#ma za ukol starat se o pridelovani co nejkratsich unikatnich nazvu promennych
class GeneratorNazvuPromennych
  
  #seznam znaku, ze kterych muzeme generovat
  @@zdroj_znaky = ('A'..'Z').to_a + ('a'..'z').to_a
  
  #posledni nazev ktery jsme vratili - pole znaku
  @@aktualni = []
  
  @@pocitadlo = 0
  
  #vrati dalsi co nejkratsi promennou
  def self.dajDalsiPromennou
        pridej
        @@aktualni.join ""
  end
  
  #dela ten magic za tim, jak vytvorit nejkratsi nazev
  def self.pridej(index=@@aktualni.count-1)

    if index < 0
      @@aktualni = ("A"*(@@aktualni.count+1)).split("")
      return
    end
    
    if @@aktualni[index] != "z"
      @@aktualni[index] = @@zdroj_znaky[ @@zdroj_znaky.index(@@aktualni[index]) +1 ]
    else
      @@aktualni[index] = "A"
      pridej(index-1)
    end
    
  end
  
end

#uchovava pole kodu rozdeleneho na veci, které chceme nechat tak a kod - kod je v sudych, zbytek v lichych indexech
class KodAZbytek
  @@kod_a_zbytek = []
  #index v poli @@kod_a_zbytek
  @@indexVPoli = 0
  
  def self.pridejKod(kod)
    @@indexVPoli+=1 if @@indexVPoli.odd?
    @@kod_a_zbytek[@@indexVPoli] ||= "" 
    @@kod_a_zbytek[@@indexVPoli] += kod    
  end 
  
  def self.pridejZbytek(zbytek)
    @@indexVPoli+=1 if @@indexVPoli.even?   

    @@kod_a_zbytek[@@indexVPoli] ||= "" 
    @@kod_a_zbytek[@@indexVPoli] += zbytek  

  end  
  
  def self.vratSebe
    @@kod_a_zbytek
  end
  
  def self.nastavSe(na_co)
    @kod_a_zbytek = na_co
  end
  
end
