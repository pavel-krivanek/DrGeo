Class {
	#name : #DrGMacroPlayToolStateSelect,
	#superclass : #DrGMacroBuildToolStateInput,
	#category : #DrGeoII-Core-Tool
}

{ #category : #handling }
DrGMacroPlayToolStateSelect >> handleChoice: aCostumeCollection [ 
	self context builder 
		add: (aCostumeCollection collect: [ :c | c mathItem ])
		at: (self area gridWorldPoint: self context last).
	self context selectInputCostume
]
