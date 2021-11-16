Extension { #name : #Color }

{ #category : #'*APart Json Support' }
Color >> initOnJson: aJsonObj [

	| hexString aColor |
	
	hexString := aJsonObj at: #hexString ifAbsent: [ self pdmError: #PdmInvalidJsonObject ].
	aColor := Color fromHexString: hexString.
	rgb := nil.
	self initializeRed: aColor red green: aColor green blue: aColor blue alpha: aColor alpha
]

{ #category : #'*APart Json Support' }
Color >> keysAndValuesForJson [

	| assocs | 
	
	assocs := { 
		#className -> self class name.
		#hexString -> self asHexString.
	}.
	
	^ assocs 
]
