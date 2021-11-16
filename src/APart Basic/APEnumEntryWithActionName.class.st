Class {
	#name : #APEnumEntryWithActionName,
	#superclass : #APEnumEntry,
	#instVars : [
		'actionName'
	],
	#category : #'APart Basic-Enumeration'
}

{ #category : #accessing }
APEnumEntryWithActionName >> actionName [
	^ actionName
]

{ #category : #accessing }
APEnumEntryWithActionName >> actionName: anObject [
	actionName := anObject
]
