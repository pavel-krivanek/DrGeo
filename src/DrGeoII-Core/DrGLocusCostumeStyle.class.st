Class {
	#name : #DrGLocusCostumeStyle,
	#superclass : #DrGCurveCostumeStyle,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #initialize-release }
DrGLocusCostumeStyle >> initialize [
	super initialize.
	self color: DrGStylePreference current locusColor.
	self lineStyle: DrGStylePreference current locusStyle.
	self thickness: DrGStylePreference current locusThickness
]
