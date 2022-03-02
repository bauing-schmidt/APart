"
This is a special type of the context menu part that can accpet member groups from any part. 

Used for ribbon menu items.
"
Class {
	#name : #APContextFreeMenuPart,
	#superclass : #APContextMenuPart,
	#category : #'APart BasicParts'
}

{ #category : #testing }
APContextFreeMenuPart >> canAcceptMemberGroup: anAPMemberRefGroup [

	"do not limit exposing part"

	^ (self groupsIDs includes: anAPMemberRefGroup type)
]
