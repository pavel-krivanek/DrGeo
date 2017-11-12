"
When user selects input page, blink the cosumes related to this state. In this state the user can select items as input parameters for the macro. He can also unselect items.
"
Class {
	#name : #DrGMacroBuildToolStateInput,
	#superclass : #DrGBuildToolState,
	#category : #DrGeoII-Core-Tool
}

{ #category : #accessing }
DrGMacroBuildToolStateInput >> context: aContext [
	super context: aContext.
	self context selectInputCostume 
]

{ #category : #handling }
DrGMacroBuildToolStateInput >> handleChoice: aCostumeCollection [ 
	self context builder
		add: (aCostumeCollection collect: [ :c | c mathItem ])	
			at: (self area gridWorldPoint: self context last);
		changed: #inputName.
	self context selectInputCostume
]
