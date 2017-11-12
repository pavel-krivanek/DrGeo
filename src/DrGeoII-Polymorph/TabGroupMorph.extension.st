Extension { #name : #TabGroupMorph }

{ #category : #'*DrGeoII-Polymorph' }
TabGroupMorph >> pageMorph [
	"Answer the current page morph if any."

	^ self contentMorph
		ifNotNil: [ :morph | 
			morph hasSubmorphs
				ifTrue: [ self contentMorph submorphs first ] ]
]
