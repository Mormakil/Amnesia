require 'faraday' #paquet de requêtes http
require 'json' #librairie de gestion du JSON

class Unmemo

  def initialize(proprietaire, contenu, nouveau)
    @modifie = false
    @nouveau = nouveau
    @proprietaire = proprietaire
    @contenu = contenu
  end
  
  def contenu #Affichage momentané de contenu
    puts @contenu
  end

  def proprietaire #Affichage momentané de proprietaire
    puts @proprietaire
  end

  def modifie? #Indique si un Memo a été modifié
    @modifie
  end

  def nouveau? #Indique si un contenu est nouveau
    @nouveau
  end

  def nouveaucontenu(contenu) #Modification d'un contenu
    @contenu = contenu
    @modifie = true
  end

  def transforme #méthode qui retourne la forme JSON du memo
    {"content": @contenu}.to_json
  end

end

class Pagememo

  attr_reader :url #l'url, au cas où on voudrait l'afficher de nouveau
  attr_reader :pilememo #une pile d'objet Unmemo
  attr_reader :statutrequete #savoir si on a réussi à accéder au site

  def initialize(url) #On poura rajouter une mémoire locale en cas de perte de connexion internet
    @url = url
    response = Faraday.get(url, {a: 0}, {'Accept' => 'application/json'})# requête GET via application
    
    if (response.status == 200)
      page = JSON.parse(response.body, symbolize_names: true) #récupération de la page web sous forme de tableau de Hash
      @statutrequete = true
    else 
      @statutrequete = false
    end
    @pilememo = Array.new #intialisation de la pile de memos
    montableaudehachage = page[:data]
    montableaudehachage.each {|h| @pilememo.push(Unmemo.new(h[:creatorName],h[:content],false))} #remplissage de la pile de Memos.
    ## Ici rajouter le parsage de la sauvegarde locale
  end

  def raffraichir # Cette méthode renvoie tous les nouveaux memos et les memos modifiés. Si elle échoue, elle les stocke dans un fichier texte jusque la prochaine connection.
    @page = JSON.parse((Faraday.get(@url, {a: 0}, {'Accept' => 'application/json'})).body[:data], symbolize_names: true) #récupération de la page web sous forme de Hash
  end

  def nouveaupost(nouveaumemo) #ajoute un memo à la pile de Memo et le poste sur le serveur
    @pilememo.push(nouveaumemo)
    jsontemporaire = nouveaumemo.transforme #
    Faraday.post(@url,jsontemporaire)
  end

end

#{:id=>4, :rowStatus=>"NORMAL", :creatorId=>1, :createdTs=>1690882172, :updatedTs=>1690882172, :displayTs=>1690882172, :content=>"Apparemment, il est encore plus simple d'utiliser l'API de #memos que ce que l'on croit !", :visibility=>"PRIVATE", :pinned=>false, :creatorName=>"mathieu", :resourceList=>[], :relationList=>[]}
#{:id=>3, :rowStatus=>"NORMAL", :creatorId=>1, :createdTs=>1690881985, :updatedTs=>1690881985, :displayTs=>1690881985, :content=>"Hello #memos from Insomnia", :visibility=>"PRIVATE", :pinned=>false, :creatorName=>"mathieu", :resourceList=>[], :relationList=>[]}
#{:id=>1, :rowStatus=>"NORMAL", :creatorId=>1, :createdTs=>1689034375, :updatedTs=>1689184701, :displayTs=>1689034375, :content=>"[x] Eau\n[x] Caillaud\n[] accepter devis plomberie + joints à demander\n[] renégocier électricité \n[] relancer expert et menacer assurance\n[] avocat", :visibility=>"PRIVATE", :pinned=>false, :creatorName=>"mathieu", :resourceList=>[], :relationList=>[]}
#{:id=>2, :rowStatus=>"NORMAL", :creatorId=>1, :createdTs=>1687686666, :updatedTs=>1690881817, :displayTs=>1687686666, :content=>"Test de l'API RESTFUL", :visibility=>"PROTECTED", :pinned=>false, :creatorName=>"mathieu", :resourceList=>[], :relationList=>[]}


#puts memos_object[:data] #affichage de la page memos
