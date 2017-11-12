Class {
	#name : #DrGEtoys,
	#superclass : #DrGPlateform,
	#category : #DrGeoII-Core-Resources
}

{ #category : #initialize-release }
DrGEtoys >> initialize [ 
	canWeDisplayLoader := false
]

{ #category : #testing }
DrGEtoys >> isEtoys [
	^ true
]
