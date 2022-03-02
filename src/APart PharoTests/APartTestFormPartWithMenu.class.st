Class {
	#name : #APartTestFormPartWithMenu,
	#superclass : #APartTestFormPart,
	#instVars : [
		'actionMenu'
	],
	#category : #'APart PharoTests-Support'
}

{ #category : #accessing }
APartTestFormPartWithMenu >> actionMenu [ 
	
	^ actionMenu
]

{ #category : #accessing }
APartTestFormPartWithMenu >> initializeValues [

	super initializeValues.
	
	actionMenu := APMenuFromEnumerationPart onPart: self key: #actionMenu.
	actionMenu targetInterface: partInterface.
]
