Class {
	#name : #DrGValueMorph,
	#superclass : #DrGStringMorph,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #editing }
DrGValueMorph >> acceptContents [
	[costume mathItem valueItem: contents asNumber] 
		on: Error
		do: [costume view alert: 'I can''t read your value.' translated.
			costume mathItem valueItem: 0].
	self contents: costume roundedValueString.
]

{ #category : #events-processing }
DrGValueMorph >> handleMouseDown: anEvent [
	^false
]

{ #category : #'*DrGeoII-Core-testing' }
DrGValueMorph >> isMorphCostume [
	^true
]

{ #category : #editing }
DrGValueMorph >> lostFocusWithoutAccepting [
	"no update in that case"
	^ self
]
