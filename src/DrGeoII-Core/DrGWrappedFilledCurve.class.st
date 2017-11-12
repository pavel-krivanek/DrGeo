Class {
	#name : #DrGWrappedFilledCurve,
	#superclass : #DrGWrappedCurve,
	#category : #DrGeoII-Core-Script
}

{ #category : #updating }
DrGWrappedFilledCurve >> filled [
	costume style fill: true
]

{ #category : #updating }
DrGWrappedFilledCurve >> opaque [
	costume style translucent: false
]

{ #category : #updating }
DrGWrappedFilledCurve >> translucent [
	costume style translucent: true
]

{ #category : #updating }
DrGWrappedFilledCurve >> unfilled [
	costume style fill: false
]
