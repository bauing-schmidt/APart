Class {
	#name : #APartGetTextExporter,
	#superclass : #GetTextExporter,
	#category : #'APart Localization'
}

{ #category : #translations }
APartGetTextExporter class >> exportTemplates [
	
	self new exportTemplates
]

{ #category : #exporting }
APartGetTextExporter >> addAdditionalTranslationsTo: translationRequests [

	"add translations gathered non-standard way"
]

{ #category : #exporting }
APartGetTextExporter >> appendTranslations: domains [

	| translationRequests classes methods nodes matcher | 
	translationRequests := domains at: self domain ifAbsentPut: [Dictionary new].

	classes := self classes.
	methods := ((classes flatCollect: #localMethods), (classes flatCollect: [ :c | c classSide localMethods])).
	methods do: [ :method |
		self patterns do: [ :pattern | 
			nodes := OrderedCollection new.
			matcher := RBParseTreeSearcher new matches: pattern do: [:aNode :answer | nodes add: aNode ].
			matcher executeTree: method ast.
			nodes ifNotEmpty: [ 
				nodes do: [ :node |
					| string |
					string := node arguments first value.
					(translationRequests at: string ifAbsentPut: [ OrderedCollection new ])
						add: method methodReference. ] ] ].
	] displayingProgress: 'Gathering translations'.
	self addAdditionalTranslationsTo: translationRequests.
]

{ #category : #exporting }
APartGetTextExporter >> classes [ 

	| aPartBaselineClass | 
	
	aPartBaselineClass := (Smalltalk at: #BaselineOfAPart ifAbsent: [ Smalltalk at: #BaselineOfAPartForDocumaps ]).

	^ (BaselineOfAPartCore allPackageNames flatCollect: [ :each | each asPackage classes ]),
	  (aPartBaselineClass allPackageNames flatCollect: [ :each | each asPackage classes ]).

]

{ #category : #exporting }
APartGetTextExporter >> domain [ 
	^ 'APart'
]

{ #category : #exporting }
APartGetTextExporter >> exportTemplates [
	| domains |
	domains := Dictionary new.
	self appendTranslations: domains.
	domains
		keysAndValuesDo: [:domainName :value |
			self
				export: value
				translator: nil
				domain: domainName]
]

{ #category : #exporting }
APartGetTextExporter >> patterns [

	^ {
		'`@receiver aPartTranslate: `@anything'.
		'`@receiver aPartTranslateDeferred: `@anything'.
		'`@receiver aPartTranslateDeferred: `@anything1 beforeDo: `@anything2 beforeArguments: `@anything3 afterDo: `@anything4 afterArguments: `@anything5' .		
		'`@receiver aPartRegisterTranslation: `@anything'.
	}
]
