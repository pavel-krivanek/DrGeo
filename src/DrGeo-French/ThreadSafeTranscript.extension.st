Extension { #name : #ThreadSafeTranscript }

{ #category : #'*DrGeo-French' }
ThreadSafeTranscript >> affiche: unObjet [
	^ self crShow: unObjet 
]

{ #category : #'*DrGeo-French' }
ThreadSafeTranscript >> efface [
	^self clear.
]

{ #category : #'*DrGeo-French' }
ThreadSafeTranscript >> espace [
	^self space
]

{ #category : #'*DrGeo-French' }
ThreadSafeTranscript >> montre: unObjet [
	^self show: unObjet
]

{ #category : #'*DrGeo-French' }
ThreadSafeTranscript >> retourLigne [
	^ self cr
]

{ #category : #'*DrGeo-French' }
ThreadSafeTranscript >> tab: objet [
	^ self tab; show: objet
]
