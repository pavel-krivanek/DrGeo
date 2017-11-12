Class {
	#name : #DrGLineCostumeStyle,
	#superclass : #DrGCurveCostumeStyle,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #initialize-release }
DrGLineCostumeStyle >> initialize [
	super initialize.
	self color: DrGStylePreference current lineColor.
	self lineStyle: DrGStylePreference current lineStyle.
	self thickness: DrGStylePreference current lineThickness
]
