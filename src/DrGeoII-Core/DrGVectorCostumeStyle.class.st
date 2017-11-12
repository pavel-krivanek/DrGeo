Class {
	#name : #DrGVectorCostumeStyle,
	#superclass : #DrGCurveCostumeStyle,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #initialize-release }
DrGVectorCostumeStyle >> initialize [
	super initialize.
	self color: DrGStylePreference current vectorColor.
	self lineStyle: DrGStylePreference current vectorStyle.
	self thickness: DrGStylePreference current vectorThickness
]
