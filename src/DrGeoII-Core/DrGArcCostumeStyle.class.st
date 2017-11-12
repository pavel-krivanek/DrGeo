Class {
	#name : #DrGArcCostumeStyle,
	#superclass : #DrGFilledCostumeStyle,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #accessing }
DrGArcCostumeStyle >> fill: boolean [
	(fill := boolean) 
		ifTrue: [costume morph makeClosed]
		ifFalse: [costume morph makeOpen].
	self changed
]

{ #category : #initialize-release }
DrGArcCostumeStyle >> initialize [
	super initialize.
	self color: DrGStylePreference current arcColor.
	self lineStyle: DrGStylePreference current arcStyle.
	self thickness: DrGStylePreference current arcThickness.
	self arrow: DrGStylePreference current arcArrow.
	self fill: DrGStylePreference current arcFilled.
	self translucent: DrGStylePreference current arcTranslucent.
]
