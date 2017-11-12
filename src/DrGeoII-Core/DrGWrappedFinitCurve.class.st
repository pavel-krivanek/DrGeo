Class {
	#name : #DrGWrappedFinitCurve,
	#superclass : #DrGWrappedCurve,
	#category : #DrGeoII-Core-Script
}

{ #category : #updating }
DrGWrappedFinitCurve >> backArrow [
	costume style arrow: #makeBackArrow
]

{ #category : #updating }
DrGWrappedFinitCurve >> bothArrows [
	costume style arrow: #makeBothArrows
]

{ #category : #updating }
DrGWrappedFinitCurve >> forwardArrow [
	costume style arrow: #makeForwardArrow
]
