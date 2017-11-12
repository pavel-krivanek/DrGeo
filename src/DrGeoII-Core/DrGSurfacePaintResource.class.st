"
A DrGSurfacePaintResource provides AthensSurface based paints, that have to
be reloaded prior use in every new Smalltalk session.
"
Class {
	#name : #DrGSurfacePaintResource,
	#superclass : #DrGPerSessionResource,
	#instVars : [
		'data',
		'surfaceProvider'
	],
	#category : #DrGeoII-Core-Resources
}

{ #category : #'instance creation' }
DrGSurfacePaintResource class >> forSurfaceProvider: aSurfaceProvider withData: data [
	^ self new surfaceProvider: aSurfaceProvider;  
		data: data; 
		yourself
]

{ #category : #accessing }
DrGSurfacePaintResource >> asForm [
	^ data
]

{ #category : #accessing }
DrGSurfacePaintResource >> createResource [
	^ surfaceProvider surface createFormPaint: data form
]

{ #category : #accessing }
DrGSurfacePaintResource >> data: anObject [
	data := anObject
]

{ #category : #accessing }
DrGSurfacePaintResource >> extent [
	^ data extent
]

{ #category : #initialize }
DrGSurfacePaintResource >> initialize [
	super initialize.

	data := nil.
	surfaceProvider := nil.
]

{ #category : #accessing }
DrGSurfacePaintResource >> surfaceProvider: anObject [
	surfaceProvider := anObject
]
