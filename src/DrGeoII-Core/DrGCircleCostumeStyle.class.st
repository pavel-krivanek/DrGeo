Class {
	#name : #DrGCircleCostumeStyle,
	#superclass : #DrGFilledCostumeStyle,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #initialize-release }
DrGCircleCostumeStyle >> initialize [
	super initialize.
	self color: DrGStylePreference current circleColor.
	self lineStyle: DrGStylePreference current circleStyle.
	self thickness: DrGStylePreference current circleThickness.
	self fill: DrGStylePreference current circleFilled.
	self translucent: DrGStylePreference current circleTranslucent.
]
