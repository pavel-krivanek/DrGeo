Class {
	#name : #DrGRayCostumeStyle,
	#superclass : #DrGCurveCostumeStyle,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #initialize-release }
DrGRayCostumeStyle >> initialize [
	super initialize.
	self color: DrGStylePreference current rayColor.
	self lineStyle: DrGStylePreference current rayStyle.
	self thickness: DrGStylePreference current rayThickness
]
