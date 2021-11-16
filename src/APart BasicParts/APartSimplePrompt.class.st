"
APartPrompt ist die abstrakte Superklasse aller Parts, die modale Verzweigungen darstellen.


"
Class {
	#name : #APartSimplePrompt,
	#superclass : #APart,
	#instVars : [
		'title',
		'message'
	],
	#category : #'APart BasicParts'
}

{ #category : #'initialize-release' }
APartSimplePrompt >> basicInitialize [

	super basicInitialize.
	title := ''
]

{ #category : #'initialize-release' }
APartSimplePrompt >> defaultPromptSelector [

	self subclassResponsibility
]

{ #category : #'API testing' }
APartSimplePrompt >> isPromptable [

	^true
]

{ #category : #'API testing' }
APartSimplePrompt >> isSimplePrompt [

	^true
]

{ #category : #accessing }
APartSimplePrompt >> message [

	^message
]

{ #category : #accessing }
APartSimplePrompt >> message: anObject [

	message := anObject
]

{ #category : #API }
APartSimplePrompt >> promptExecutor [
	"Fallback für Szenarien, in denen ein einfacher GUI-Prompt ohne Parent und damit auch ohne Parent-GUI aufgerufen wird"
	
	^clientRegistry defaultPromptExecutor
]

{ #category : #accessing }
APartSimplePrompt >> title [

	^title
]

{ #category : #accessing }
APartSimplePrompt >> title: anObject [

	title := anObject
]

{ #category : #accessing }
APartSimplePrompt >> value [
	"Das #value-Protokoll wird Prompt-übergreifend einheitlich unterstützt, auch wenn ein Prompt von Natur aus keinen value kennt (z.B. ein YesNo-Prompt)."

	^nil
]
