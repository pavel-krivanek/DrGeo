"
A DrGPerSessionResource  manages access to a
resource that is only valid during one Smalltalk session. If  after the shutdown and startup the 
session changed, the resource has to be reloaded.


"
Class {
	#name : #DrGPerSessionResource,
	#superclass : #Object,
	#instVars : [
		'session',
		'resource'
	],
	#category : #DrGeoII-Core-Resources
}

{ #category : #'session management' }
DrGPerSessionResource >> checkSession [
	session = Smalltalk session ifFalse: [self reloadResource]
]

{ #category : #accessing }
DrGPerSessionResource >> getCheckedResource [
	self checkSession.
	^ resource
]

{ #category : #initialize }
DrGPerSessionResource >> initialize [
	super initialize.

	session := nil.
	resource := nil.
]

{ #category : #'session management' }
DrGPerSessionResource >> reloadResource [
	resource := self createResource.
	session := Smalltalk session.
]
