Extension { #name : #Symbol }

{ #category : #'*APart Basic' }
Symbol >> exchangePrefix: oldPrefix with: newPrefix [
	"#createNodeActivity exchangePrefix: 'create' with: 'Wfe' 
	-> #WfeNodeActivity"

	| s |
	s := WriteStream
				on: (String new: self size - oldPrefix size + newPrefix size).
	s nextPutAll: newPrefix.
	oldPrefix doWithIndex: 
			[:c :i |
			(self at: i) == c
				ifFalse: [^self]].
	oldPrefix size + 1 to: self size do: [:i | s nextPut: (self at: i)].
	^s contents asSymbol
]
