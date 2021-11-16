"
APHeadlessPromptExecutor implementiert Prompts auf Basis von Headless-Clients.

"
Class {
	#name : #APHeadlessPromptExecutor,
	#superclass : #APPromptExecutor,
	#category : #'APart Basic-Prompt'
}

{ #category : #API }
APHeadlessPromptExecutor class >> clientTypes [

	^#(#Headless)
]
