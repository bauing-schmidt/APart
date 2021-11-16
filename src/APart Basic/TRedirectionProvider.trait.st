"
APart framework provides redirections on parts. However, sometimes may be useful to use a redirection on objects that are not parts. I am a trait for such classes. 

If I am asked to follow a path for redirection, I tranlsate it to #perform: on myself.
"
Trait {
	#name : #TRedirectionProvider,
	#category : #'APart Basic-Errors'
}

{ #category : #'API testing' }
TRedirectionProvider >> subPartOrAspectAt: p ifNone: aBlock [

	^ (self respondsTo: p) 
		ifTrue: [ self perform: p ]
		ifFalse: [ aBlock value ]
]

{ #category : #'API testing' }
TRedirectionProvider >> supportsAPartRedirection [

	^ true
]
