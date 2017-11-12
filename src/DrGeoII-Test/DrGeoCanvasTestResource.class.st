Class {
	#name : #DrGeoCanvasTestResource,
	#superclass : #TestResource,
	#instVars : [
		'canvas'
	],
	#category : #DrGeoII-Test
}

{ #category : #accessing }
DrGeoCanvasTestResource >> canvas [ 
	^ canvas
]

{ #category : #testing }
DrGeoCanvasTestResource >> isAvailable [ 
	^ canvas notNil
]

{ #category : #running }
DrGeoCanvasTestResource >> setUp [
	canvas := DrGeoCanvas viewLess
]

{ #category : #running }
DrGeoCanvasTestResource >> tearDown [
	canvas release.
	canvas := nil
]
