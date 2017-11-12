Class {
	#name : #DrGWrappedSegment,
	#superclass : #DrGWrappedFinitCurve,
	#category : #DrGeoII-Core-Script
}

{ #category : #updating }
DrGWrappedSegment >> circleMark [
	costume style mark: #circle
]

{ #category : #updating }
DrGWrappedSegment >> discMark [
	costume style mark: #disc
]

{ #category : #updating }
DrGWrappedSegment >> doubleMark [
	costume style mark: #mark2
]

{ #category : #updating }
DrGWrappedSegment >> noMark [
	costume style mark: #none
]

{ #category : #updating }
DrGWrappedSegment >> simpleMark [
	costume style mark: #mark1
]

{ #category : #updating }
DrGWrappedSegment >> tripleMark [
	costume style mark: #mark3
]
