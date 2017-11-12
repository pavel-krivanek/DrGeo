Extension { #name : #Collection }

{ #category : #'*DrGeo-French-accessing' }
Collection >> ajouter: unObjet [

	^self add: unObjet.
]

{ #category : #'*DrGeo-French-accessing' }
Collection >> ajouter: unObjet fois: unEntier [

	unEntier foisRepete: [self ajouter: unObjet].
]

{ #category : #'*DrGeo-French-accessing' }
Collection >> ajouterSiAbsent: unObjet [

	^self addIfNotPresent: unObjet.
]

{ #category : #'*DrGeo-French-accessing' }
Collection >> ajouterTout: uneCollection [

	^self addAll: uneCollection.
]

{ #category : #'*DrGeo-French-statistics' }
Collection >> arrondir [

	^self rounded.
]

{ #category : #'*DrGeo-French-statistics' }
Collection >> auCarre [

	^self squared.
]

{ #category : #'*DrGeo-French-statistics' }
Collection >> auHasard [

	^self atRandom.
]

{ #category : #'*DrGeo-French-enumerating' }
Collection >> aucunNeVerifie: unBloc [

	^self noneSatisfy: unBloc.
]

{ #category : #'*DrGeo-French-enumerating' }
Collection >> choisir: unBloc [
	
	^self select: unBloc.
]

{ #category : #'*DrGeo-French-enumerating' }
Collection >> choisir: bloc puisFaire: unBloc [
	
	^self select: bloc thenDo: unBloc.
]

{ #category : #'*DrGeo-French-enumerating' }
Collection >> collecter: unBloc [
	
	^self collect: unBloc.
]

{ #category : #'*DrGeo-French-enumerating' }
Collection >> collecter: unBloc dans: uneCollection [
	
	^self collect: unBloc into: uneCollection.
]

{ #category : #'*DrGeo-French-enumerating' }
Collection >> collecter: unBloc puisChoisir: critere [
	^self collect: unBloc thenSelect: critere.
]

{ #category : #'*DrGeo-French-enumerating' }
Collection >> collecter: unBloc puisFaire: autreBloc [
	
	^self collect: unBloc thenDo: autreBloc.
]

{ #category : #'*DrGeo-French-conversion' }
Collection >> commeCollectionOrdonnee [

	^self asOrderedCollection.
]

{ #category : #'*DrGeo-French-conversion' }
Collection >> commeCollectionTriee [

	^self asSortedCollection.
]

{ #category : #'*DrGeo-French-conversion' }
Collection >> commeDictionnaire [

	^self asDictionary.
]

{ #category : #'*DrGeo-French-conversion' }
Collection >> commeEnsemble [

	^self asSet.
]

{ #category : #'*DrGeo-French-conversion' }
Collection >> commeSac [

	^self asBag.
]

{ #category : #'*DrGeo-French-conversion' }
Collection >> commeTableau [

	^self asArray.
]

{ #category : #'*DrGeo-French-enumerating' }
Collection >> compter: unBloc [
	
	^self count: unBloc.
]

{ #category : #'*DrGeo-French-testing' }
Collection >> contient: unObjet [
	
	^(self includes: unObjet).
]

{ #category : #'*DrGeo-French-statistics' }
Collection >> cosinus [
	
	^self degreeCos.
]

{ #category : #'*DrGeo-French-statistics' }
Collection >> ecartType [

	^self stdev.
]

{ #category : #'*DrGeo-French-statistics' }
Collection >> echantillonDeTaille: unEntier [ 

	"tirage au hasard sans remise"
	| copie ech t n |
	n := unEntier min: (self taille).
	n := n max: 0.
	copie := self collecter: [ :x | x ].
	ech := #() commeSac.
	n foisRepete: [ 
		t := copie auHasard.
		ech ajouter: t.
		copie retirer: t.
		 ].
	^ech.
]

{ #category : #'*DrGeo-French-statistics' }
Collection >> effectifs [
	"construit une table d'effectifs"

	| table clés |
	table := Dictionary new.
	clés := self asSet.
	clés do: [ :n | table at: n put: (self count: [ :t | t=n])].
	^table.
]

{ #category : #'*DrGeo-French-statistics' }
Collection >> effectifsEnClasses: unEntier [
	"construit une table pour histogramme"

	| table clés h |
	h := self etendue / unEntier.
	table := Dictionary new.
	clés := self min to: (self max - 1.0e-6) by: h.
	clés do: [ :n | table at: n put: (self count: [ :t | (t>=n) and: [t<(n+h)]])].
	^table.
]

{ #category : #'*DrGeo-French-testing' }
Collection >> estVide [

	^self isEmpty.
]

{ #category : #'*DrGeo-French-statistics' }
Collection >> etendue [

	^self range.
]

{ #category : #'*DrGeo-French-enumerating' }
Collection >> faire: unBloc [
	
	^self do: unBloc.
]

{ #category : #'*DrGeo-French-statistics' }
Collection >> frequences [
	"construit une table de fréquences"

	| table clés total |
	total := self size.
	table := Dictionary new.
	clés := self asSet.
	clés do: [ :n | table at: n put: ((self count: [ :t | t=n])/total)].
	^table.
]

{ #category : #'*DrGeo-French-statistics' }
Collection >> frequencesEnClasses: unEntier [
	"construit une table pour histogramme"

	| table clés h total |
	total := self size.
	h := self etendue / unEntier.
	table := Dictionary new.
	clés := self min to: (self max - 0.000001) by: h.
	clés do: [ :n | table at: n put: ((self count: [ :t | (t>=n) and: [t<(n+h)]])/total)].
	^table.
]

{ #category : #'*DrGeo-French-enumerating' }
Collection >> grouperPar: unBloc [

	^self groupedBy: unBloc.
]

{ #category : #'*DrGeo-French-enumerating' }
Collection >> grouperPar: unBloc lorsque: condition [

	^self groupedBy: unBloc having: condition.
]

{ #category : #'*DrGeo-French-enumerating' }
Collection >> injecter: valeur dans: unBloc [

	^self inject: valeur into: unBloc.
]

{ #category : #'*DrGeo-French-enumerating' }
Collection >> inter: uneCollection [
	
	^self intersection: uneCollection.
]

{ #category : #'*DrGeo-French-statistics' }
Collection >> inverses [

	^self reciprocal.
]

{ #category : #'*DrGeo-French-statistics' }
Collection >> mediane [

	^self median.
]

{ #category : #'*DrGeo-French-statistics' }
Collection >> moyenne [

	^self average.
]

{ #category : #'*DrGeo-French-statistics' }
Collection >> opposes [

	^self negated.
]

{ #category : #'*DrGeo-French-statistics' }
Collection >> premierQuartile [

	^(self commeCollectionTriee Q1).
]

{ #category : #'*DrGeo-French-statistics' }
Collection >> puissances: unExposant [

	^self raisedTo: unExposant.
]

{ #category : #'*DrGeo-French-statistics' }
Collection >> racines [

	^self sqrt.
]

{ #category : #'*DrGeo-French-enumerating' }
Collection >> reduire: unBloc [

	^self reduce: unBloc.
]

{ #category : #'*DrGeo-French-enumerating' }
Collection >> regrouper: unBloc [
	
	^self gather: unBloc.
]

{ #category : #'*DrGeo-French-enumerating' }
Collection >> rejeter: unBloc [
	
	^self reject: unBloc.
]

{ #category : #'*DrGeo-French-enumerating' }
Collection >> rejeter: bloc puisFaire: unBloc [
	
	^self reject: bloc thenDo: unBloc.
]

{ #category : #'*DrGeo-French-accessing' }
Collection >> retirer: unBloc [

	^self remove: unBloc.
]

{ #category : #'*DrGeo-French-accessing' }
Collection >> retirerTousLorsque: unBloc [

	^self removeAllSuchThat: unBloc.
]

{ #category : #'*DrGeo-French-accessing' }
Collection >> retirerTout [

	^self removeAll.
]

{ #category : #'*DrGeo-French-accessing' }
Collection >> retirerToutDans: uneCollection [

	^self removeAll: uneCollection.
]

{ #category : #'*DrGeo-French-statistics' }
Collection >> sinus [
	
	^self degreeSin.
]

{ #category : #'*DrGeo-French-statistics' }
Collection >> somme [

	^self sum.
]

{ #category : #'*DrGeo-French-statistics' }
Collection >> taille [

	^self size.
]

{ #category : #'*DrGeo-French-statistics' }
Collection >> total [

	^self sum.
]

{ #category : #'*DrGeo-French-enumerating' }
Collection >> tousVerifient: unBloc [

	^self allSatisfy: unBloc.
]

{ #category : #'*DrGeo-French-accessing' }
Collection >> trier [
	
	^self sorted.
]

{ #category : #'*DrGeo-French-enumerating' }
Collection >> trierSelon: unBloc [
	
	^self sorted: unBloc.
]

{ #category : #'*DrGeo-French-statistics' }
Collection >> troisiemeQuartile [

	^self commeCollectionTriee Q3.
]

{ #category : #'*DrGeo-French-enumerating' }
Collection >> unVerifie: unBloc [

	^self anySatisfy: unBloc.
]
