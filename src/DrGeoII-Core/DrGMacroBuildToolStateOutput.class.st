"
When user selects  output page, blink the cosumes related to this state. In this state the user can select items as output parameters for the macro. He can also unselect items.
"
Class {
	#name : #DrGMacroBuildToolStateOutput,
	#superclass : #DrGBuildToolState,
	#category : #DrGeoII-Core-Tool
}

{ #category : #handling }
DrGMacroBuildToolStateOutput >> context: aContext [
	super context: aContext.
	self context selectOutputCostume 
]

{ #category : #handling }
DrGMacroBuildToolStateOutput >> handleChoice: aCostumeCollection [ 
	self context builder
		add: (aCostumeCollection collect: [ :c | c mathItem ])
			at: (self area gridWorldPoint: self context last);
		changed: #outputName.
	self context selectOutputCostume
]
