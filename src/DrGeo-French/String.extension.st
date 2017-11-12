Extension { #name : #String }

{ #category : #'*DrGeo-French' }
String >> combienCorrespond: unString [
	^self howManyMatch: unString
]

{ #category : #'*DrGeo-French' }
String >> commeNombre [
	^ self asNumber
]

{ #category : #'*DrGeo-French' }
String >> contient: unString [
	^self includesSubString: unString
]

{ #category : #'*DrGeo-French' }
String >> correspond: unTexte [
"
'toute*' correspond: 'Toute' -> true
'toute#' correspond: 'Toute' -> false
'toute#' correspond: 'Toutete' -> false
'toute*' correspond: 'Toutete' -> true
'toute#' correspond: 'Toutes' -> true
"	
	^self match: unTexte
]

{ #category : #'*DrGeo-French' }
String >> enMajuscule [
	^self asUppercase
]

{ #category : #'*DrGeo-French' }
String >> enMinuscule [
	^self asLowercase
]

{ #category : #'*DrGeo-French' }
String >> formate: uneCollection [
	^ self format: uneCollection
]

{ #category : #'*DrGeo-French' }
String >> lettrine [
	^self capitalized
]
