Class {
	#name : #DrGPolygonCostumeStyle,
	#superclass : #DrGFilledCostumeStyle,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #initialize-release }
DrGPolygonCostumeStyle >> initialize [
	super initialize.
	self color: DrGStylePreference current polygonColor.
	self lineStyle: DrGStylePreference current polygonStyle.
	self thickness: DrGStylePreference current polygonThickness.
	self fill: DrGStylePreference current polygonFilled.
	self translucent: DrGStylePreference current polygonTranslucent.
	self arrow: #makeNoArrows
]
