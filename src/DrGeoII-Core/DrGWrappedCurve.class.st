Class {
	#name : #DrGWrappedCurve,
	#superclass : #DrGWrappedItem,
	#category : #DrGeoII-Core-Script
}

{ #category : #updating }
DrGWrappedCurve >> dashed [
	costume style lineStyle: #dash


]

{ #category : #updating }
DrGWrappedCurve >> dotted [
	costume style lineStyle: #dot
]

{ #category : #updating }
DrGWrappedCurve >> large [
	costume style thickness: #large
]

{ #category : #updating }
DrGWrappedCurve >> normal [
	costume style thickness: #medium
]

{ #category : #updating }
DrGWrappedCurve >> plain [
	costume style lineStyle: #plain

]

{ #category : #updating }
DrGWrappedCurve >> small [
	costume style thickness: #small
]
