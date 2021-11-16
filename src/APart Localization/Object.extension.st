Extension { #name : #Object }

{ #category : #'*APart Localization' }
Object >> aPartRegisterTranslation: aString [

	"register translation only so it can be gathered by the GetText from the source code. 
	Does not do any immedaite action"
	
	^ aString
]

{ #category : #'*APart Localization' }
Object >> aPartTranslateDeferred: aString [

	^ APartDeferredTranslation for: aString in: 'APart'
]

{ #category : #'*APart Localization' }
Object >> aPartTranslateDeferred: aString beforeDo: beforeBlock beforeArguments: beforeArguments afterDo: afterBlock afterArguments: afterArguments [

	^ (APartDeferredTranslationExtended for: aString in: 'APart')
		beforeBlock: beforeBlock;
		beforeArguments: beforeArguments;
		afterBlock: afterBlock;
		afterArguments: afterArguments
]

{ #category : #'*APart Localization' }
Object >> aPartTranslateDeferredWith: aString [

	"The same as aPartTranslateDeferred: but does not gather translation."
	
	^ APartDeferredTranslation for: aString in: 'APart'
]
