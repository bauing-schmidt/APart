Class {
	#name : #APTreeCheckBoxColumn,
	#superclass : #APTreeColumn,
	#instVars : [
		'onActivation',
		'onDeactivation'
	],
	#category : #'APart Basic-Support'
}

{ #category : #spec }
APTreeCheckBoxColumn >> asSpecColumn [ 

	^ super asSpecColumn
		onActivation: onActivation;
		onDeactivation: onDeactivation.
]

{ #category : #api }
APTreeCheckBoxColumn >> onActivation [
	"Answer the block to be executed when a checkbox is activated (marked)"

	^ onActivation
]

{ #category : #api }
APTreeCheckBoxColumn >> onActivation: aBlock [
	"Set the block to be executed when a checkbox is activated (marked). 
	 `aBlock` receives one argument, the element in which the checkbox acts."

	onActivation := aBlock
]

{ #category : #api }
APTreeCheckBoxColumn >> onDeactivation [
	"Answer the block to be executed when a checkbox is deactivated (unmarked)"

	^ onDeactivation
]

{ #category : #api }
APTreeCheckBoxColumn >> onDeactivation: aBlock [
	"Set the block to be executed when a checkbox is deactivated (unmarked). 
	 `aBlock` receives one argument, the element in which the checkbox acts."

	onDeactivation := aBlock
]

{ #category : #spec }
APTreeCheckBoxColumn >> specColumnClass [ 

	^ SpCheckBoxTableColumn 
]
