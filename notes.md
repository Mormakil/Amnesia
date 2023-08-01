# Ruby Memos

## Préalables
- Avoir ruby d'installé
- Installer les packages JSON et Faraday

## Pour Poster
```
irb(main):019:0> Faraday.post(mapage.url,{"content": "Hello from Ruby"}.to_json)
```

## A faire
[] Créer un installateur
    - L'utilisateur installe ruby
    - Dans le fichier d'install on cjhecke pour Faraday et Json et si ca n'y est pas, on les installe
[x] Récupérer la page Memos
[] Découper les Memos
[] Aficher une interface graphique
[] Poster des memos puis recharger la page ensuite.
[] Dépot Git

## Demandes auprès de Chat GPT

### Faraday
Oui, je connais la librairie Faraday pour Ruby ! Faraday est une bibliothèque HTTP qui facilite l'envoi de requêtes HTTP depuis des applications Ruby. Elle est utilisée pour effectuer des appels à des API REST, consommer des services Web, etc.

Faraday offre une interface simple et flexible pour effectuer des requêtes HTTP en encapsulant les détails de bas niveau tels que les connexions, la gestion des cookies, les en-têtes et les méthodes HTTP. Elle vous permet également de choisir entre différents adaptateurs (par exemple, Net::HTTP, Typhoeus, Excon) pour contrôler la façon dont les requêtes sont exécutées.

Voici un exemple simple d'utilisation de Faraday pour effectuer une requête GET :

```ruby
require 'faraday'

# Créez une instance de Faraday avec l'URL de base de l'API cible
conn = Faraday.new(url: 'https://api.example.com')

# Effectuez une requête GET et récupérez la réponse
response = conn.get('/endpoint')

# Traitez la réponse
puts response.status # Code de statut HTTP (par exemple, 200 pour réussi)
puts response.headers # En-têtes de la réponse
puts response.body    # Corps de la réponse
```

Faraday permet également d'ajouter des intercepteurs, des middleware et d'autres fonctionnalités avancées pour personnaliser le comportement de la bibliothèque en fonction de vos besoins spécifiques.

Pour utiliser Faraday dans votre projet Ruby, assurez-vous d'avoir ajouté la dépendance dans votre Gemfile (ou installez-la manuellement via la ligne de commande) et requérez-la dans votre code, comme indiqué dans l'exemple ci-dessus.
